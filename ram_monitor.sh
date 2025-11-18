#!/bin/bash

# RAM usage threshold in percentage
THRESHOLD=90

# Get current RAM usage percentage
RAM_USAGE=$(free | grep Mem | awk '{printf("%.0f"), ($3/$2) * 100}')

# Check if RAM usage exceeds threshold
if [ "$RAM_USAGE" -ge "$THRESHOLD" ]; then
    notify-send -u critical "RAM Usage Alert" "RAM usage is at ${RAM_USAGE}%. System memory is running low!"
fi

