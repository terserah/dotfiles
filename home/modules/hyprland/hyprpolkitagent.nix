{ config, pkgs, ... }:
{
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";

      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";

      Restart = "on-failure";
      RestartSec = 2;

      # penting buat debug
      Environment = [
        "QT_QPA_PLATFORM=wayland"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

}