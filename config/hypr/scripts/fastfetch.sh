#!/bin/bash

# Folder with your logos
IMG_DIR="$HOME/.local/share/fastfetch/images"
ASCII_DIR="$HOME/.local/share/fastfetch/ascii"

# Pick a random file
RANDOM_IMG=$(find "$IMG_DIR" "$ASCII_DIR" -type f | shuf -n 1)

# Path to fastfetch config
CONFIG_FILE="$HOME/.local/share/fastfetch/presets/custom.jsonc"

# Replace the logo source line in config.jsonc
# (assumes your config already has a "source": line for the logo)
sed -i "s#\"source\": \".*\"#\"source\": \"$RANDOM_IMG\"#" "$CONFIG_FILE"

# Run fastfetch
fastfetch --config custom
