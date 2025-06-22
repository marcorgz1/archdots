#!/bin/bash

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Define file_exists function
file_exists() {
    if [ -e "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# Kill already running processes
_ps=(
    dunst
    rofi
    hyprpanel
    # waybar
)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" &> /dev/null; then
        pkill "${_prs}"
    fi
done

sleep 0.3
hyprctl reload

sleep 0.5

# Send notification about completed reload
if command -v notify-send &> /dev/null; then
    notify-send "Hyprland" "Configuration reloaded successfully!" --icon=dialog-information
elif command -v dunstify &> /dev/null; then
    dunstify "Hyprland" "Configuration reloaded successfully!" --icon=dialog-information
else
    echo "Hyprland configuration reloaded successfully!"
fi

exit 0
