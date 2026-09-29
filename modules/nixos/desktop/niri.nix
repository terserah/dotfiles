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
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # For niri
    alacritty
    fuzzel
    jq
    libX11
    swaylock
    swayidle
    swaybg
    wl-mirror
    xwayland-satellite
  ];

  # File Picker
  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };

  environment.variables = {
    GDK_SCALE = "1.25";
    QT_SCALE_FACTOR = "1.25";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
