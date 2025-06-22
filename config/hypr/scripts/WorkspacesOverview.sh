#!/bin/bash
# Enhanced workspace overview for Hyprland

# Get current workspace info
CURRENT_WS=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')

# Get all workspaces with windows
WORKSPACES=$(hyprctl workspaces | grep "workspace ID" | awk '{print $3}' | sort -n)

# Create rofi menu with workspace info
WORKSPACE_LIST=""
for ws in $WORKSPACES; do
    # Get window count in workspace
    WINDOW_COUNT=$(hyprctl clients | grep "workspace: $ws" | wc -l)
    
    if [ "$ws" == "$CURRENT_WS" ]; then
        WORKSPACE_LIST="$WORKSPACE_LIST󰖯 Workspace $ws (Current) - $WINDOW_COUNT windows\n"
    else
        WORKSPACE_LIST="$WORKSPACE_LIST  Workspace $ws - $WINDOW_COUNT windows\n"
    fi
done

# Show workspace selector
SELECTED=$(echo -e "$WORKSPACE_LIST" | rofi -dmenu -p "Workspaces" -theme ~/.config/rofi/config-workspaces-overview.rasi)

if [ -n "$SELECTED" ]; then
    # Extract workspace number
    WS_NUM=$(echo "$SELECTED" | grep -o 'Workspace [0-9]*' | awk '{print $2}')
    if [ -n "$WS_NUM" ]; then
        hyprctl dispatch workspace "$WS_NUM"
    fi
fi

