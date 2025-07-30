# 🛠️ Mohamed Attia's Dotfiles

> Based on [DistroTube's dtos](https://gitlab.com/dwt1/dtos), customized and expanded into a full-featured, keyboard-first development and daily-driver environment.

---

## 📦 Overview

This dotfiles repo represents my personal Linux setup, optimized for speed, aesthetics, keyboard efficiency, and deep integration with modern tools like GPT, Neovim IDEs, and window automation. It extends DTOS with custom scripts, enhanced editor capabilities, better browser workflows, and tightly integrated AI tooling.

---

## 🧱 Stack & Core Tools

- **Window Manager**: Qtile (tiled, X11, Python-configurable)
- **Shell**: Fish (with custom prompts, aliases, completions)
- **Terminal**: Alacritty (GPU-accelerated)
- **Editor**: Neovim (LSP, Treesitter, Supermaven integration)
- **Browser**: Qutebrowser (keyboard-driven) with custom Surfingkeys
- **AI**: GPTScript clipboard assistant powered by Google Gemini
- **Launcher**: Rofi with custom scripts (brightness, power, screen)
- **Multiplexer**: TMUX with plugin support
- **System**: Arch Linux + custom installScript

---

## 📁 Directory Structure

```text
.dotfiles/
├── .tmux/                         → TMUX plugin setup
├── installScript/                → Arch bootstrap and setup
├── keybinding.json               → VSCode Vim keybindings
├── settings.json                 → VSCode settings
├── config/.config/               → All application configs:
│   ├── alacritty/                → Terminal config
│   ├── nvim/                     → Neovim setup (LSP, CMP, Supermaven)
│   ├── fish/                     → Shell setup
│   ├── qtile/                    → WM logic & layout
│   ├── rofi/                     → Launcher UI + custom scripts
│   ├── qutebrowser/              → Browser config, Surfingkeys
│   ├── dunst/, picom/, kitty/, copyq/, pamac/, etc.
│   ├── GPTScript/                → GPT inline assistant
│   └── systemd/, pulse/, xfce4/, ticktick/, zathura/
```

---

## ✨ Features

### 🔮 GPTScript Assistant

Clipboard-triggered AI using Google Gemini API. Commands like:

- `/gpt` → General question answering
- `/mail` → Email drafts from summaries
- `/sum` → Summarize long clipboard content

Integrated with `xdotool` and `xclip`.

> Combined with a custom GPTScript, accessible from a **Qtile scratchpad terminal**, allowing fast prompts to Gemini, DeepSeek, or even Obsidian note generation.

---

### ⚡ Neovim as IDE

- Built-in LSP support (multiple langs)
- Autocompletion with `nvim-cmp` and `Supermaven`
- Treesitter syntax parsing
- Git signs, fuzzy finding, file tree, and more

---

### 🌐 Browser Tweaks

- **Qutebrowser** with Vim-style keyboard navigation
- **Custom keybindings** and configuration for optimal tab, search, and hint navigation
- Integrated theme for minimal distraction
- Focus on **speed and privacy**

---

### 🎛️ Custom Rofi Scripts

- Light control: `rofi-light`
- TODO script: `rofi-todo`

---

### 🧠 Productivity Boosters

- ✅ **Hints** (via [`AlfredoSqueido/hints`](https://github.com/AlfredoSequeida/hints))

  - Creates clickable numeric hints anywhere on screen
  - Similar to macOS Homerow-style launcher hints
  - Pairs **perfectly with `warpd`** for keyboard-driven mouse control

- ✅ **Warpd**

  - Warp anywhere on the screen with the keyboard
  - Excellent companion to `hints` for zero-mouse workflows

- ✅ **Qtile Scratchpads**
  - Two floating terminal scratchpads for:
    - GPTScript Assistant
    - Obsidian Notes
    - DeepSeek CLI
  - Launch instantly with hotkeys for quick thought capture or coding

---

### 🖱️ Touchpad & X11 Fixes

- `libinput` config with tap-to-click
- Scripts to enable/disable touchpad on demand

---

## 🧪 Installation

Clone and run the setup:

```bash
git clone https://github.com/MohamedattiaDev/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Use stow to symlink dotfiles
stow config          # Links everything inside config/.config to ~/.config
stow tmux            # Links .tmux.conf to ~/
stow installScript   # Links install.sh to ~/

# Move to home directory to execute
cd ~
chmod +x install.sh
./install.sh         # Run the install script
```

> The `installScript` folder contains logic for setting up Qtile, installing packages, configuring X11, fish, Neovim, and more.

---

> ✅ The following environment variables will be appended to `/etc/environment` automatically during install:

```env
# Required for 'hints'
ACCESSIBILITY_ENABLED=1
GTK_MODULES=gail:atk-bridge
OOO_FORCE_DESKTOP=gnome
GNOME_ACCESSIBILITY=1
QT_ACCESSIBILITY=1
QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1

# Placeholder for Gemini API key (required by GPTScript)
GEMINI_API_KEY=your_gemini_api_here
```

> ⚠️ After installation, edit `/etc/environment` and replace `your_gemini_api_here` with your actual Gemini API key. Then reboot or `source /etc/environment` to apply changes.

---

## 🔐 VSCode Integration

- Vim emulation with smooth motion
- `keybinding.json` + `settings.json` for full productivity
- GitHub Copilot Alternative (`Supermaven` on Neovim)

---

## 🧹 What's Customized Beyond DTOS

- GPT clipboard assistant integration
- Supermaven Copilot alt in Neovim
- Touchpad config with tap + gestures
- Qutebrowser full rebuild with custom keybindings
- Custom Rofi scripts for brightness, TODO
- Fish shell customization
- Tmux customization
- Light/dark themes
- GPTScript `/gpt`, `/mail`, `/sum` support
- VSCode-Vim enhancements
- Qtile scratchpads with AI tools (GPT, DeepSeek, Obsidian)
- Warpd + Hints for full keyboard control

---

## 📜 License

MIT © 2025 Mohamed Attia  
Forked from DTOS by DistroTube

---

> 🧠 This system is meant to be minimal, efficient, hackable, and ready for development, browsing, scripting, and thinking.
