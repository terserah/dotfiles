{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/gtk.nix
    ../../modules/home/kitty.nix
    ../../modules/home/noctalia.nix
    ../../modules/home/rofi.nix
    ../../modules/home/session.nix
    ../../modules/home/tmux.nix
  ];

  home.username = "r3z";
  home.homeDirectory = "/home/r3z";

  home.packages = with pkgs; [
    # android-studio
    # jetbrains.datagrip
    opencode
    nautilus
    vscode
  ];

  xdg.configFile = {
    # Tautkan seluruh folder
    # "hypr".source = ../../dotfiles/hypr;
    "niri/config.kdl".source = ../../dotfiles/niri/config.kdl;
    "waybar".source = ../../dotfiles/waybar;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
