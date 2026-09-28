{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.3;
    };

    settings = {
      shell = "tmux new-session -A -s main";
      # Fonts
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "never";

      # Window
      background_opacity = "0.90";
      window_padding_width = 3;
      confirm_os_window_close = 0;
      hide_window_decorations = "yes";

      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = "1.8";
      cursor_blink_interval = 0;

      # Scroll
      scrollback_lines = 15000;

      # Bell
      enable_audio_bell = "no";
      visual_bell_duration = 0;

      # Clipboard
      copy_on_select = "yes";

      # Performance
      sync_to_monitor = "yes";
      repaint_delay = 10;
      input_delay = 2;

      # Tab
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_separator = " ";

      # Theme (Everforest & Night Park Slate Palette)
      background = "#13191c"; # Slate gelap sejajar tone jalan/malam
      foreground = "#d0d7d1"; # Putih-kehijauan lembut

      selection_background = "#27343a";
      selection_foreground = "#e5e9f0";

      cursor = "#e5b772"; # Terinspirasi dari pendar kuning hangat lampu taman
      cursor_text_color = "background";

      # black
      color0 = "#1a2124";
      color8 = "#435259";

      # red
      color1 = "#e06c75";
      color9 = "#ea838b";

      # green
      color2 = "#87b098"; # Muted sage green
      color10 = "#9ac8a9";

      # yellow
      color3 = "#e5b772"; # Warm amber lampu jalan
      color11 = "#f2d184";

      # blue
      color4 = "#5c92ad"; # Misty blue malam
      color12 = "#72a6c1";

      # magenta
      color5 = "#a084a1"; # Dusty purple lembut
      color13 = "#b89eb9";

      # cyan
      color6 = "#5fa2a3"; # Teal/cyan kabut
      color14 = "#7dbbc0";

      # white
      color7 = "#c5cfc9";
      color15 = "#e6ede8";
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+enter" = "new_window";
    };
  };
}