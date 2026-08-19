#!/usr/bin/env bash
set -euo pipefail

INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

# cek external monitor ada
if ! hyprctl monitors -j | jq -e ".[] | select(.name == \"$EXTERNAL\")" >/dev/null; then
#  notify-send "Present mode" "HDMI monitor tidak ditemukan"
  exit 1
fi

# ambil mode external
WIDTH=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$EXTERNAL\") | .width")
HEIGHT=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$EXTERNAL\") | .height")
REFRESH=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$EXTERNAL\") | (.refreshRate | floor)")

MODE="${WIDTH}x${HEIGHT}@${REFRESH}"

# samakan internal
hyprctl eval "
hl.monitor({
  output = \"$INTERNAL\",
  mode = \"$MODE\",
  position = \"auto\",
  scale = \"1\",
})
"

# mirror external
hyprctl eval "
hl.monitor({
  output = \"$EXTERNAL\",
  mode = \"$MODE\",
  position = \"auto\",
  scale = \"1\",
  mirror = \"$INTERNAL\",
})
"

#notify-send "Present mode" "Mirror enabled ($MODE)"
