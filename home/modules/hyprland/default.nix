{ config, pkgs, ... }:

{
  imports = [
    ./config.nix
    ./gtk.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpolkitagent.nix
    ./session.nix
    ./waybar
  ];

  home.packages = with pkgs; [
    # nautilus
    networkmanagerapplet
    jq
    pavucontrol
    wlogout
    slurp
    grim
    swappy
    yazi
  ];
  home.file.".local/bin/present-mode" = {
    source = ./scripts/present-mode.sh;
    executable = true;
  };
  
}
