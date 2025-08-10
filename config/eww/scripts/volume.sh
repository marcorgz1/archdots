#!/bin/bash

set -euo pipefail

# Prefer wpctl (PipeWire). Fall back to pamixer if available.
if command -v wpctl >/dev/null 2>&1; then
  muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
else
  muted=$(pamixer --get-mute | grep -qi true && echo 1 || echo 0)
  vol=$(pamixer --get-volume)
fi

icon=""
if [[ $vol -ge 66 ]]; then icon=""; fi
if [[ $vol -le 33 ]]; then icon=""; fi
if [[ $muted -eq 1 ]]; then icon=""; fi

echo "{\"icon\": \"$icon\", \"text\": \"${vol}%\"}"
