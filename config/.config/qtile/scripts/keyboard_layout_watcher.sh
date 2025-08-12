#!/bin/bash

prev_layout=""

while true; do
	current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')
	if [ "$current_layout" != "$prev_layout" ]; then
		case "$current_layout" in
		us)
			msg="🇺🇸 English (US)"
			;;
		ara)
			msg="🇸🇦 Arabic"
			;;
		tr)
			msg="🇹🇷 Turkish"
			;;
		*)
			msg="$current_layout"
			;;
		esac
		notify-send "Keyboard Layout Changed!" "$msg"
		prev_layout=$current_layout
	fi
	sleep 1
done
