#!/usr/bin/env bash

# Define paths
TEXT_FILE="$HOME/dotfiles/todo.txt"
OUTPUT_IMG="/tmp/wallpaper.png"

# DYNAMIC PATH: Ask the system for the file path of your default monospace font
FONT_PATH=$(fc-match "monospace" --format="%{file}")

# 1. Generate the image
magick -size 1920x1080 xc:'#1e1e2e' \
  -font "$FONT_PATH" \
  -pointsize 24 \
  -fill '#cdd6f4' \
  -gravity center \
  -annotate +0+0 "@$TEXT_FILE" \
  "$OUTPUT_IMG"

# 2. Update wallpaper
swww img "$OUTPUT_IMG" --transition-type none
