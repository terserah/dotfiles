{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        " /data/Pictures/cucumber.png"
      ];
      wallpaper = [
        # By display
        # {
        #   monitor = "DP-2";
        #   path = "~/wallpapers/wallpaper2.jpg";
        # }
        # By default/fallback
        {
          monitor = "";
          path = " /data/Pictures/cucumber.png"; 
        }
      ];
    };
  };

}
