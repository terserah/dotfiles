{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.5;
    };

    settings = {
      shell = "tmux new-session -A -s main";
      # Fonts
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "never";

      # Window
      background_opacity = "0.65";
      window_padding_width = 6;
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

      # Theme
      background = "#100d16";
      foreground = "#d8dee9";

      selection_background = "#2b3440";
      selection_foreground = "#eceff4";

      cursor = "#89dceb";
      cursor_text_color = "background";

      # black
      color0 = "#16161e";
      color8 = "#414868";

      # red
      color1 = "#f7768e";
      color9 = "#ff9e64";

      # green
      color2 = "#9ece6a";
      color10 = "#73daca";

      # yellow
      color3 = "#e0af68";
      color11 = "#ffcb6b";

      # blue
      color4 = "#7aa2f7";
      color12 = "#89b4fa";

      # magenta
      color5 = "#bb9af7";
      color13 = "#cba6f7";

      # cyan
      color6 = "#7dcfff";
      color14 = "#89dceb";

      # white
      color7 = "#c0caf5";
      color15 = "#f5f5f5";
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
