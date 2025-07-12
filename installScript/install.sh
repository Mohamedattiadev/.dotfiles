#!/bin/bash
# Arch Linux Bootstrap Script — Dev Environment Setup
# Author: MohamedattiaDev
# GitHub: github.com/MohamedattiaDev

set -euo pipefail

trap 'echo "❌ Script aborted unexpectedly."; exit 1;' ERR

# -------------------- CONFIG --------------------
GIT_NAME="MohamedattiaDev"
GIT_EMAIL="mohamedattia.dev@gmail.com"
DOTFILES_DIR="$HOME/.dotfiles"
# ------------------------------------------------

log() { echo -e "✅ \033[1;32m[INFO]\033[0m $1"; }
warn() { echo -e "⚠️ \033[1;33m[WARN]\033[0m $1"; }
error() { echo -e "❌ \033[1;31m[ERROR]\033[0m $1"; }

# --- Setup: Refresh Keyring & Optimize Mirrors ---
refresh_system() {
	log "Refreshing keyring and optimizing mirrors..."
	sudo pacman-key --refresh-keys
	sudo pacman -Syu --noconfirm
	sudo pacman -S --needed --noconfirm reflector
	sudo reflector --verbose --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	log "Mirrorlist updated."
}

# --- Cleanup Conflicts ---
clean_system() {
	log "Removing known conflicting packages..."
	yay -Rdd --noconfirm libpamac-full pamac-all copyq || true
	sudo pacman -Sc --noconfirm
	yay -Scc --noconfirm || true
}

# --- Install Core & Dev Tools ---
install_packages() {
	log "Installing all core packages and languages..."

	yay -S --needed --noconfirm \
		stow tmux zathura zathura-pdf-poppler neovim docker docker-compose postman-bin alacritty copyq code zed-editor-bin rofi rofi-pass dunst arandr htop kitty okular lazygit pcmanfm vlc obsidian ticktick \
		blueman pavucontrol brave-browser google-chrome chromium whatsdesk zen-browser \
		fish fnm \
		gcc g++ clang cmake make vala \
		python python-rich python-pip rust go lua ruby perl php composer dotnet-sdk mono r \
		jdk-openjdk java-runtime-common \
		nodejs npm pnpm \
		dart flutter swift-bin \
		kotlin kotlinc \
		ghc stack haskell \
		godot love fasm vlang-bin zig \
		lua-language-server pyright rust-analyzer bash-language-server typescript-language-server \
		vscode-langservers-extracted \
		rstudio-desktop-bin

	log "Installing global npm packages..."
	npm install -g live-server typescript eslint prettier nodemon ts-node yarn http-server
}

install_cli_tools() {
	log "Installing modern CLI productivity tools..."

	yay -S --noconfirm --needed \
		bat \
		eza \
		fzf \
		ripgrep \
		fd \
		dust

	log "CLI tools installed."
}

# --- Dotfiles via GNU Stow ---
stow_dotfiles() {
	log "Setting up dotfiles with stow..."
	if [[ ! -d "$DOTFILES_DIR" ]]; then
		warn "Dotfiles directory $DOTFILES_DIR not found. Skipping."
		return
	fi

	if [[ -d "$HOME/.config" ]]; then
		log "Backing up existing ~/.config to ~/dotnone"
		mv -f "$HOME/.config" "$HOME/dotnone"
	fi

	cd "$DOTFILES_DIR"
	stow .tmux config installScript
	cd ~
	log "Dotfiles stowed successfully."
}

# --- Tmux + Git + SSH Config ---
setup_dev_tools() {
	log "Cloning tmux TPM plugin..."
	mkdir -p ~/.config/tmux/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm || true

	log "Configuring Git..."
	git config --global user.name "$GIT_NAME"
	git config --global user.email "$GIT_EMAIL"
}

setup_ssh() {
	if [[ -f "$HOME/.ssh/id_ed25519.pub" ]]; then
		warn "SSH key already exists. Skipping."
	else
		log "Generating new SSH key..."
		ssh-keygen -t ed25519 -C "$GIT_EMAIL" -N ""
	fi

	log "Adding key to ssh-agent..."
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519

	echo -e "\n🔐 Public SSH Key:\n"
	cat ~/.ssh/id_ed25519.pub
	echo -e "\n➡️  Add this key to GitHub (Settings > SSH and GPG Keys)"
}

# --- Main Script Execution ---
main() {
	refresh_system
	clean_system
	stow_dotfiles
	install_packages
	install_cli_tools
	setup_dev_tools
	setup_ssh
	log "🚀 All done! You may want to reboot or logout now."
}

main
