{ config, lib, pkgs, ... }:
{
  programs.niri.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    # For niri
    alacritty
    fuzzel
    jq
    swaylock
    swayidle
    swaybg
    wl-mirror
  ];

  # File Picker
  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
