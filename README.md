# 🛠️ Mohamed Attia's Dotfiles

> Based on [DistroTube's dtos](https://gitlab.com/dwt1/dtos), customized and expanded into a full-featured, keyboard-first development and daily-driver environment.

---

## 📦 Overview

This dotfiles repo represents my personal Linux setup, optimized for speed, aesthetics, keyboard efficiency, and deep integration with modern tools like GPT, Neovim IDEs, and window automation.  
It extends DTOS with custom scripts, enhanced editor capabilities, better browser workflows, and tightly integrated AI tooling.

---

## 🧱 Stack & Core Tools

- **Window Manager**: Qtile (tiled, X11, Python-configurable)
- **Shell**: Fish (with custom prompts, aliases, completions)
- **Terminal**: Alacritty (GPU-accelerated)
- **Editor**: Neovim (LSP, Treesitter, Supermaven integration)
- **Browser**: Qutebrowser (keyboard-driven) with custom Surfingkeys
- **AI Inline_assistant:**: GPTScript clipboard assistant powered by Google Gemini
- **Launcher**: Rofi with custom scripts (brightness, power, screen)
- **Multiplexer**: TMUX with plugin support
- **System**: Arch Linux + custom `installScript`

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

---

### ⚡ Neovim as IDE

- Built-in LSP support (multiple langs)
- Autocompletion with `nvim-cmp` and `Supermaven`
- Treesitter syntax parsing
- Git signs, fuzzy finding, file tree, and more

---

### 🌐 Browser Tweaks

- Qutebrowser with Vim-style keyboard navigation
- Integrated theme and keybindings
- Focus on speed and privacy

---

### 🎛️ Custom Rofi Scripts

- Light control: `rofi-light`
- TODO script: `rofi-todo`

---

### 🖱️ Touchpad & X11 Fixes

- `libinput` config with tap-to-click
- Scripts to enable/disable touchpad on demand

---

## 🧪 Installation

### 🌀 Clone the Dotfiles

```bash
git clone https://github.com/MohamedattiaDev/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### 🧷 Use GNU Stow to Symlink Files

```bash
stow config          # Links everything inside config/.config to ~/.config
stow tmux            # Links .tmux.conf to ~/
stow installScript   # Links install.sh to ~/
```

### ▶️ Run the Installer

```bash
cd ~                 # Move to your home directory

chmod +x install.sh  # Make the script executable
./install.sh         # Run the install script
```

> The `installScript` folder contains logic for setting up Qtile, installing packages, configuring X11, Fish, Neovim, and more.

---

## ⚙️ Environment Variables Setup

✅ The following environment variables will be appended to `/etc/environment` automatically during install:

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

⚠️ After installation:

1. Open `/etc/environment` with sudo
2. Replace `your_gemini_api_here` with your actual API key
3. Then **reboot** or run: `source /etc/environment`

---

## 🔐 VSCode Integration

> if u are a vscode + vim user, you can use the `keybinding.json` and `settings.json` to get the best experience.

- Vim emulation with smooth motion
- `keybinding.json` + `settings.json` for full productivity

---

## 🧹 What's Customized Beyond DTOS

- GPT clipboard assistant integration
- Supermaven Copilot alt in Neovim
- Touchpad config with tap + gestures
- Qutebrowser full rebuild
- Custom Rofi scripts for brightness, TODO
- Fish shell customization
- Tmux customization
- Light/dark themes
- GPTScript `/gpt`, `/mail`, `/sum` support
- VSCode-Vim enhancements

---

## 📜 License

MIT © 2025 Mohamed Attia  
Forked from DTOS by DistroTube

---

> 🧠 This system is meant to be minimal, efficient, hackable, and ready for development, browsing, scripting, and thinking.
