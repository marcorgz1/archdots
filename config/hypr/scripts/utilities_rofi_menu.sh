#!/bin/bash

options=(
    "󰐧  Power Profile"
    "󰏘  Color Picker"    
    "󰚰  Update"
    "󰣇  Install packages"
    "  AUR packages"
    "󰒓  Configuration"
    "󰍹  System"
    "󱁤  Tools"
    "  Font selector"
    "󰌌  Keybindings"
)

# Show rofi menu
chosen=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Utilities" \
    -theme "~/.config/rofi/launchers/type-1/style-16.rasi" \
    -theme-str 'window {width: 350px;}' \
    -theme-str 'listview {lines: 10;}')

# Execute based on selection
case $chosen in
    "󰐧  Power Profile")
        # Power profile menu
        profiles=("Performance" "Balanced" "Power Saver")
        profile=$(printf '%s\n' "${profiles[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i -p "Power Profile" \
        -theme-str 'window {width: 350px;}' \
        -theme-str 'listview {lines: 3;}')
        
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

    "󰚰  Update")
        choice=$(echo -e "Yes\nNo" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i -p "Update now?")

        if [ "$choice" = "Yes" ]; then
            kitty -e bash -c "sudo pacman -Syu; echo; echo 'Update complete! Press any key to close...'; read"

            if [ $? -eq 0 ]; then
                notify-send "Update" "System update completed"
            fi
        fi
        ;;

    "󰣇  Install packages")
        kitty --title "Install packages" -e bash -c '
            search_packages() {
                echo "Fetching package list... (this may take a moment)"
                echo ""
                
                selected=$(pacman -Ss "" | \
                    awk -F"/" "/^[^ ]/ {print \$2}" | \
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
        update_options=("  Manage" "󰚰  Update" "󰚰  Check Updates" "  Clean Cache" "  Back")
        update_choice=$(printf '%s\n' "${update_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i -p "AUR Update" \
        -theme-str 'window {width: 350px;}' \
        -theme-str 'listview {lines: 5;}')
        
        case $update_choice in
            "  Manage")
                kitty --title "pacseek" -e bash -c "pacseek"
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

            "  Back")
                bash -c "~/.config/hypr/scripts/utilities_rofi_menu.sh"
            ;;
        esac
        ;;

    "󰒓  Configuration")
        available_options=("  Hyprland" "  Terminal" "  Shell" "  Rofi" "󰄨  Waybar" "󰜬  Eww widgets" "󰂚  Swaync" "  Fastfetch"  "  Back")
        update_choice=$(printf '%s\n' "${available_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i \
            -theme-str 'window {width: 350px;}' \
            -theme-str 'listview {lines: 8;}')

        case $update_choice in
            "  Hyprland")
                code-insiders ~/.config/hypr
            ;;
            "  Terminal")
                code-insiders ~/.config/kitty
            ;;
            "  Shell")
                nvim ~/.zshrc
            ;;
            "  Rofi")
                code-insiders ~/.config/rofi
            ;;
            "󰄨  Waybar")
                code-insiders ~/.config/waybar
            ;;
            "󰜬  Eww widgets")
                code-insiders ~/.config/eww
            ;;
            "󰂚  Swaync")
                code-insiders ~/.config/swaync
            ;;

            "  Fastfetch")
                code-insiders ~/.local/share/fastfetch
            ;;

            "  Back")
                bash -c "~/.config/hypr/scripts/utilities_rofi_menu.sh"
            ;;
        esac
    ;;

    "󰍹  System")
        available_options=("󱎴  System Monitor" "󰕾  Audio" "󰂯  Bluetooth" "   Network" "   Disks" "󰐥   Power menu" "  Back")
        update_choice=$(printf '%s\n' "${available_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i \
            -theme-str 'window {width: 350px;}' \
            -theme-str 'listview {lines: 7;}')

        case $update_choice in
            "󱎴  System Monitor")
                kitty -e btop
            ;;
            
            "󰕾  Audio")
                kitty -e pulsemixer
            ;;
            
            "󰂯  Bluetooth")
                kitty -e bluetui
            ;;
            
            "   Network")
                nmgui
            ;;
            
            "   Disks")
                kitty -e sudo disktui
            ;;
            
            "󰐥   Power menu")
                wlogout
            ;;
            
            "  Back")
                bash -c "~/.config/hypr/scripts/utilities_rofi_menu.sh"
            ;;
        esac
    ;;

    "󱁤  Tools")
        available_options=("󰕧  Screen recorder" "󰇚  Video downloader" "  Clipboard" "  Wallpaper" "  Back")
        update_choice=$(printf '%s\n' "${available_options[@]}" | rofi -dmenu -theme "~/.config/rofi/launchers/type-1/style-5.rasi" -i \
            -theme-str 'window {width: 350px;}' \
            -theme-str 'listview {lines: 5;}')

        case $update_choice in
            "󰕧  Screen recorder")
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
            "󰇚  Video downloader")
                kitty -e bash -c '
                    echo "╔════════════════════════════════════════════════════╗"
                    echo "║          Video Downloader (yt-dlp)                 ║"
                    echo "╚════════════════════════════════════════════════════╝"
                    echo ""
                    
                    if ! command -v yt-dlp &> /dev/null; then
                        echo "❌ yt-dlp is not installed!"
                        echo ""
                        echo "Install it with: sudo pacman -S yt-dlp"
                        echo "Or from AUR: yay -S yt-dlp"
                        echo ""
                        read -p "Press any key to exit..."
                        exit 1
                    fi
                    
                    clipboard_url=$(wl-paste 2>/dev/null)
                    
                    if [[ "$clipboard_url" =~ ^https?:// ]]; then
                        echo "📋 URL found in clipboard: $clipboard_url"
                        echo ""
                        read -p "Use this URL? [Y/n]: " use_clipboard
                        
                        if [[ "$use_clipboard" =~ ^[Nn]$ ]]; then
                            read -p "Enter video URL: " video_url
                        else
                            video_url="$clipboard_url"
                        fi
                    else
                        read -p "Enter video URL: " video_url
                    fi
                    
                    if [ -z "$video_url" ]; then
                        echo "❌ No URL provided. Exiting..."
                        sleep 2
                        exit 1
                    fi
                    
                    echo ""
                    echo "═══════════════════════════════════════════════"
                    echo "Download Options:"
                    echo "  [1] Best Quality (Video + Audio)"
                    echo "  [2] 1080p"
                    echo "  [3] 720p"
                    echo "  [4] Audio Only (MP3)"
                    echo "  [5] Audio Only (Best Quality)"
                    echo "  [6] Custom Quality"
                    echo "═══════════════════════════════════════════════"
                    read -p "Choose option [1-6]: " quality_choice
                    
                    # Set download directory
                    download_dir="$HOME/Videos"
                    mkdir -p "$download_dir"
                    
                    echo ""
                    echo "📥 Starting download..."
                    echo "📁 Saving to: $download_dir"
                    echo ""
                    
                    case $quality_choice in
                        1)
                            yt-dlp -f "bestvideo+bestaudio/best" -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                        2)
                            yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                        3)
                            yt-dlp -f "bestvideo[height<=720]+bestaudio/best[height<=720]" -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                        4)
                            yt-dlp -x --audio-format mp3 --audio-quality 0 -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                        5)
                            yt-dlp -x --audio-format best -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                        6)
                            echo ""
                            echo "Available formats:"
                            yt-dlp -F "$video_url"
                            echo ""
                            read -p "Enter format code: " format_code
                            yt-dlp -f "$format_code" -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                        *)
                            echo "❌ Invalid option. Downloading best quality..."
                            yt-dlp -f "bestvideo+bestaudio/best" -o "$download_dir/%(title)s.%(ext)s" "$video_url"
                            ;;
                    esac
                    
                    if [ $? -eq 0 ]; then
                        echo ""
                        echo "✅ Download completed successfully!"
                        echo "📁 Location: $download_dir"
                        notify-send "Video Downloader" "Download completed successfully!" -i download
                    else
                        echo ""
                        echo "❌ Download failed!"
                        notify-send "Video Downloader" "Download failed!" -i error
                    fi
                    
                    echo ""
                    read -p "Press any key to exit..."
                '
            ;;

            "  Clipboard")
                bash ~/.config/hypr/scripts/clipmanager.sh
            ;;


            "  Wallpaper")
                sh ~/.config/hypr/scripts/WallSelect.sh
            ;;

            "  Back")
                bash -c "~/.config/hypr/scripts/utilities_rofi_menu.sh"
            ;;
            
        esac
    ;;

    "  Font selector")
        font_list=$(fc-list : family | sort -u)
        
        # Show font selection menu using rofi
        selected_font=$(echo "$font_list" | rofi -dmenu -i -p "Select Waybar Font" \
            -theme "~/.config/rofi/launchers/type-1/style-5.rasi" \
            -theme-str 'window {width: 400px;}' \
            -theme-str 'listview {lines: 15;}')
        
        if [ -n "$selected_font" ]; then
            # Waybar config file path
            waybar_config="$HOME/.config/waybar/style.css"
            
            # Check if waybar config exists
            if [ ! -f "$waybar_config" ]; then
                notify-send "Font Selector" "Waybar style.css not found!" -u critical
                exit 1
            fi
            
            # Backup original config
            cp "$waybar_config" "$waybar_config.backup"
            
            # Update font-family in waybar config
            # This handles multiple possible CSS syntax variations
            sed -i "s/font-family: [^;]*;/font-family: \"$selected_font\";/g" "$waybar_config"
            
            # If no font-family found, add it to the * selector
            if ! grep -q "font-family:" "$waybar_config"; then
                sed -i "/^\* {/a \    font-family: \"$selected_font\";" "$waybar_config"
            fi
            
            # Restart waybar to apply changes
            killall waybar
            waybar &
            
            notify-send "Font changed" "The waybar font changed successfully"
        fi
    ;;
        
    "󰌌  Keybindings")
        # Display keybindings (create a keybindings file or parse hyprland.conf)
        kitty -e less ~/.config/hypr/configs/binds.conf
    ;;
esac
