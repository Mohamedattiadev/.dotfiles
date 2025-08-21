
# scripts/float_windows.py
from libqtile import hook

@hook.subscribe.client_new
def float_satty(window):
    if window.window.get_wm_class() and 'satty' in window.window.get_wm_class()[0].lower():
        window.floating = True
        window.cmd_set_size_floating(1000, 700)
        window.cmd_center()

@hook.subscribe.client_new
def float_edit_nvim(window):
    if window.window.get_name() == "edit-field":
        window.floating = True
        window.cmd_set_size_floating(650, 200)

@hook.subscribe.client_new
def float_link_preview(window):
    if window.window.get_name() == "link-preview":
        window.floating = True
        window.cmd_set_size_floating(200, 150)
        window.cmd_set_position_floating(100, 250)

