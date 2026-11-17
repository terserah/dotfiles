{ pkgs, ... }:
let
  screenshot-region-edit = pkgs.writeShellScriptBin "screenshot-region-edit" ''
    set -eu
    OUT_DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$OUT_DIR"
    # -d: dim unselected, -c merah biar jelas di Niri
    GEOM="$(slurp -d -c '#ff0000ff')" || exit 0
    [ -z "$GEOM" ] && exit 0
    grim -g "$GEOM" -t ppm - | satty \
      --filename - \
      --fullscreen \
      --initial-tool rectangle \
      --copy-command wl-copy \
      --output-filename "$OUT_DIR/Ss from $(date '+%Y-%m-%d %H-%M-%S').png"
  '';
  screenshot-screen-edit = pkgs.writeShellScriptBin "screenshot-screen-edit" ''
    set -eu
    OUT_DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$OUT_DIR"
    grim -t ppm - | satty \
      --filename - \
      --fullscreen \
      --initial-tool rectangle \
      --copy-command wl-copy \
      --output-filename "$OUT_DIR/Ss from $(date '+%Y-%m-%d %H-%M-%S').png"
  '';
in
{
  home.packages = with pkgs; [
    grim
    slurp
    satty
    wl-clipboard
    libnotify
    screenshot-region-edit
    screenshot-screen-edit
  ];

  xdg.configFile."satty/config.toml".text = ''
    [general]
    output-filename = "/home/r3z/Pictures/Screenshots/Ss from %Y-%m-%d %H-%M-%S.png"
    initial-tool = "rectangle"
    copy-command = "wl-copy"
    save-after-copy = true
  '';
}
