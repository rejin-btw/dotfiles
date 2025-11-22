#!/usr/bin/env sh
export PATH="$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH"
export HOME="/home/rejin"
export USER="rejin"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

last_update=0

inotifywait -m /home/rejin/.mozilla/firefox/8okwcnyi.default/ | while read -r directory event filename; do
  # Only react to changes in places.sqlite or related files
  if [[ "$filename" == "places.sqlite"* ]]; then
    current_time=$(date +%s)
    if [ $((current_time - last_update)) -ge 3 ]; then
      echo "Database activity detected, running fuzzel-bookmarks..."
      sleep 1
      /home/rejin/.nix-profile/bin/fuzzel-bookmarks 2>&1 | tee -a /tmp/fuzzel_watcher.log
      echo "Bookmark launchers updated."
      last_update=$(date +%s)
    fi
  fi
done

