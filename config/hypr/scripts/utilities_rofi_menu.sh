#!/bin/bash

options=(
    "󰐧  Power Profile"
    "󰏘  Color Picker"
    "  Clipboard Manager"
    "󰚰  Update"
    "󰣇  Install packages"
    "  AUR packages"
    "󰒓  Configuration"
    "󰍹  System Monitor"
    "󰂯  Bluetooth Manager"
    "󰕾  Audio Settings"
    "󰍺  Network Manager"
    "󰌌  Keybindings"
    "󰒕  Wallpaper Changer"
    "󰻂  Screen Recorder"
)

# Show rofi menu
chosen=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Utilities" \
    -theme "~/.config/rofi/launchers/type-1/style-5.rasi" \
    -theme-str 'window {width: 400px;}' \
    -theme-str 'listview {lines: 10;}')

# Execute based on selection
case $chosen in
    "󰐧  Power Profile")
        # Power profile menu
        profiles=("Performance" "Balanced" "Power Saver")
        profile=$(printf '%s\n' "${profiles[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i -p "Power Profile")
        
        case $profile in
            "󱤎  Performance")
                powerprofilesctl set performance && notify-send "Power Profile" "Switched to Performance mode"
                ;;
            "  Balanced")
                powerprofilesctl set balanced && notify-send "Power Profile" "Switched to Balanced mode"
                ;;
            "󰌪  Power Saver")
                powerprofilesctl set power-saver && notify-send "Power Profile" "Switched to Power Saver mode"
                ;;
        esac
        ;;
        
    "󰏘  Color Picker")
        color=$(hyprpicker | wl-copy)

        if [ -n "$color" ]; then
            notify-send "Color picker" "Color \"$color\" copied to clipboard"
        fi
        ;;
        
    "  Clipboard Manager")
        bash -c ~/.config/hypr/scripts/clipmanager.sh
        ;;

    "󰣇  Update")
        kitty -e bash -c "sudo pacman -Syu; echo; echo 'Update complete! Press any key to close...'; read"

        if [ $? -eq 0 ]; then
            notify-send "Update" "System update completed"
        fi
        ;;

    "󰣇  Install packages")
        kitty -e bash -c '
            search_packages() {
                echo "Fetching package list... (this may take a moment)"
                echo ""
                
                # Search packages using fzf with preview
                selected=$(pacman -Ss "" | \
                    awk "/^[^ ]/ {pkg=\$1} /^    / {print pkg \" - \" substr(\$0, 5)}" | \
                    fzf --height=100% \
                        --prompt="Search Packages > " \
                        --header="Enter to view details | Ctrl-I to install | Ctrl-C to exit" \
                        --preview="pacman -Si {1} 2>/dev/null || echo \"Package info not available\"" \
                        --preview-window=right:60%:wrap \
                        --bind="ctrl-i:execute(sudo pacman -S {1})+abort")
                
                if [ -n "$selected" ]; then
                    pkg_name=$(echo "$selected" | awk "{print \$1}")
                    
                    echo ""
                    echo "═══════════════════════════════════════════════"
                    echo "Package: $pkg_name"
                    echo "═══════════════════════════════════════════════"
                    pacman -Si "$pkg_name"
                    echo ""
                    echo "═══════════════════════════════════════════════"
                    echo "Options:"
                    echo "  [I] Install package"
                    echo "  [Q] Quit"
                    echo "═══════════════════════════════════════════════"
                    read -p "Choose an option: " choice
                    
                    case $choice in
                        [Ii])
                            sudo pacman -S "$pkg_name"
                            echo ""
                            read -p "Press any key to continue..."
                            ;;
                        *)
                            echo "Exiting..."
                            ;;
                    esac
                fi
            }
            
            search_packages
        '
        ;;

    "  AUR packages")
        update_options=("  Manage" "󰚰  Update" "󰚰  Check Updates" "  Clean Cache")
        update_choice=$(printf '%s\n' "${update_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i -p "AUR Update")
        
        case $update_choice in
            "  Manage")
                kitty -e bash -c "pacseek"
                ;;
            "󰚰  Update")
                kitty -e bash -c "yay -Syu; echo; echo 'Update complete! Press any key to close...'; read"
                notify-send "AUR Update" "AUR packages update completed"
                ;;
            "󰚰  Check Updates")
                # Check for updates without installing
                kitty -e bash -c "echo 'Checking for updates...'; echo; yay -Qu || echo 'No updates available'; echo; echo 'Press any key to close...'; read"
                ;;
            "  Clean Cache")
                # Clean package cache
                kitty -e bash -c "yay -Sc; echo; echo 'Cache cleaned! Press any key to close...'; read"
                notify-send "AUR Update" "Package cache cleaned"
                ;;
        esac
        ;;

    "󰒓  Configuration")
        available_options=("  Hyprland" "  Terminal" "󰄨  Waybar" "󰜬  Eww widgets" "󰂚  Swaync" "  Fastfetch")
        update_choice=$(printf '%s\n' "${available_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i)

        case $update_choice in
            "  Hyprland")
                code ~/.config/hypr
            ;;
            "  Terminal")
                code ~/.config/kitty
            ;;
            "󰄨  Waybar")
                code ~/.config/waybar
            ;;
            "󰜬  Eww widgets")
                code ~/.config/eww
            ;;
            "󰂚  Swaync")
                code ~/.config/swaync
            ;;

            "  Fastfetch")
                code ~/.local/share/fastfetch
            ;;
        esac
        ;;
        
    "󰍹  System Monitor")
        # Open system monitor
        kitty -e btop
        ;;
        
    "󰂯  Bluetooth Manager")
        # Bluetooth manager
        blueman-manager
        ;;
        
    "󰕾  Audio Settings")
        # Audio settings
        pavucontrol
        # Alternative: kitty -e pulsemixer
        ;;
        
    "󰍺  Network Manager")
        # Network manager
        # kitty -e nmgui
        nmgui
        ;;
        
    "󰌌  Keybindings")
        # Display keybindings (create a keybindings file or parse hyprland.conf)
        kitty -e less ~/.config/hypr/configs/binds.conf
        ;;
        
    "󰒕  Wallpaper Changer")
        sh ~/.config/hypr/scripts/WallSelect.sh
        ;;
        
    "󰻂  Screen Recorder")
        # Screen recorder options
        recorder_options=("Start Recording" "Stop Recording" "Screenshot Area" "Screenshot Full")
        recorder_choice=$(printf '%s\n' "${recorder_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i -p "Screen Recorder")
        
        case $recorder_choice in
            "Start Recording")
                wf-recorder -f ~/Videos/recording_$(date +%Y%m%d_%H%M%S).mp4 &
                notify-send "Screen Recorder" "Recording started"
                ;;
            "Stop Recording")
                killall -s SIGINT wf-recorder
                notify-send "Screen Recorder" "Recording stopped"
                ;;
            "Screenshot Area")
                hyprshot -m region --clipboard-only
                # grim -g "$(slurp)" ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png
                # notify-send "Screenshot" "Area screenshot saved"
                ;;
            "Screenshot Full")
                hyprshot -m output -m DP-2
                # grim ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png
                # notify-send "Screenshot" "Full screenshot saved"
                ;;
        esac
        ;;
esac
