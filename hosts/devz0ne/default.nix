{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/game.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/packages.nix
  ];

  networking.hostName = "devz0ne";
  time.timeZone = "Asia/Jakarta";

  system.stateVersion = "26.05";
}
