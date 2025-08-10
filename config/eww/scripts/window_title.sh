#!/bin/bash

set -euo pipefail
hyprctl -j activewindow 2>/dev/null | jq -r '.title // ""' | sed 's/\n/ /g' | tr -s ' '
