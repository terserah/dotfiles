{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      terminal.shell = {
        program = "sh";
        args = [ "-c" "tmux attach || tmux" ];
      };

      window = {
        opacity = 0.95;
        padding = {
          x = 6;
          y = 2;
        };
        decorations = "None";
      };

      font = {
        size = 10.3;

        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };

      cursor.style = {
        shape = "Beam";
        blinking = "Never";
      };

      colors = {
        primary = {
          background = "#141c20";
          foreground = "#e6dfd0";
        };

        cursor = {
          text = "#141c20";
          cursor = "#ca7a3c";
        };

        selection = {
          text = "#f2ece0";
          background = "#2c3d43";
        };

        normal = {
          black = "#1d272b";
          red = "#b0513b";
          green = "#7fa06b";
          yellow = "#d2a054";
          blue = "#5da3b3";
          magenta = "#8e6b7e";
          cyan = "#5da198";
          white = "#b3aa99";
        };

        bright = {
          black = "#4c5e63";
          red = "#d97a52";
          green = "#9cbd85";
          yellow = "#e9bd6d";
          blue = "#82c2d0";
          magenta = "#ac8c9d";
          cyan = "#80c0b5";
          white = "#f0eadb";
        };
      };
    };
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    tmux
  ];
}
