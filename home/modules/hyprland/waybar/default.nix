{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      height = 30;
      spacing = 0;

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "memory"
        "idle_inhibitor"
        "backlight"
        "pulseaudio"
        # "cpu"
        # "memory"
        # "temperature"
        "battery"
        "tray"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = false;
        warp-on-scroll = false;
        # format = "{name}: {icon}";
        format = "{name}";

        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          urgent = "";
          focused = "";
          default = "";
        };
      };

      "hyprland/window" = {
        format = "{}";
        icon = true;
        icon-size = 16;
        max-length = 60;
        separate-outputs = true;
      };

      "keyboard-state" = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";

        format-icons = {
          locked = "";
          unlocked = "";
        };
      };

      idle_inhibitor = {
        format = "{icon} ";

        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      tray = {
        spacing = 10;
      };

      clock = {
        format = "{:%H:%M · %d %b}";
        format-alt = "{:%a, %d %b %Y}";

        tooltip-format = ''
          <span weight=\"bold\">{:%A, %d %B %Y}</span>\n\n<tt>{calendar}</tt>
        '';

        on-click-right = "gnome-calendar";
      };

      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };

      memory = {
        interval = 5;
        format = "{avail:0.0f} G";
        tooltip-format = "{used:0.0f} G / {total:0.0f} G";
      };

      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };

      backlight = {
        format = "{icon}  {percent}%";

        format-icons = [
          "󰃞"
          "󰃟"
          "󰃠"
        ];
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };

        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰂄 {capacity}%";
        format-full = "󰁹 {capacity}%";

        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };

      "battery#bat2" = {
        bat = "BAT2";
      };

      "power-profiles-daemon" = {
        format = "{icon}";
        tooltip-format = ''
          Power profile: {profile}
          Driver: {driver}
        '';
        tooltip = true;

        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      network = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} ";
        tooltip-format = "{ifname} via {gwaddr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰖁";

        format-icons = {
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];

          headphone = "󰋋";
          headset = "󰋎";
          hands-free = "󰋎";
          phone = "󰏲";
          portable = "󰏲";
          car = "󰄋";
        };

        on-click = "pavucontrol";
      };

      "custom/media" = {
        format = "{icon} {text}";
        return-type = "json";
        max-length = 40;

        format-icons = {
          spotify = "";
          default = "🎜";
        };

        escape = true;
        exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
      };

      "custom/power" = {
        format = "⏻";
        tooltip = false;
        on-click = "wlogout";
      };
    }];
    style = builtins.readFile ./style.css;
    
  };

}
