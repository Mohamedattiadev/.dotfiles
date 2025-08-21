
# scripts/toggle_apps.py
import os
from libqtile.lazy import lazy
from libqtile import hook
from libqtile.backend.base import Window

sum_group = "S"
sum_title = "nvimsum"
sum_file = os.path.expanduser("~/.config/rofi/Todo_files/sum.md")
obsidian_group = "S"
obsidian_class = "obsidian"
last_group = [None]

@lazy.function
def toggle_sum(qtile):
    current_group = qtile.current_group.name
    if current_group == sum_group:
        if last_group[0]:
            qtile.groups_map[last_group[0]].toscreen()
        return
    last_group[0] = current_group
    if not os.path.exists(sum_file):
        with open(sum_file, "w") as f:
            f.write("")
    for window in qtile.windows_map.values():
        if window.name == sum_title:
            qtile.groups_map[sum_group].toscreen()
            return
    qtile.groups_map[sum_group].toscreen()
    qtile.cmd_spawn(f'alacritty --title {sum_title} -e nvim {sum_file}')

@lazy.function
def toggle_obsidian(qtile):
    current_group = qtile.current_group.name
    if current_group == obsidian_group:
        if last_group[0]:
            qtile.groups_map[last_group[0]].toscreen()
        return
    last_group[0] = current_group
    for window in qtile.windows_map.values():
        if not isinstance(window, Window):
            continue
        wm_class = window.get_wm_class()
        if wm_class and obsidian_class in wm_class:
            qtile.groups_map[obsidian_group].toscreen()
            return
    qtile.groups_map[obsidian_group].toscreen()
    qtile.cmd_spawn("/home/ati/Desktop/Obsidian-1.7.7.AppImage")

@hook.subscribe.client_killed
def auto_return_after_obsidian_killed(window):
    if not isinstance(window, Window):
        return
    wm_class = window.get_wm_class()
    if wm_class and obsidian_class in wm_class and last_group[0]:
        window.qtile.groups_map[last_group[0]].toscreen()

@hook.subscribe.client_killed
def auto_return_after_sum_killed(window):
    if window.name == sum_title and last_group[0]:
        window.qtile.groups_map[last_group[0]].toscreen()
