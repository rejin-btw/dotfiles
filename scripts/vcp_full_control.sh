#!/bin/bash/env bash

step=$1

# Validate input
if [[ ! $step =~ ^[1-9]$|^10$ ]]; then
  echo "Usage: $0 1-10"
  exit 1
fi

# Brightness range 0-100 by steps 1-10
min_brightness=0
max_brightness=100
brightness=$(( (max_brightness - min_brightness) * (step - 1) / 9 + min_brightness ))

# Define your 4 preset color/contrast configurations for F1 to F4
# (VCP codes: 14=input select fixed to 0x0B as per your original settings)
preset_colors=(
  "14 0x0B 16 0 18 0 1A 0"    # for step 1
  "14 0x0B 16 10 18 10 1A 10" # for step 2
  "14 0x0B 16 20 18 20 1A 20" # for step 3
  "14 0x0B 16 30 18 30 1A 30" # for step 4
)

# Define default color & contrast values equal to your monitor's normal start state (example values)
default_colors="14 0x0B 16 50 18 50 1A 50"

# Function to apply color/contrast VCP codes
apply_color_contrast() {
  local args=($1)
  # args: pairs of code and value (e.g., "14 0x0B 16 0 18 0 1A 0")
  for ((i=0; i < ${#args[@]}; i+=2)); do
    ddcutil setvcp "${args[i]}" "${args[i+1]}"
  done
}

if (( step >= 1 && step <=4 )); then
  # apply preset color/contrast + brightness
  apply_color_contrast "${preset_colors[step-1]}"
  ddcutil setvcp 10 $brightness
elif (( step >= 5 && step <= 10 )); then
  # apply default color/contrast + brightness
  apply_color_contrast "$default_colors"
  ddcutil setvcp 10 $brightness
fi

echo "Step $step applied: brightness=$brightness, colors set."


