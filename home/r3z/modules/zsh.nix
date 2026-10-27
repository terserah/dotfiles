{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake /data/dotfiles#devz0ne";
    };

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
        "z"
      ];

      theme = "philips";
    };

    initContent = ''
      # npm global
      export PATH="$HOME/.npm-global/bin:$PATH"

      # OpenCode
      export PATH="$HOME/.opencode/bin:$PATH"

      # Android SDK
      export ANDROID_HOME="/data/Apps/sdk/android"
      export ANDROID_SDK_ROOT="$ANDROID_HOME"

      # Android SDK tools
      export PATH="$ANDROID_HOME/platform-tools:$PATH"
      export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
      export PATH="$ANDROID_HOME/build-tools/36.0.0:$PATH"
      export PATH="$ANDROID_HOME/emulator:$PATH"

      # Android NDK
      export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/28.2.13676358"

      # Flutter SDK
      export FLUTTER_ROOT="/data/Apps/sdk/flutter"
      export PATH="$FLUTTER_ROOT/bin:$PATH"
    '';
  };
}
