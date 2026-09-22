{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/core
    ../../modules/nixos/desktop/audio.nix
    ../../modules/nixos/desktop/dm.nix
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/niri.nix
    ../../modules/nixos/hardware/amd.nix
    ../../modules/nixos/hardware/power.nix
    ../../modules/nixos/programs/apps.nix
    ../../modules/nixos/services/docker.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/gaming.nix
  ];

  networking.hostName = "catnux";

  users.users.r3z = {
    isNormalUser = true;
    description = "r3z";
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    # For niri
    alacritty
    fuzzel
    swaylock
    swayidle
    swaybg

    # NetworkManagerApplet
    networkmanagerapplet

    # For hosts
    distrobox
    dnsmasq
    bibata-cursors
    docker-compose
    vim
    wget
    libX11
  ];

  programs.zsh.enable = true;
  system.stateVersion = "24.11"; 
}