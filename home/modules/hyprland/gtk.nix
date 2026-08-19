{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tela-icon-theme
    bibata-cursors
  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;

    # theme = {
    #   package = pkgs.flat-remix-gtk;
    #   name = "Flat-Remix-GTK-Grey-Darkest";
    # };


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