#!/bin/bash

# ===== CONFIGURATION =====
IDLE_MINUTES=5    # idle time before locking the screen
# =========================

BASE="$HOME/screenwatch"
DATA="$BASE/data"
SHOTS="$BASE/shots"

COUNT_FILE="$DATA/count.txt"
HASH_FILE="$DATA/hash.txt"

mkdir -p "$DATA" "$SHOTS"

[ ! -f "$COUNT_FILE" ] && echo 0 > "$COUNT_FILE"

SHOT="$SHOTS/shot_$(date +%Y%m%d_%H%M%S).jpg"

# Lightweight screenshot:
# - low quality
# - fixed region
# - avoids overwriting
scrot "$SHOT" -q 60 -z -a 400,200,800,600

NEWHASH=$(md5sum "$SHOT" | awk '{print $1}')
OLDHASH=$(cat "$HASH_FILE" 2>/dev/null)

if [ "$NEWHASH" = "$OLDHASH" ]; then
    C=$(cat "$COUNT_FILE")
    C=$((C + 1))
else
    C=0
fi

echo "$C" > "$COUNT_FILE"
echo "$NEWHASH" > "$HASH_FILE"

# Delete screenshots older than 10 minutes
find "$SHOTS" -type f -mmin +10 -delete

# Idle long enough → lock the screen
if [ "$C" -ge "$IDLE_MINUTES" ]; then
    xset s activate
    echo 0 > "$COUNT_FILE"
fi
