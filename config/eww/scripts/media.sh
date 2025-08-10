#!/bin/bash

set -euo pipefail

status=$(playerctl status 2>/dev/null || echo "Stopped")
if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
  artist=$(playerctl metadata artist 2>/dev/null | head -n1)
  title=$(playerctl metadata title 2>/dev/null | head -n1)
  sym=""
  [[ "$status" == "Paused" ]] && sym=""
  echo "$sym  ${artist:-?} - ${title:-?}"
else
  echo "  No media"
fi
