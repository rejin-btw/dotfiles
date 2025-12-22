#!/usr/bin/env sh

# 1. MAGIC: DETACH FROM TERMINAL
# Prevents the alarm from dying when you close the window
if [ "$ALARM_BG_MODE" != "true" ] && [ -t 0 ]; then
    export ALARM_BG_MODE="true"
    setsid -f "$0" "$@" < /dev/null
    exit 0
fi

# 2. PARSE ARGUMENTS (THE FIX IS HERE)
INPUT_TIME=$1
MESSAGE=${2:-"Alarm"}

# Only look for days if the user explicitly typed "repeat"
if [ "$3" = "repeat" ]; then
    shift 3 2>/dev/null
    ALLOWED_DAYS="$@" # Capture mon, tue, etc.
    KEYWORD="repeat"
else
    ALLOWED_DAYS=""
    KEYWORD=""
fi

# 3. HELPER: CHECK IF A DAY IS ALLOWED
is_day_allowed() {
    # If allowed_days is empty, it means "Every Day is Okay"
    if [ -z "$ALLOWED_DAYS" ]; then
        return 0
    fi
    # Check if the day (e.g., Fri) is in the list provided
    if echo "$ALLOWED_DAYS" | grep -qi "$1"; then
        return 0
    else
        return 1
    fi
}

# 4. HELPER: FIND THE NEXT VALID ALARM TIME
get_next_timestamp() {
    offset=0
    # Look ahead up to 365 days
    while [ $offset -le 365 ]; do
        CHECK_DAY=$(date -d "+$offset days" +%a)
        
        if is_day_allowed "$CHECK_DAY"; then
            TARGET_STR="$offset days $INPUT_TIME"
            TARGET_EPOCH=$(date -d "$TARGET_STR" +%s 2>/dev/null)
            NOW_EPOCH=$(date +%s)
            
            # If we found a time in the future, return it!
            if [ "$TARGET_EPOCH" -gt "$NOW_EPOCH" ]; then
                echo "$TARGET_EPOCH"
                return
            fi
        fi
        offset=$((offset + 1))
    done
}

# 5. MAIN LOGIC LOOP
while true; do
    # A) Handle simple duration (10m, 5s)
    if echo "$INPUT_TIME" | grep -qE '^[0-9]+[smhd]$'; then
        sleep "$INPUT_TIME"
        
        # FIRE ALARM
        niri msg action focus-workspace 9
        if command -v notify-send >/dev/null 2>&1; then notify-send "ALARM" "$MESSAGE"; fi
        mpv --title="URGENT_ALARM" --loop=inf --force-window --osd-msg1="$MESSAGE" --osd-font-size=100 /home/rejin/Downloads/alarm.mp4
        exit 0
    fi

    # B) Handle specific time (13:29)
    NEXT_ALARM=$(get_next_timestamp)
    
    if [ -z "$NEXT_ALARM" ]; then
        if command -v notify-send >/dev/null 2>&1; then 
            notify-send "Error" "Could not find a valid date for alarm."
        fi
        exit 1
    fi
    
    NOW=$(date +%s)
    SLEEP_SEC=$((NEXT_ALARM - NOW))
    
    # Wait
    sleep "$SLEEP_SEC"

    # FIRE ALARM
    niri msg action focus-workspace 9
    if command -v notify-send >/dev/null 2>&1; then notify-send "ALARM" "$MESSAGE"; fi
    
    mpv --title="URGENT_ALARM" \
        --loop=inf \
        --force-window \
        --osd-msg1="$MESSAGE" \
        --osd-font-size=100 \
        /home/rejin/Downloads/alarm.mp4

    # Exit if not repeating
    if [ "$KEYWORD" != "repeat" ]; then
        exit 0
    fi

    sleep 5
done
