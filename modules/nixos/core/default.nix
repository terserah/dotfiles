{ config, lib, pkgs, ... }:
{
  imports = [
    ./networking.nix
    ./nix.nix
    ./system.nix
  ];
}
