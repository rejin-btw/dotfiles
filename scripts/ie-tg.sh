#!/usr/bin/env sh

# Link to the channel
LINK="tg://resolve?domain=THE_INDIAN_EXPRESSSSS"

# Check if Telegram is already running
if pgrep -f "Telegram" > /dev/null; then
    # Warm Start: Just send the link
    Telegram -- "$LINK"
else
    # Cold Start: Launch Telegram first
    Telegram &
    
    # Wait for it to initialize (adjust seconds if your PC is slower)
    sleep 4
    
    # "Double Tap": Send the link again now that it's ready
    Telegram -- "$LINK"
fi
