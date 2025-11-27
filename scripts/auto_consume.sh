#!/usr/bin/env bash

PIDFILE="/tmp/niri-auto-consume.pid"
# Point to the compiled binary we just built
BINARY="$HOME/dotfiles/scripts/niri_auto/target/release/niri_auto"

if [ -f "$PIDFILE" ]; then
    pkill -f "$BINARY"
    rm "$PIDFILE"
    notify-send "Auto-Consume" "Disabled"
    exit 0
fi

echo $$ > "$PIDFILE"
notify-send "Auto-Consume" "Enabled (Rust)"

# Make sure it's executable (just in case)
chmod +x "$BINARY"

# Run the binary in the background
"$BINARY" &

trap "pkill -f '$BINARY'; rm -f '$PIDFILE'" EXIT
wait
