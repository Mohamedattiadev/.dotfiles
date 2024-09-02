#!/bin/bash

# This script will install Stylua and additional languages and servers on an Arch-based system

# 0. Force Remove Problematic Packages
# This command removes `libpamac-full` while ignoring dependencies. Use with caution.
echo "Removing problematic packages..."
paru -Rdd libpamac-full 
# 1. Remove Package Caches
# Clear the package cache to ensure old or conflicting packages are removed.
echo "Removing package caches..."
paru -Scc 

# 2. Update the Keyring
# Update the keyring to ensure package signatures are up-to-date.
echo "Updating keyring..."
paru -S archlinux-keyring 
paru -Syu archlinux-keyring 

# 2.stowing
paru -S stow
sleep 5
 cd ~/.dotfiles || { echo "Dotfiles directory not found!"; exit 1; }
stow .tmux/
stow config/
stow installScript/



# 3. Update the Keyring Again
# Update the keyring again to ensure package signatures are up-to-date.
echo "Updating..."
paru -Syu 
sudo pacman -Sc --noconfirm && paru -Sc --noconfirm && yay -Sc --noconfirm
paru

#---------------------------------Additionals----------------------------------#

# Install Additional Languages and Servers
echo "Installing additional programming languages and servers..."
paru -S    \
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
paru -S  \
	vscode-langservers-extracted \
	bash-language-server \
	pyright \
	typescript-language-server \
	rls \
	rust-analyzer

# Install additional programs
echo "Installing additional programs..."
paru -S  yazi tmux neovim brave qutebrowser chromium pomatez blueman pavucontrol whatsdesk

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
paru -Syu 

#done...

echo "done......."


#---------------------------------Additionals----------------------------------#

# additional git stuff

echo "adding the user and email config of git"
git config --global user.name "MohamedattiaDev"
git config --global user.email "mohamedattia.dev@gmail.com"

#-------ssh--------#

ls -al ~/.ssh

ssh-keygen -t ed25519 -C "mohamedattia.dev@gmail.com"

eval (ssh-agent -c)

ssh-add ~/.ssh/id_ed25519

echo "## this is the key which u should add to ur github"

cat ~/.ssh/id_ed25519.pub
echo "--> Go to GitHub > Settings > SSH and GPG keys and add the key."

echo "done......."
