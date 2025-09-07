#!/bin/bash

scripts_dir="$HOME/.config/hypr/scripts"
monitor_config="$HOME/.config/hypr/configs/monitor.conf"

nightlight_value=$(cat "$HOME/.config/hypr/.cache/.nightlight")

# if openbangla keyboard is installed, the
if [[ -d "/usr/share/openbangla-keyboard" ]]; then
    fcitx5 &> /dev/null
fi

"$scripts_dir/notification.sh" sys

# Reload eww widgets
eww reload


#_____ setup monitor ( updated the monitor.conf for the high resolution and higher refresh rate )

 monitor_setting=$(cat $monitor_config | grep "monitor")
 monitor_icon="$HOME/.config/hypr/icons/monitor.png"

if [[ "$monitor_setting" == "monitor=,preferred,auto,auto" ]]; then
     notify-send -i "$monitor_icon" "Monitor Setup" "A popup for your monitor configuration will appear within 5 seconds." && sleep 5
    kitty --title monitor sh -c "$scripts_dir/monitor.sh"
fi

sleep 3

