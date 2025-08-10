#!/bin/bash

set -euo pipefail

# Try Wi‑Fi first, then general
ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1=="yes"{print $2; exit}')
if [[ -n "${ssid}" ]]; then
  echo "  ${ssid}"
  exit 0
fi

state=$(nmcli -t -f STATE g 2>/dev/null | head -n1)
if [[ "$state" == "connected" ]]; then
  echo "  connected"
else
  echo "  offline"
fi
