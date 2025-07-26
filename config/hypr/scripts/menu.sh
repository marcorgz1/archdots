#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-8"
theme='config'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
