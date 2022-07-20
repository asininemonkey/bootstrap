#!/usr/bin/env bash

HOME_PATH="/home/jcardoso"

EXTENSIONS_PATH="${HOME_PATH}/.local/share/gnome-shell/extensions"

echo -e 'password\toptional\tpam_gnome_keyring.so' >> /etc/pam.d/passwd

mkdir --parents \
    /etc/dconf/db/local.d/locks \
    /etc/dconf/profile \
    /etc/gtk-4.0 \
    "${EXTENSIONS_PATH}"

function install_shell_extension {
    curl --location --output '/tmp/shell-extension.zip' --silent "https://extensions.gnome.org/extension-data/${1}.shell-extension.zip"
    unzip -d "${EXTENSIONS_PATH}/$(unzip -p '/tmp/shell-extension.zip' 'metadata.json' | jq --raw-output '.uuid')" -o '/tmp/shell-extension.zip'
    rm --force '/tmp/shell-extension.zip'
}

install_shell_extension "AlphabeticalAppGridstuarthayhurst.v24"                    # https://extensions.gnome.org/extension/4269/
install_shell_extension "appindicatorsupportrgcjonas.gmail.com.v42"                # https://extensions.gnome.org/extension/615/
install_shell_extension "drive-menugnome-shell-extensions.gcampax.github.com.v51"  # https://extensions.gnome.org/extension/7/
install_shell_extension "extension-listtu.berry.v30"                               # https://extensions.gnome.org/extension/3088/
install_shell_extension "gTilevibou.v50"                                           # https://extensions.gnome.org/extension/28/
install_shell_extension "just-perfection-desktopjust-perfection.v20"               # https://extensions.gnome.org/extension/3843/
install_shell_extension "lockkeysvaina.lt.v47"                                     # https://extensions.gnome.org/extension/36/
install_shell_extension "sound-output-device-chooserkgshank.net.v43"               # https://extensions.gnome.org/extension/906/
install_shell_extension "ssm-gnomelgiki.net.v11"                                   # https://extensions.gnome.org/extension/4506/
install_shell_extension "tiling-assistantleleat-on-github.v34"                     # https://extensions.gnome.org/extension/3733/
install_shell_extension "user-themegnome-shell-extensions.gcampax.github.com.v49"  # https://extensions.gnome.org/extension/19/
install_shell_extension "window-listgnome-shell-extensions.gcampax.github.com.v46" # https://extensions.gnome.org/extension/602/

chown --recursive jcardoso:jcardoso "${EXTENSIONS_PATH}"

cat << 'EOF' > /etc/dconf/db/local.d/ca-desrt-dconf-editor
[ca/desrt/dconf-editor]
show-warning=false
EOF

cat << 'EOF' > /etc/dconf/db/local.d/io-github-celluloid-player
[io/github/celluloid-player/celluloid]
mpv-options='hwdec=vaapi'
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-boxes
[org/gnome/boxes]
first-run=false
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-calculator
[org/gnome/calculator]
button-mode='advanced'
refresh-interval=86400
source-currency='GBP'
target-currency='EUR'
EOF

cat << EOF > /etc/dconf/db/local.d/org-gnome-desktop
[org/gnome/desktop/background]
picture-uri='file://${HOME_PATH}/.local/share/backgrounds/Forest.jpeg'
picture-uri-dark='file://${HOME_PATH}/.local/share/backgrounds/Forest.jpeg'

[org/gnome/desktop/calendar]
show-weekdate=true

[org/gnome/desktop/datetime]
automatic-timezone=false

[org/gnome/desktop/interface]
clock-format='12h'
clock-show-seconds=true
clock-show-weekday=true
color-scheme='prefer-dark'
cursor-size=32
gtk-theme='Adwaita-dark'
icon-theme='Papirus-Dark'
monospace-font-name='Iosevka 11'
text-scaling-factor=1.25

[org/gnome/desktop/media-handling]
autorun-never=true

[org/gnome/desktop/privacy]
old-files-age=uint32 1
recent-files-max-age=1
remove-old-temp-files=true
remove-old-trash-files=true

[org/gnome/desktop/screensaver]
lock-delay=uint32 30
picture-uri='file://${HOME_PATH}/.local/share/backgrounds/Forest.jpeg'

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-gnome-screenshot
[org/gnome/gnome-screenshot]
auto-save-directory='file:///home/jcardoso/Pictures/Screenshots'
last-save-directory='file:///home/jcardoso/Pictures/Screenshots'
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-gnome-system-monitor
[org/gnome/gnome-system-monitor]
disks-interval=1000
graph-update-interval=1000
show-dependencies=true
update-interval=1000
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-mutter
[org/gnome/mutter]
center-new-windows=true
workspaces-only-on-primary=false
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-nautilus
[org/gnome/nautilus/window-state]
sidebar-width=275
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-settings-daemon
[org/gnome/settings-daemon/plugins/power]
sleep-inactive-ac-timeout=0
sleep-inactive-ac-type='nothing'
sleep-inactive-battery-timeout=0
sleep-inactive-battery-type='nothing'
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-shell
[org/gnome/shell]
enabled-extensions=['AlphabeticalAppGrid@stuarthayhurst', 'appindicatorsupport@rgcjonas.gmail.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'extension-list@tu.berry', 'gTile@vibou', 'just-perfection-desktop@just-perfection', 'lockkeys@vaina.lt', 'sound-output-device-chooser@kgshank.net', 'ssm-gnome@lgiki.net', 'tiling-assistant@leleat-on-github', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'window-list@gnome-shell-extensions.gcampax.github.com']
favorite-apps=['firefox.desktop', 'kitty.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop']

[org/gnome/shell/extensions/alphabetical-app-grid]
folder-order-position='end'
show-favourite-apps=true

[org/gnome/shell/extensions/gtile]
grid-sizes='16x16,12x12,8x8,4x4'
show-toggle-tiling=['<Super>z']
theme='Minimal Dark'

[org/gnome/shell/extensions/just-perfection]
accessibility-menu=false

[org/gnome/shell/extensions/simple-system-monitor]
cpu-usage-text='CPU'
font-family='Cantarell'
font-size='18'
is-download-speed-enable=false
is-upload-speed-enable=false
item-separator=' ⋮ '
memory-usage-text='Mem'

[org/gnome/shell/extensions/tiling-assistant]
center-window=['<Super>c']
enable-advanced-experimental-features=true
show-layout-panel-indicator=true
window-gap=4

[org/gnome/shell/extensions/window-list]
grouping-mode='always'
show-on-all-monitors=true
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-software
[org/gnome/software]
first-run=false
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-system
[org/gnome/system/location]
enabled=true
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gnome-tweaks
[org/gnome/tweaks]
show-extensions-notice=false
EOF

cat << 'EOF' > /etc/dconf/db/local.d/org-gtk-settings
[org/gtk/settings/file-chooser]
sort-directories-first=true
EOF

cat << 'EOF' > /etc/dconf/db/local.d/locks/org-gnome-settings-daemon-plugins-power
/org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout
/org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type
/org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout
/org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type
EOF

cat << 'EOF' > /etc/dconf/profile/user
user-db:user
system-db:local
EOF

cat << 'EOF' > /etc/gtk-4.0/settings.ini
[Settings]
gtk-application-prefer-dark-theme=true
EOF

if [[ -z ${XDG_SESSION_DESKTOP+x} ]]
then
    dconf update
fi

rm --force --recursive /etc/gtk-3.0
