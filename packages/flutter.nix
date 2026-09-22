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
      androidSdk
      jdk17
      firebase-tools
    ];

    environment.variables = {
      ANDROID_HOME =
        "${androidSdk}/libexec/android-sdk";

      ANDROID_SDK_ROOT =
        "${androidSdk}/libexec/android-sdk";

      JAVA_HOME =
        pkgs.jdk17.home;
    };

    nixpkgs.config = {
      android_sdk.accept_license = true;
      allowUnfree = true;
    };

    environment.shellInit = ''
      export PATH="$PATH:${androidSdk}/libexec/android-sdk/platform-tools"
      export PATH="$PATH:${androidSdk}/libexec/android-sdk/cmdline-tools/latest/bin"
      export PATH="$PATH:${androidSdk}/libexec/android-sdk/emulator"
      export PATH="$PATH:$HOME/.pub-cache/bin"
    '';

    users.users.${cfg.user}.extraGroups =
      optional cfg.addToKvmGroup "kvm";
  };
}
