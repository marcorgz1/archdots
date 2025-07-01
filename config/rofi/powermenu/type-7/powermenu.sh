CHOICE=$(printf "\n\n\n\n" | rofi -dmenu -replace -config ~/.config/rofi/powermenu/type-7/style-1.rasi)

case "$CHOICE" in
  "")
    cd /$HOME
    sleep 1
    shutdown now
  ;;
  "")
    cd /$HOME
    sleep 1
    reboot 
  ;;
  "") 
    sleep 1
    hyprlock
  ;;
  "")
    cd /$HOME
    sleep 1
    systemctl suspend
  ;;
  "")
    cd /$HOME
    sleep 1
    hyprctl dispatch exit 0
  ;;
  *) 
    exit 1
  ;;
esac

