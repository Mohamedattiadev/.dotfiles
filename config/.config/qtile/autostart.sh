#!/usr/bin/env bash

COLORSCHEME=DoomOne

# --- 0. Pre-X configuration ---
# If possible, move resolution config into ~/.xprofile or Xorg config so it's applied before Qtile.
# Otherwise, do it in the background:
(systemd-detect-virt | grep -qv none && ~/.config/qtile/scripts/set_vm_resolution.sh) &

# --- 1. Instant essentials (start first, no sleeps) ---
lxsession &
picom &
dunst &
nm-applet &
"$HOME"/.screenlayout/layout.sh &
copyq &

# Wallpaper (non-blocking)
### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###

# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch <~/.cache/wall &

# 2. Uncomment to set a random wallpaper on login
# (find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch) &

# 3. Uncomment to set wallpaper with nitrogen
nitrogen --restore &

### SETS CONKY STYLE BASED ON SCREEN RESOLUTION
# Checks screen resolution.  If 1080p or higher, then we use '01' conky.
# If less than 1080p (laptops?), then we use the smaller '02' conky.

# if [[ $resolutionHeight -ge 1080 ]]; then
# 	killall conky || echo "Conky not running."
# 	# sleep 2
# 	conky -c "$HOME"/.config/conky/qtile/01/"$COLORSCHEME".conf || echo "Couldn't start conky."
# elif [[ $resolutionHeight -lt 1080 ]]; then
# 	killall conky || echo "Conky not running."
# 	# sleep 2
# 	conky -c "$HOME"/.config/conky/qtile/02/"$COLORSCHEME".conf || echo "Couldn't start conky."
# else
# 	killall conky || echo "Conky not running."
# 	# sleep 2
# 	conky -c "$HOME"/.config/conky/qtile/02/"$COLORSCHEME".conf || echo "Couldn't start conky."
# fi

# --- 2. Light apps (start right after essentials) ---
pamac-tray-icon-plasma &
kdeconnectd &

# --- 3. Heavy apps (deferred a few seconds) ---
(
	sleep 3
	warpd &
	brave https://www.youtube.com &
	pcmanfm &
	# env GTK_THEME=Adwaita:dark nautilus &
	alacritty &
	gromit-mpx &
	# ticktick &
) &

(
	sleep 8
	qutebrowser &
) &
# --- 4. Daemons / services ---
# (
# sleep 5
# emacs --daemon &
# nvim --headless --listen /tmp/nvimsocket &
# ) &

# --- 5. Systemd user services (batched where possible) ---
(
	sleep 8
	systemctl --user enable --now hintsd.service at-spi-dbus-bus.service
	systemctl --user is-enabled battery-alert.timer >/dev/null 2>&1 ||
		systemctl --user enable --now battery-alert.timer
	syncthing serve --no-browser &
) &

# --- 6. Watchers / scripts ---
~/.config/qtile/scripts/keyboard_layout_watcher.sh &
~/.config/qtile/scripts/watch_todo_conflicts.sh &
