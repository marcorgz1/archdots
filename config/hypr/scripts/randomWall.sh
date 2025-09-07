#!/bin/bash

wallDIR='/home/marco1/.config/hypr/Wallpaper'

find "$wallDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1
