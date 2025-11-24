#!/usr/bin/env bash
# Script to display current date and time as notification

# Get current date and time
current_datetime=$(date "+%A, %B %d, %Y%n%I:%M:%S %p")

# Send notification
notify-send "Current Date & Time" "$current_datetime" --icon=clock

