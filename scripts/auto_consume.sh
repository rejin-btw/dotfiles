#!/usr/bin/env sh

PIDFILE="/tmp/niri-auto-consume.pid"

# Check if already running and kill by command pattern
if [ -f "$PIDFILE" ]; then
    # Kill any running niri msg event-stream processes
    pkill -f "niri msg --json event-stream"
    rm "$PIDFILE"
    notify-send "Niri Auto-Consume" "Disabled - windows will open normally"
    exit 0
fi

# Start auto-consume mode
echo $$ > "$PIDFILE"
notify-send "Niri Auto-Consume" "Enabled - new windows will join current tab group"

# Listen to event stream and auto-consume new windows
niri msg --json event-stream | while read -r line; do
    # Check if a window was opened
    if echo "$line" | jq -e '.WindowOpenedOrChanged' > /dev/null 2>&1; then
        # Small delay to ensure window is ready
        sleep 0.1
        
        # Focus the column to the left (your tabbed column)
        niri msg action focus-column-left
        
        # Consume the window from the right into the focused column
        niri msg action consume-window-into-column
        
        # Ensure column is in tabbed display mode
        niri msg action set-column-display tabbed
    fi
done &

# Cleanup on exit
trap "pkill -f 'niri msg --json event-stream'; rm -f '$PIDFILE'" EXIT
wait

