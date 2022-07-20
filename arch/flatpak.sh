#!/usr/bin/env bash

flatpak install --noninteractive flathub \
    'com.github.tchx84.Flatseal' \
    'com.mattjakeman.ExtensionManager' \
    'com.rafaelmardojai.Blanket' \
    'com.slack.Slack' \
    'com.valvesoftware.Steam' \
    'com.valvesoftware.Steam.CompatibilityTool.Proton' \
    'io.github.hmlendea.geforcenow-electron' \
    'org.videolan.VLC' \
    're.chiaki.Chiaki'

flatpak uninstall --noninteractive --unused
