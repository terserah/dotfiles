{ pkgs, ... }:
{
  home.sessionVariables = {
    ANDROID_HOME = "/data/Apps/sdk/android";
    ANDROID_SDK_ROOT = "/data/Apps/sdk/android";
  };

  home.sessionPath = [
    "/data/Apps/sdk/flutter/bin"
    "/data/Apps/sdk/android/platform-tools"
    "/data/Apps/sdk/android/cmdline-tools/latest/bin"
  ];
}