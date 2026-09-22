{ config, lib, pkgs, ... }:
{
  time.timeZone = "Asia/Jakarta";
  zramSwap.enable = true;
}
