#!/bin/bash

# This script will install Stylua and additional languages and servers on an Arch-based system

# 0. Force Remove Problematic Packages
# This command removes `libpamac-full` while ignoring dependencies. Use with caution.
echo "Removing problematic packages..."
paru -Rdd libpamac-full  --noconfirm
# 1. Remove Package Caches
# Clear the package cache to ensure old or conflicting packages are removed.
echo "Removing package caches..."
paru -Scc --noconfirm
sudo pacman -Sc --noconfirm && paru -Sc --noconfirm 

# 2. Update the Keyring
# Update the keyring to ensure package signatures are up-to-date.
echo "Updating keyring..."
paru -S archlinux-keyring --noconfirm
paru -Sy archlinux-keyring --noconfirm
paru -S archlinux-keyring --noconfirm

paru -Rdd copyq
sudo pacman -Rdd pamac-all --noconfirm
#2.1 installing yay 
echo "installing yay..."
paru -S yay --noconfirm

# 3.stowing
echo "stowing..."

yay -S stow --noconfirm
cd ~
mkdir dotnone
mv -f ~/.config ~/dotnone
sleep 5

 cd ~/.dotfiles || { echo "Dotfiles directory not found!"; exit 1; }

stow .tmux/
sleep 2
stow config/
sleep 2
stow installScript/

echo "stowing done ..."

sleep 5


# 3. Update the Keyring Again
# Update the keyring again to ensure package signatures are up-to-date.
echo "Updating..."
yay -Syu --noconfirm
sudo pacman -Sc --noconfirm && yay -Sc --noconfirm && yay -Sc --noconfirm
yay -Syu --noconfirm

#---------------------------------Additionals----------------------------------#

# Install Additional Languages and Servers
echo "Installing additional programming languages and servers..."
yay -S --noconfirm   \
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
yay -S --noconfirm copyq yazi tmux neovim brave qutebrowser chromium pomatez blueman pavucontrol whatsdesk

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
yay -Syu  --noconfirm

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

eval (ssh-agent -c)


echo "## this is the key which u should add to ur github"

cat ~/.ssh/id_ed25519.pub
echo "--> Go to GitHub > Settings > SSH and GPG keys and add the key."
echo "--> after connecting it with the github excute this commend--> ssh -T git@github.com"


echo "done......."
