{ config, lib, pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
