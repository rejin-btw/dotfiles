#!/usr/bin/env bash
# ~/.config/niri/focus-perplexity.sh

APP_ID="spicy"  # Replace with your actual app-id
LAUNCH_CMD="windows"

# Get all matching windows
WINDOWS=$(niri msg -j windows | jq --arg app "$APP_ID" '[.[] | select(.app_id == $app) | {id, is_focused}]')

# Count matching windows
COUNT=$(echo "$WINDOWS" | jq 'length')

if [ "$COUNT" -eq 0 ]; then
    # No windows found, spawn new
    niri msg action spawn -- sh -c "$LAUNCH_CMD"
elif [ "$COUNT" -eq 1 ]; then
    # Single window, just focus it
    ID=$(echo "$WINDOWS" | jq -r '.[0].id')
    niri msg action focus-window --id "$ID"
else
    # Multiple windows: cycle through them
    FOCUSED_INDEX=$(echo "$WINDOWS" | jq 'to_entries | .[] | select(.value.is_focused == true) | .key')
    
    if [ -z "$FOCUSED_INDEX" ]; then
        # None focused, focus the first one
        ID=$(echo "$WINDOWS" | jq -r '.[0].id')
    else
        # Focus next window (cycle back to 0 if at end)
        NEXT_INDEX=$(( ($FOCUSED_INDEX + 1) % $COUNT ))
        ID=$(echo "$WINDOWS" | jq -r ".[$NEXT_INDEX].id")
    fi
    
    niri msg action focus-window --id "$ID"
fi


