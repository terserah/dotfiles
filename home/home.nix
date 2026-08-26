{ config, pkgs, ... }:

{
  home.username = "tabun";
  home.homeDirectory = "/home/tabun";

  home.stateVersion = "26.05";

  imports = [
    ./modules/rofi.nix
    ./modules/kitty.nix
    ./modules/obs.nix
    ./modules/tmux.nix
    ./modules/hyprland
    ./modules/zsh
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.datagrip
    heroic
    opencode
    thunar
    vscode
  ];

  programs.git = {
    enable = true;

    settings = {
      user.name = "Rezky Yuranda";
      user.email = "yurandarezky@atmaluhur.ac.id";

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#catnux";
      update = "nix flake update ~/dotfiles";
    };
  };

  programs.home-manager.enable = true;
}

