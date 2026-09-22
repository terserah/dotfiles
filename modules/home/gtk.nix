{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tela-icon-theme
    bibata-cursors
    gnome-themes-extra
  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-dark";
    };

    font = {
      name = "Inter";
      size = 11;
    };

    gtk4.theme = config.gtk.theme;
  };
}