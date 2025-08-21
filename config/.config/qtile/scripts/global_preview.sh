#!/bin/bash
LOG="/tmp/sushi_preview.log"
echo "---- $(date) ----" >>"$LOG"

# Read from clipboard
FILE=$(xclip -o -selection clipboard | head -n1)
echo "Clipboard: $FILE" >>"$LOG"

if [[ -z "$FILE" ]]; then
	notify-send "Sushi Preview" "Clipboard empty!"
	exit 1
fi

# Expand ~ and make absolute
FILE=$(eval echo "$FILE")
FILE=$(realpath -m "$FILE")
echo "Resolved file: $FILE" >>"$LOG"

if [[ ! -e "$FILE" ]]; then
	notify-send "Sushi Preview" "File not found: $FILE"
	echo "File does not exist: $FILE" >>"$LOG"
	exit 1
fi

notify-send "Sushi Preview" "Opening $FILE"
echo "Launching sushi on: $FILE" >>"$LOG"
sushi "$FILE" &
