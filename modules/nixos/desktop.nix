{ pkgs, ... }:
{
  programs.niri.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor.size = 24;
      keyboard.layout = "us";
      output = {
        name = "eDP-1";
        scale = 1;
      };
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  programs.firefox.enable = true;
}
