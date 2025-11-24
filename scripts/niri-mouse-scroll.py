#!/usr/bin/env python3
from evdev import InputDevice, ecodes
import subprocess

# --- CONFIGURATION ---
DEV_PATH = '/dev/input/by-id/usb-SIGMACHIP_Usb_Mouse-event-mouse'
NIRI_EXECUTABLE = 'niri'
# --- END CONFIGURATION ---

try:
    dev = InputDevice(DEV_PATH)
except FileNotFoundError:
    print(f"Error: Device not found at '{DEV_PATH}'.")
    exit(1)

left_pressed = False
right_pressed = False

print(f"Listening for events on {dev.name}...")
print("- Hold Left-Click + Scroll to cycle windows horizontally.")
print("- Hold Right-Click + Scroll to cycle workspaces vertically.")

for event in dev.read_loop():
    if event.type == ecodes.EV_KEY:
        if event.code == ecodes.BTN_LEFT:
            left_pressed = event.value == 1
        elif event.code == ecodes.BTN_RIGHT:
            right_pressed = event.value == 1
    elif event.type == ecodes.EV_REL and event.code == ecodes.REL_WHEEL:
        action_to_run = None
        # Prioritize left-click scroll over right-click scroll
        if left_pressed and not right_pressed:
            print("DEBUG: Left-Click held. Reinterpreting vertical scroll as horizontal.")
            if event.value < 0:
                action_to_run = 'focus-column-or-monitor-right'
            else:
                action_to_run = 'focus-column-or-monitor-left'
        elif right_pressed and not left_pressed:
            print("DEBUG: Right-Click held. Vertical scroll triggers workspace switch.")
            if event.value < 0:
                action_to_run = 'focus-workspace-down'
            else:
                action_to_run = 'focus-workspace-up'
        else:
            print("DEBUG: Scroll detected without valid modifier. Ignoring.")

        if action_to_run:
            command = [NIRI_EXECUTABLE, 'msg', 'action', action_to_run]
            print(f"RUNNING: {' '.join(command)}")
            subprocess.run(command)

