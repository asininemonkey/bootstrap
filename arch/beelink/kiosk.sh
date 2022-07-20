#!/usr/bin/env bash

cat << 'EOF' > "/etc/pam.d/retro"
auth required pam_unix.so nullok
account required pam_unix.so
session required pam_systemd.so
session required pam_unix.so
EOF

cat << 'EOF' > "/etc/systemd/system/cage.service"
[Install]
Alias=display-manager.service
WantedBy=graphical.target

[Service]
ExecStart=/usr/bin/cage /usr/bin/emulationstation
PAMName=retro
Restart=always
StandardInput=tty-fail
TTYPath=/dev/tty1
TTYReset=yes
TTYVHangup=yes
TTYVTDisallocate=yes
Type=simple
User=retro
UtmpIdentifier=tty1
UtmpMode=user

[Unit]
After=dbus.socket
After=getty.target
After=network-online.target
After=remote-fs.target
After=systemd-logind.service
After=systemd-user-sessions.service
Before=graphical.target
ConditionPathExists=/dev/tty0
Conflicts=getty@tty1.service
Description=Cage Wayland Compositor
Wants=dbus.socket
Wants=systemd-logind.service
EOF

systemctl enable cage.service

systemctl set-default graphical.target
