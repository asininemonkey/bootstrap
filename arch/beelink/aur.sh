#!/usr/bin/env bash

# Install Paru
if [[ -d "/tmp/paru-bin" ]]
then
    rm --force --recursive /tmp/paru-bin
fi

git -C /tmp clone https://aur.archlinux.org/paru-bin.git
chown --recursive nobody /tmp/paru-bin
cd /tmp/paru-bin
sudo --user nobody makepkg
pacman --noconfirm --upgrade *.pkg.tar.zst

passwd --delete retro # Scripted Paru Sudo Workaround

# Install EmulationStation Desktop Edition
sudo --user retro \
    paru --noconfirm --skipreview --sync emulationstation-de
