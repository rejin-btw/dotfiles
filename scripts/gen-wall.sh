#!/usr/bin/env bash

# CONFIG
OUTPUT="$HOME/dotfiles/wallpapers/base.jpg"
RES="1920x1080"

# COLORS (Catppuccin / Hacker Style)
C1="#1e1e2e" # Dark Base
C2="#89b4fa" # Cyan/Blue Highlight

echo "Generating Abstract Wallpaper..."

# THE FIX:
# 1. Use 'magick' (Not convert)
# 2. plasma:fractal -> Generates random cloud patterns
# 3. +level-colors -> Forces the image to use ONLY our Blue/Dark theme
# 4. -paint 20 -> Smears the pixels to look like an abstract painting (removes noise)
magick -size $RES plasma:fractal \
    -blur 0x5 \
    +level-colors "$C1","$C2" \
    -paint 20 \
    "$OUTPUT"

echo "Done! Saved to $OUTPUT"

# OPTIONAL: Refresh the current wallpaper immediately so you can see it
# (This runs your update script to re-burn any active todos onto the new base)
~/dotfiles/scripts/update-wall.sh
