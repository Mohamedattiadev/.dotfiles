#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# My fish config. Not much to see here; just some pretty standard stuff.

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $HOME/Desktop $fish_user_paths

### EXPORT ###

set fish_greeting # Supresses fish's intro message
set TERM xterm-256color # Sets the terminal type
set VISUAL nvim # $VISUAL use Emacs in GUI mode
set EDITOR nvim # $EDITOR use Emacs in terminal

### SET MANPAGER
### Uncomment only one of these!

### "nvim" as manpager
set -x MANPAGER "nvim +Man!"

### "less" as manpager
# set -x MANPAGER "less"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
    # fish_default_key_bindings
    fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###

# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

# # Function for org-agenda
# function org-search -d "send a search string to org-mode"
#     set -l output (/usr/bin/emacsclient -a "" -e "(message \"%s\" (mapconcat #'substring-no-properties \
#         (mapcar #'org-link-display-format \
#         (org-ql-query \
#         :select #'org-get-heading \
#         :from  (org-agenda-files) \
#         :where (org-ql--query-string-to-sexp \"$argv\"))) \
#         \"
#     \"))")
#     printf $output
# end

### END OF FUNCTIONS ###

### ALIASES ###
#ati alias
alias ati='cd $HOME/Attia-Pro/'
#clear
alias cl='clear'
#exit
alias e='exit'
alias ex='exit'
alias exi='exit'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

#tmux
alias tmuxdev='tmux new-session -A -s dev'
alias tmuxmedo='tmux new-session -A -s medo'
alias tls='tmux ls'

# Smart tmux wrapper
function tmux
    set -l cmds attach-session detach kill-server kill-session kill-pane kill-window \
        list-sessions ls new-session rename-session display-message show-messages \
        switch-client source-file run-shell save-buffer list-keys select-pane \
        split-window resize-pane move-window clock-mode send-keys capture-pane

    switch (count $argv)
        case 0
            command tmux
        case 1
            if contains $argv[1] $cmds
                command tmux $argv[1]
            else
                set -l session $argv[1]
                tmux has-session -t $session 2>/dev/null
                and command tmux attach-session -t $session
                or command tmux new-session -s $session
            end
        case '*'
            command tmux $argv
    end
end

# Kill all sessions except 'dev' and 'medo'
function tmuxDel
    for session in (tmux list-sessions -F '#S' 2>/dev/null)
        if not contains $session dev medo
            echo "Killing tmux session: $session"
            tmux kill-session -t $session
        end
    end
end

#img func
function img
    if not type -q feh
        echo "feh not found. Installing with yay..."
        yay -S --noconfirm feh
    end

    feh --title ImagePopup --zoom fill $argv
end

#pwd copy to cliboard func 
function pwd
    set full_path (builtin pwd)
    echo $full_path

    set display_path (string replace --regex "^$HOME" "~" $full_path)

    if not type -q xclip
        echo "xclip not found. Installing with yay..."
        yay -S --noconfirm xclip
    end

    echo $display_path | xclip -selection clipboard
end

function src
    echo "🔄 Reloading config files..."

    # Fish shell
    if test -f ~/.config/fish/config.fish
        source ~/.config/fish/config.fish
        echo "✅ Reloaded: config.fish"
    end

    # Bash
    if test -f ~/.bashrc
        bash -c "source ~/.bashrc"
        echo "✅ Reloaded: .bashrc"
    end

    # Zsh
    if test -f ~/.zshrc
        zsh -c "source ~/.zshrc"
        echo "✅ Reloaded: .zshrc"
    end

    # Profile (used by both Bash and others)
    if test -f ~/.profile
        bash -c "source ~/.profile"
        echo "✅ Reloaded: .profile"
    end

    echo "🚀 All configs sourced (in subshells where needed)"
end
#yay fzf
function yay
    if test (count $argv) -eq 0
        set selected (
            command yay -Sl | fzf --multi \
                --with-nth=2 \
                --preview 'clear ; yay -Si (echo {} | awk "{print \$2}")' \
                --preview-window=right:70%:wrap \
            | awk '{print $2}'
        )

        if test -n "$selected"
            command yay -S $selected
        end
    else
        command yay $argv
    end
end

# yayd.fish - Remove packages with fzf
function yayd
    if test (count $argv) -eq 0
        set selected (
            pacman -Qq | fzf --multi \
                --preview 'clear; yay -Qi {}' \
                --preview-window=right:70%:wrap
        )

        if test -n "$selected"
            command yay -Rns $selected
        end
    else
        command yay -Rns $argv
    end
end
#showkeys
alias showkeys="screenkey"

# vim and emacs
alias vim='nvim'
alias vi='nvim'
alias n='nvim'
alias nv='nvim'
alias nvi='nvim'
alias nvim='nvim'
# alias nvd='nvim --server /tmp/nvimsocket'
#
# function nvk
#     set daemon_pid (pgrep -f "nvim --headless --listen /tmp/nvimsocket")
#
#     if test -z "$daemon_pid"
#         echo "No nvim daemon found on /tmp/nvimsocket"
#         return 1
#     end
#
#     for pid in (pgrep nvim)
#         if not contains $pid $daemon_pid
#             echo "Killing nvim process $pid"
#             kill $pid
#         end
#     end
# end
# alias em='/usr/bin/emacs -nw'
# alias emacs="emacsclient -c -a 'emacs'"
# alias rem="killall emacs || echo 'Emacs server not running'; /usr/bin/emacs --daemon"

