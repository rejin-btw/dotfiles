#!/usr/bin/env bash

echo "--- Cleaning System (Root) ---"
sudo nix-collect-garbage --delete-older-than 7d

echo "--- Cleaning User (Home Manager) ---"
nix-collect-garbage --delete-older-than 7d

echo "--- Optimizing Store (Deduplication) ---"
nix-store --optimise

echo "Done! System is clean."
