{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.flutter;

  androidComposition =
    pkgs.androidenv.composeAndroidPackages {
      platformVersions = [
        "36"
      ];

      buildToolsVersions = [
        "36.0.0"
      ];

      abiVersions = [
        "x86_64"
      ];

      includeEmulator = true;

      includeSystemImages = true;

      systemImageTypes = [
        "google_apis_playstore"
      ];

      includeSources = false;

      extraLicenses = [
        "android-sdk-license"
        "android-sdk-preview-license"
        "intel-android-extra-license"
        "intel-android-sysimage-license"
      ];
    };

  androidSdk = androidComposition.androidsdk;

  # Flutter expects cmdline-tools/latest, but androidenv provides
  # cmdline-tools/<version> (e.g. 22.0). The store path is read-only,
  # so we need a writable wrapper that adds the `latest` symlink.
  androidSdkPatched = pkgs.runCommand "android-sdk-patched" { } ''
    mkdir -p $out/libexec/android-sdk
    cp -r ${androidSdk}/libexec/android-sdk/* $out/libexec/android-sdk/
    chmod -R u+w $out/libexec/android-sdk
    if [ -d "$out/libexec/android-sdk/cmdline-tools/22.0" ] && [ ! -e "$out/libexec/android-sdk/cmdline-tools/latest" ]; then
      ln -s 22.0 $out/libexec/android-sdk/cmdline-tools/latest
    fi
    # Fallback: handle any version if 22.0 not present
    if [ ! -e "$out/libexec/android-sdk/cmdline-tools/latest" ]; then
      ver=$(ls $out/libexec/android-sdk/cmdline-tools/ 2>/dev/null | head -n1)
      if [ -n "$ver" ] && [ -d "$out/libexec/android-sdk/cmdline-tools/$ver" ]; then
        ln -s "$ver" $out/libexec/android-sdk/cmdline-tools/latest
      fi
    fi
    chmod -R a-w $out/libexec/android-sdk
  '';

in {
  options.programs.flutter = {
    enable = mkEnableOption "Flutter development environment";

    addToKvmGroup = mkEnableOption
      "Add user to KVM group";

    user = mkOption {
      type = types.str;
      description = "Flutter development user";
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      flutter
      android-studio
      androidSdkPatched
      jdk17
      firebase-tools
    ];

    # Required for androidenv to download licensed binaries.
    # NOTE: This must be evaluated before `pkgs` is instantiated.
    # Keep a global copy in modules/nixos/core/nix.nix as well.
    nixpkgs.config = {
      android_sdk.accept_license = true;
      allowUnfree = true;
    };

    # Enable adb udev rules so `flutter doctor` sees connected devices
    # (android-udev-rules is deprecated, programs.adb.enable provides uaccess now)
    programs.adb.enable = true;

    environment.variables = {
      ANDROID_HOME = "${androidSdkPatched}/libexec/android-sdk";
      ANDROID_SDK_ROOT = "${androidSdkPatched}/libexec/android-sdk";
      ANDROID_NDK_ROOT = "${androidSdkPatched}/libexec/android-sdk/ndk-bundle";
      JAVA_HOME = pkgs.jdk17.home;
      # Avoid flutter picking up wrong chrome
      CHROME_EXECUTABLE = lib.mkDefault "${pkgs.chromium}/bin/chromium";
    };

    environment.sessionVariables = {
      ANDROID_HOME = "${androidSdkPatched}/libexec/android-sdk";
      ANDROID_SDK_ROOT = "${androidSdkPatched}/libexec/android-sdk";
    };

    environment.shellInit = ''
      export PATH="$PATH:${androidSdkPatched}/libexec/android-sdk/platform-tools"
      export PATH="$PATH:${androidSdkPatched}/libexec/android-sdk/cmdline-tools/latest/bin"
      export PATH="$PATH:${androidSdkPatched}/libexec/android-sdk/emulator"
      export PATH="$PATH:$HOME/.pub-cache/bin"
    '';

    users.users.${cfg.user}.extraGroups =
      optional cfg.addToKvmGroup "kvm" ++ [ "adbusers" ];
  };
}
