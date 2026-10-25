{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  virtualisation.docker.enable = true;
}
