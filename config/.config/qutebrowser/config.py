
config.load_autoconfig()


config.bind(' ', 'nop')  # This ensures space can be used in combinations.

# Bind Space + g to Google search
config.bind('g', 'spawn --userscript qute_search -g', mode='normal')  # Google

# Bind Space + d to DuckDuckGo search
config.bind('d', 'spawn --userscript qute_search -d', mode='normal')  # DuckDuckGo

# Bind Space + y to YouTube search
config.bind('y', 'spawn --userscript qute_search -y', mode='normal')  # YouTube

# Bind Space + w to Wikipedia search
config.bind('w', 'spawn --userscript qute_search -w', mode='normal')  # Wikipedia
config.bind('<Shift-t>', 'open -t')  # Shift + t: Open a new tab
