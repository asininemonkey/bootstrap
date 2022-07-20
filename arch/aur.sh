#!/usr/bin/env bash

set -ex

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

# Install AUR Packages
passwd --delete jcardoso # Scripted Paru Sudo Workaround

sudo --user jcardoso \
    paru --noconfirm --skipreview --sync \
        amazon-ecr-credential-helper \
        aws-cli-v2-bin \
        chrome-gnome-shell \
        cider-git \
        code-marketplace \
        kind-bin \
        macchina-bin

sudo --user jcardoso \
    paru --noconfirm --skipreview --sync \
        ffmpeg-compat-58 \
        splashtop-business
