{ ... }:
{
  imports = [
    ./modules/alacritty.nix
    ./modules/gtk.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/packages.nix
  ];

  home.username = "r3z";
  home.homeDirectory = "/home/r3z";

  home.stateVersion = "26.05";
}
