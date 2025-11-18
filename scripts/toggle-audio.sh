#!/bin/bash

sink_name="alsa_output.pci-0000_00_1f.3.analog-stereo"

# Get full sink info
sink_info=$(pactl list sinks | grep -A100 "$sink_name")

# Extract active port reliably
active_port=$(echo "$sink_info" | grep "Active Port:" | awk '{print $3}')

# Define ports
headphones_port="analog-output-headphones"
lineout_port="analog-output-lineout"

# Decide target
if [[ "$active_port" == "$headphones_port" ]]; then
    target_port="$lineout_port"
elif [[ "$active_port" == "$lineout_port" ]]; then
    target_port="$headphones_port"
else
    echo "Unknown current port: $active_port"
    exit 1
fi

# Switch!
pactl set-sink-port "$sink_name" "$target_port"
echo "Switched audio output to: $target_port"

