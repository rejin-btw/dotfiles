#!/usr/bin/env bash

# Force SDL games to use Wayland
export SDL_VIDEODRIVER=wayland

# Run the game
exec endless-sky "$@"
