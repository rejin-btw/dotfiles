# Ensure the NixOS environment is loaded
if [ -f /etc/profile ]; then
    source /etc/profile
fi

# Launch Niri with a clean session
exec niri --session

