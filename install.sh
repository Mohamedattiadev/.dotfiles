#!/bin/bash

# This script will install Stylua and additional languages and servers on an Arch-based system

# 1. Remove Package Caches
# Clear the package cache to ensure old or conflicting packages are removed.
echo "Removing package caches..."
sudo pacman -Scc --noconfirm

# 2. Update the Keyring
# Update the keyring to ensure package signatures are up-to-date.
echo "Updating keyring..."
sudo pacman -Syu archlinux-keyring --noconfirm

# 3. Force Remove Problematic Packages
# This command removes `libpamac-full` while ignoring dependencies. Use with caution.
echo "Removing problematic packages..."
sudo pacman -Rdd libpamac-full --noconfirm

# 4. installing yay and paru if not found
echo "Checking for AUR helpers..."
# Check if paru is installed
if command -v paru &>/dev/null; then
	echo "paru is already installed."
	AUR_HELPER="paru"
# Check if yay is installed
elif command -v yay &>/dev/null; then
	echo "yay is already installed."
	AUR_HELPER="yay"
else
	echo "Neither paru nor yay is installed. Installing both..."

	# # Update the system first
	# sudo pacman -Syu --noconfirm

	# Install yay and paru
	sudo pacman -S --noconfirm yay
	yay -S --noconfirm paru

	# Re-check if yay is installed
	if command -v yay &>/dev/null; then
		echo "yay is now installed."
		AUR_HELPER="yay"
	else
		echo "Failed to install yay. Exiting."
		exit 1
	fi
fi

# Update the system using the AUR helper
if [[ "$AUR_HELPER" == "yay" ]]; then
	echo "Updating system using yay..."
	if yay -Syu --noconfirm; then
		echo "System updated successfully with yay."
	else
		echo "Failed to update with yay. Falling back to pacman..."
		sudo pacman -Syu --noconfirm
	fi
elif [[ "$AUR_HELPER" == "paru" ]]; then
	echo "Updating system using paru..."
	paru -Syu --noconfirm
else
	echo "No AUR helper found. Exiting."
	exit 1
fi

# 6. Update the Keyring Again
# Update the keyring again to ensure package signatures are up-to-date.
echo "Updating keyring again..."
yay -S archlinux-keyring --noconfirm
yay -Syu --noconfirm

#---------------------------------Additionals----------------------------------#

# Install Additional Languages and Servers
echo "Installing additional programming languages and servers..."
yay -S --noconfirm \
	gcc \
	g++ \
	java-runtime-common \
	nodejs \
	npm \
	python \
	python-pip \
	rust \
	go

# Install Language Servers from AUR if needed
echo "Installing language servers..."
yay -S --noconfirm \
	vscode-langservers-extracted \
	bash-language-server \
	pyright \
	typescript-language-server \
	rls \
	rust-analyzer

# Install additional programs
echo "Installing additional programs..."
yay -S --noconfirm yazi tmux neovim brave

# Install live-server using npm
npm install -g live-server

# # Clone and install tmuxifier
# echo "Cloning and installing tmuxifier..."
# git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

echo "Cloning and installing tmux plugins tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm/

echo "Installation complete."

#last update ---

echo "the last update..."
yay -Syu --noconfirm

#done...

echo "done......."
