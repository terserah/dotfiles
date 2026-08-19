{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
        general {
            ignore_empty_input = true
            hide_cursor = true
            grace = 2
        }

        animations {
            enabled = true

            bezier = smooth, 0.25, 0.1, 0.25, 1.0

            animation = fadeIn, 1, 4, smooth
            animation = fadeOut, 1, 4, smooth
            animation = inputFieldDots, 1, 2, smooth
        }

        background {
            monitor =

            # gunakan salah satu:
            path = screenshot

            color = rgba(25, 20, 20, 1.0)

            blur_passes = 4
            blur_size = 8
            noise = 0.015
            contrast = 1.1
            brightness = 0.9
            vibrancy = 0.15
            vibrancy_darkness = 0.2
        }

        # CLOCK
        label {
            monitor =
            text = cmd[update:1000] echo "$(date '+%H:%M')"

            color = rgba(255,255,255,0.92)

            font_size = 88
            font_family = JetBrainsMono Nerd Font
            font_weight = bold

            position = 0, 180
            halign = center
            valign = center
        }

        # DATE
        label {
            monitor =
            text = cmd[update:60000] date "+%A, %d %B %Y"

            color = rgba(220,220,220,0.75)

            font_size = 18
            font_family = JetBrainsMono Nerd Font

            position = 0, 115
            halign = center
            valign = center
        }

        # PASSWORD BOX
        input-field {
            monitor =

            size = 320, 58

            outline_thickness = 2

            outer_color = rgba(255,180,120,0.22)
            inner_color = rgba(20,20,20,0.55)
            font_color = rgba(255,255,255,0.92)

            rounding = 14

            fade_on_empty = false
            dots_center = true
            dots_spacing = 0.22
            dots_size = 0.18

            placeholder_text = <i>Password...</i>

            fail_color = rgb(255,120,120)
            fail_text = Authentication failed

            position = 0, 20
            halign = center
            valign = center
        }

        # USER
        label {
            monitor =
            text = $USER

            color = rgba(255,255,255,0.55)

            font_size = 16
            font_family = JetBrainsMono Nerd Font

            position = 0, -50
            halign = center
            valign = center
        }

        # KEYBOARD LAYOUT
        label {
            monitor =
            text = $LAYOUT

            color = rgba(255,255,255,0.45)

            font_size = 14
            font_family = JetBrainsMono Nerd Font

            position = 0, -115
            halign = center
            valign = center
        }
    '';
  };
}