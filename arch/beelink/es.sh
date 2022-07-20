#!/usr/bin/env bash

HOME_PATH="/home/retro"

mkdir --parents "${HOME_PATH}/.emulationstation"

cat << EOF > "${HOME_PATH}/.emulationstation/es_settings.xml"
<?xml version="1.0"?>
<int name="SoundVolumeNavigation" value="80" />
<int name="SoundVolumeVideos" value="80" />
<string name="GamelistViewStyle" value="detailed" />
<string name="MediaDirectory" value="${HOME_PATH}/es/media" />
<string name="ROMDirectory" value="${HOME_PATH}/roms" />
<string name="ScreensaverSlideshowImageDir" value="${HOME_PATH}/.emulationstation/slideshow/custom_images" />
<string name="ThemeSet" value="modern-DE" />
<string name="UIMode" value="kiosk" />
<string name="UIMode_passkey" value="uuddllrrbb" />
EOF

ln --force --symbolic "${HOME_PATH}/es/lists" "${HOME_PATH}/.emulationstation/gamelists"
