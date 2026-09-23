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
    ../../modules/nixos/services/libvirtd.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/gaming.nix

    # ../../packages/flutter.nix  # disabled sementara
  ];

  networking.hostName = "catnux";

  # programs.flutter = {
  #   enable = true;
  #   user = "r3z";
  #   addToKvmGroup = true;
  # }; # disabled sementara

  users.users.r3z = {
    isNormalUser = true;
    description = "r3z";
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "audio"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
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
  programs.nix-ld.enable = true;
  system.stateVersion = "24.11"; 
}