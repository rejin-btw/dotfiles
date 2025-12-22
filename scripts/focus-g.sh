#!/usr/bin/env bash
# ~/.config/niri/focus-gemini.sh

APP_ID="chrome-gemini.google.com__-Default"  # Adjust if needed
LAUNCH_CMD="chromium --app=https://gemini.google.com"

# Get window info
WIN_INFO=$(niri msg -j windows | jq --arg app "$APP_ID" '.[] | select(.app_id == $app) | {id, is_focused}')

ID=$(echo "$WIN_INFO" | jq -r '.id // empty')
IS_FOCUSED=$(echo "$WIN_INFO" | jq -r '.is_focused // empty')

# Focus existing or spawn new
if [ -z "$ID" ]; then
    niri msg action spawn -- sh -c "$LAUNCH_CMD"
else
    niri msg action focus-window --id "$ID"
fi

