# CRITICAL: Load the autoconfig first.
config.load_autoconfig()

# -----------------------------------------------------------------------------
# Clear all default keybindings except explicitly defined ones
# -----------------------------------------------------------------------------



# Keep <space>f intact
config.bind('<space>f', 'cmd-set-text :')
# Import the theme module (doom_one.py should be in ~/.config/qutebrowser/)
import doom_one

# -----------------------------------------------------------------------------
# Theme & UI
# -----------------------------------------------------------------------------
config.set("colors.webpage.darkmode.enabled", True)
doom_one.setup(c, {
    "spacing": {
        "vertical": 5,
        "horizontal": 5
    }
})

c.fonts.default_family = "JetBrains Mono"
c.fonts.default_size = "9pt"
c.fonts.prompts = 'default_size sans-serif'
c.fonts.statusbar = '11pt "Source Code Pro"'

c.content.blocking.method = 'auto'
c.keyhint.blacklist = ['*']
c.messages.timeout = 0
c.scrolling.smooth = True

# -----------------------------------------------------------------------------
# Startup Pages
# -----------------------------------------------------------------------------
c.url.default_page = 'file:///home/ati/.config/qutebrowser/html/homepage.html'
c.url.start_pages = ['file:///home/ati/.config/qutebrowser/html/homepage.html']

# -----------------------------------------------------------------------------
# Editor & Clipboard
# -----------------------------------------------------------------------------
c.editor.command = ["alacritty", "-e", "nvim", "{}"]
c.content.javascript.clipboard = 'access'

# -----------------------------------------------------------------------------
# Tabs & Statusbar
# -----------------------------------------------------------------------------
c.tabs.show = 'always'

# -----------------------------------------------------------------------------
# Downloads
# -----------------------------------------------------------------------------
c.downloads.location.directory = '~/Downloads'

# -----------------------------------------------------------------------------
# Keybindings - Vim Style
# -----------------------------------------------------------------------------
# unbind
config.unbind('d', mode='normal')
config.unbind('u', mode='normal')
config.unbind('<Ctrl-a>', mode='normal')
config.unbind('<Ctrl-t>', mode='normal')
config.unbind('<Ctrl-q>', mode='normal')
# -----
config.unbind('H', mode='normal')
config.unbind('L', mode='normal')
config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.unbind('<Space>', mode='caret')

# Navigation
config.bind('H', 'tab-prev')
config.bind('L', 'tab-next')
config.bind('<Ctrl-h>', 'back')
config.bind('<Ctrl-l>', 'forward')

# Prompt navigation
config.bind('<Ctrl-j>', 'completion-item-focus --next', mode='prompt')
config.bind('<Ctrl-k>', 'completion-item-focus --prev', mode='prompt')

# Hints
config.bind('T', 'hint links tab')
config.bind('Y', 'hint links yank')
config.bind('M', 'hint links spawn mpv {hint-url}')

# Passthrough
config.bind('<Ctrl-p>', 'mode-enter passthrough ;; message-info "Passthrough mode ON"')
config.bind('<Escape>', 'mode-leave ;; message-info "Passthrough mode OFF"', mode='passthrough')
config.bind('<Escape>', 'clear-messages', mode='normal')

# Custom Commands
config.bind('<space>t', 'open -t', mode='normal')
config.bind('<space>w', 'tab-close')
config.bind('<space>o', 'tab-only')
config.bind('<space>f', 'cmd-set-text :')
config.bind('<space>mgh', 'open https://github.com/MohamedattiaDev')
config.bind('<space>ati', 'open https://mohamedattiaDev.github.io/AtiDocs')
config.bind('<space>ls', 'session-load default')
config.bind('<space>ss', 'session-save default')
config.bind('<space>wq', 'quit --save')
config.bind('<space>w', 'session-save default')
config.bind('<space>V', 'view-source')
config.bind(',d', 'config-cycle colors.webpage.darkmode.enabled')
config.bind('<space><space>', 'cmd-set-text -s :open -t')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind('y', 'yank', mode='normal')
config.bind('y', 'yank selection', mode='caret')
config.bind('<space>i', 'devtools window')
config.bind('V', 'mode-enter caret ;; fake-key V')
config.bind('<space>s', 'history')
config.bind('<space>t', 'yank selection --sel primary ;; cmd-later 100 open --tab {primary}', mode='caret')

# -----------------------------------------------------------------------------
# Search Engines
# -----------------------------------------------------------------------------
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'g': 'https://www.google.com/search?q={}',
    'ddg': 'https://duckduckgo.com/?q={}',
    'br': 'https://search.brave.com/search?q={}',
    'b': 'https://www.bing.com/search?q={}',
    'gh': 'https://github.com/search?q={}',
    'gl': 'https://gitlab.com/search?q={}',
    'so': 'https://stackoverflow.com/search?q={}',
    'npm': 'https://www.npmjs.com/search?q={}',
    'py': 'https://pypi.org/search/?q={}',
    'aur': 'https://aur.archlinux.org/packages/?K={}',
    'aw': 'https://wiki.archlinux.org/index.php?search={}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'wiki': 'https://en.wikipedia.org/w/index.php?search={}',
    'mdn': 'https://developer.mozilla.org/en-US/search?q={}',
    'dev': 'https://devdocs.io/#q={}',
    'chatgpt': 'https://chat.openai.com/?q={}',
    'gemini': 'https://gemini.google.com/?q={}',
    'r': 'https://www.reddit.com/r/all/search?q={}',
    'hn': 'https://hn.algolia.com/?q={}',
}

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
c.aliases.update({
    'dev': 'spawn --userscript ~/.config/qutebrowser/scripts/open-work-tabs',
    'yt': 'open https://www.youtube.com',
    # 'gh': 'open https://github.com',
    'mgh': 'open https://github.com/MohamedattiaDev',
    'ati': 'open https://mohamedattiaDev.github.io/AtiDocs',
    'fa3': 'open https://Fa3elKheer.github.io/Fa3elKheer',
    'g': 'open https://google.com',
    'gl': 'open https://gitlab.com',
    'mail': 'open https://mail.google.com',
    'chat': 'open https://chat.google.com',
    'devdocs': 'open https://devdocs.io'
})

# -----------------------------------------------------------------------------
# Per-domain Settings
# -----------------------------------------------------------------------------
# Accept all cookies
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

# Enable JavaScript
for url in [
    'chrome-devtools://*',
    'devtools://*',
    'chrome://*/*',
    'qute://*/*',
]:
    config.set('content.javascript.enabled', True, url)

# Load images
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

# Notifications
config.set('content.notifications.enabled', True, 'https://www.reddit.com')
config.set('content.notifications.enabled', True, 'https://www.youtube.com')

# User Agents for compatibility
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} '
           '(KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} '
           'Safari/{webkit_version}', 'https://web.whatsapp.com/')

config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0',
           'https://accounts.google.com/*')

config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) '
           'Chrome/99 Safari/537.36', 'https://*.slack.com/*')

config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0',
           'https://docs.google.com/*')

config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0',
           'https://drive.google.com/*')

# -----------------------------------------------------------------------------
# Final Print
# -----------------------------------------------------------------------------
print("--- Custom Developer Config Loaded ---")
