{ config, lib, pkgs, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    font = "Inter 11";

    extraConfig = {
      modi = "drun,run,window";

      show-icons = true;

      display-drun = "Apps";
      display-window = "Windows";
      display-run = "Run";

      drun-display-format = "{name}";

      disable-history = false;
      hover-select = true;
    };

    theme = {
      "*" = {
        bg       = mkLiteral "#0F1117";
        bg-alt   = mkLiteral "#1A1D24";

        fg       = mkLiteral "#ECECEC";

        accent   = mkLiteral "#62A0EA";

        border   = mkLiteral "#2C313A";

        selected = mkLiteral "#2A3442";
      };

      window = {
        width = mkLiteral "42%";

        background-color = mkLiteral "@bg";

        border = 1;
        border-radius = 18;

        border-color = mkLiteral "@border";
      };

      mainbox = {
        children = map mkLiteral [
          "inputbar"
          "listview"
        ];

        padding = 18;
        spacing = 10;

        background-color = mkLiteral "transparent";
      };

      inputbar = {
        children = map mkLiteral [
          "prompt"
          "entry"
        ];

        padding = 10;
        border-radius = 10;

        background-color = mkLiteral "@bg-alt";
      };

      prompt = {
        padding = 2;
        border-radius = 6;
        margin = mkLiteral "0 8px 0 0";
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@accent";
      };

      entry = {
        text-color = mkLiteral "@fg";
        background-color = mkLiteral "transparent";
      };

      listview = {
        lines = 8;
        spacing = 2;

        scrollbar = false;

        background-color = mkLiteral "transparent";
      };

      element = {
        padding = 6;

        border-radius = 10;

        background-color = mkLiteral "@bg-alt";
        #text-color = mkLiteral "@fg";
        text-color = mkLiteral "#ffffff";

        children = map mkLiteral [
          "element-icon"
          "element-text"
        ];

        spacing = 8;
      };

      "element normal.normal" = {
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@fg";
      };

      element-icon = {
        size = mkLiteral "18px";

        background-color = mkLiteral "transparent";
      };

      element-text = {
        background-color = mkLiteral "transparent";

        text-color = mkLiteral "@fg";

        vertical-align = mkLiteral "0.5";
      };
    };
  };
}