# ls | grep
alias lsg='ls | grep'
#Syncthing solve confliction with of todos
alias slc=" $HOME/.config/qtile/scripts/sync_todo_conflict_resolver.sh"

# df -disk usage
alias df="python3 $HOME/.config/fish/scripts/df.py"
alias dfh="python3 $HOME/.config/fish/scripts/dfh"
# Changing "ls" to "eza"
alias lst="python3 $HOME/.config/fish/scripts/lst.py"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first' # all files and dirs
alias ll='eza -l --color=always --group-directories-first' # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

# pacman and yay
alias pacsyu='sudo pacman -Syu' # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu' # Refresh pkglist & update standard pkgs
alias parsua='paru -Sua --noconfirm' # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm' # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck' # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)' # remove orphaned packages (DANGEROUS!)

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# adding flags
# alias df='df -h' # human-readable sizes
alias free="python3 $HOME/.config/fish/scripts/free.py"

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Play audio files in current dir by type
alias playwav='vlc *.wav'
alias playogg='vlc *.ogg'
alias playmp3='vlc *.mp3'

# Play video files in current dir by type
alias playavi='vlc *.avi'
alias playmov='vlc *.mov'
alias playmp4='vlc *.mp4'

# switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# bare git repo alias for dotfiles
# alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias cf="nvim $HOME/.config"

# termbin
alias tb="nc termbin.com 9999"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Mocp must be launched with bash instead of Fish!
alias mocp="bash -c mocp"
#-----------------------------
#-----------------------------

# Alias for launching Firefox with custom scaling
alias firefox-small="firefox --layout.css.devPixelsPerPx=0.8"

# Alias for launching Chromium with custom scaling
alias chromium-small="chromium --force-device-scale-factor=0.8"

# Alias for launching Brave with custom scaling
alias brave-small="brave --force-device-scale-factor=0.8"

#-----------------------------
#zed

# set -U fish_user_paths /home/ati/.local/zed.app/bin/zed $fish_user_paths
#-----------------------------
### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
colorscript random

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

###----tmux---###
export TMUX_CONF=~/.config/.tmux.conf

###----tmuxifier---###
set -gx PATH $HOME/.tmux/plugins/tmuxifier/bin $PATH
#eval (tmuxifier init - fish)

###---fcitx---- for lang###
set -x GTK_IM_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x SDL_IM_MODULE fcitx
set -x XMODIFIERS '@im=fcitx'
#---- ---------- ------

function virtucop
    WINEPREFIX="/home/ati/.wine" wine "/home/ati/Downloads/VirtuaCop/Virtua_Cop_Win_RIP_EN/Game Files/PPJDD.EXE"
end

# pnpm
set -gx PNPM_HOME "/home/ati/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# fnm (nvm alter)
fnm env | source
# fnm (nvm alter) end 

# =============================================================================
# FZF Configuration
# =============================================================================

# Set default fzf options for a large, borderless popup UI

set -Ux FZF_DEFAULT_OPTS "\
--height=60% \
--layout=reverse \
--multi \
--info=inline \
--tiebreak=begin,length \
--ansi \
--border=rounded \
--color=fg:#bbc2cf,bg:#282c34,hl:#51afef \
--color=fg+:#eeeeee,bg+:#3e4451,hl+:#51afef \
--color=info:#c678dd,prompt:#98be65,pointer:#ff6c6b \
--color=marker:#da8548,spinner:#61afef,header:#51afef \
--preview-window=right:55%:wrap \
--preview='clear; bat --style=numbers,changes --color=always --paging=never {} || exa -T --icons {} || file {}'"

# --- Keybinding OtPTIONS ---

# Ctrl+T - Find files and directories
set -g fzf_fd_opts --hidden --follow --exclude .git

# Alt+C - Change directory
set -g fzf_alt_c_opts # Options can be added here if needed

# Ctrl+R - Search command history (now copies on Enter)
set -g fzf_history_opts '\
--preview-window=right:55%:wrap \
--preview="echo {} | clear; bat --language=sh --color=always" \
--bind="ctrl-y:execute-silent(echo -n {1..} | command copyq copy --)+abort" \
--bind="enter:accept+execute(echo -n {1..} | command copyq copy --)"'

# --- Custom Keybindings ---

# Bind Ctrl+O to find a file from history and edit it in default and insert modes
bind \co fe
bind -M insert \co fe

# --- ACTIVATE FZF KEYBINDINGS ---
# This enables the default Ctrl+T, Ctrl+R, and Alt+C behaviors.
# It MUST come before any overrides.
fzf --fish | source

# =============================================================================
# FZF OVERRIDES (MUST BE AT THE VERY END OF CONFIG.FISH)
# =============================================================================
#

# Override the default Ctrl+T behavior to open the selected file(s) in nvim
function fzf-file-widget
    # Use our new launcher instead of calling fzf directly
    set -l selected (fd --type f $fzf_fd_opts | fzf_launcher)
    if test -n "$selected"
        nvim $selected
    end
    commandline -f repaint
end

#tv
function tv
    /usr/bin/tv $argv
end
# ------------------------------------------------------------------------------
# pyenv
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH

# Initialize pyenv
status --is-interactive; and source (pyenv init -|psub)
#---------------------  zoxide --------------------
zoxide init fish | source
