#!/usr/bin/env bash

HOME_PATH="/home/retro"
MOUNT_HOST="172.16.30.229"

cat << EOF > "/etc/systemd/system/home-retro-es.automount"
[Automount]
Where=${HOME_PATH}/es

[Install]
WantedBy=remote-fs.target

[Unit]
After=remote-fs-pre.target
Description=CIFS Automount (es)
Requires=remote-fs-pre.target
EOF

cat << EOF > "/etc/systemd/system/home-retro-es.mount"
[Install]
WantedBy=multi-user.target

[Mount]
DirectoryMode=0700
Options=credentials=/root/credentials-cifs,dir_mode=0700,file_mode=0600,gid=1000,iocharset=utf8,rw,uid=1000,vers=3
Type=cifs
What=//${MOUNT_HOST}/es
Where=${HOME_PATH}/es

[Unit]
After=network-online.target
After=remote-fs.target
Description=CIFS Mount (es)
EOF

cat << EOF > "/etc/systemd/system/home-retro-roms.automount"
[Automount]
Where=${HOME_PATH}/roms

[Install]
WantedBy=remote-fs.target

[Unit]
After=remote-fs-pre.target
Description=CIFS Automount (roms)
Requires=remote-fs-pre.target
EOF

cat << EOF > "/etc/systemd/system/home-retro-roms.mount"
[Install]
WantedBy=multi-user.target

[Mount]
DirectoryMode=0700
Options=credentials=/root/credentials-cifs,dir_mode=0700,file_mode=0600,gid=1000,iocharset=utf8,ro,uid=1000,vers=3
Type=cifs
What=//${MOUNT_HOST}/roms-curated
Where=${HOME_PATH}/roms

[Unit]
After=network-online.target
After=remote-fs.target
Description=CIFS Mount (roms)
EOF

cat << EOF > "/etc/systemd/system/home-retro-saves.automount"
[Automount]
Where=${HOME_PATH}/saves

[Install]
WantedBy=remote-fs.target

[Unit]
After=remote-fs-pre.target
Description=CIFS Automount (saves)
Requires=remote-fs-pre.target
EOF

cat << EOF > "/etc/systemd/system/home-retro-saves.mount"
[Install]
WantedBy=multi-user.target

[Mount]
DirectoryMode=0700
Options=credentials=/root/credentials-cifs,dir_mode=0700,file_mode=0600,gid=1000,iocharset=utf8,rw,uid=1000,vers=3
Type=cifs
What=//${MOUNT_HOST}/retro-saves
Where=${HOME_PATH}/saves

[Unit]
After=network-online.target
After=remote-fs.target
Description=CIFS Mount (roms)
EOF

cat << EOF > "/etc/systemd/system/home-retro-states.automount"
[Automount]
Where=${HOME_PATH}/states

[Install]
WantedBy=remote-fs.target

[Unit]
After=remote-fs-pre.target
Description=CIFS Automount (states)
Requires=remote-fs-pre.target
EOF

cat << EOF > "/etc/systemd/system/home-retro-states.mount"
[Install]
WantedBy=multi-user.target

[Mount]
DirectoryMode=0700
Options=credentials=/root/credentials-cifs,dir_mode=0700,file_mode=0600,gid=1000,iocharset=utf8,rw,uid=1000,vers=3
Type=cifs
What=//${MOUNT_HOST}/retro-states
Where=${HOME_PATH}/states

[Unit]
After=network-online.target
After=remote-fs.target
Description=CIFS Mount (roms)
EOF

cat << EOF > "/etc/systemd/system/home-retro-system.automount"
[Automount]
Where=${HOME_PATH}/system

[Install]
WantedBy=remote-fs.target

[Unit]
After=remote-fs-pre.target
Description=CIFS Automount (system)
Requires=remote-fs-pre.target
EOF

cat << EOF > "/etc/systemd/system/home-retro-system.mount"
[Install]
WantedBy=multi-user.target

[Mount]
DirectoryMode=0700
Options=credentials=/root/credentials-cifs,dir_mode=0700,file_mode=0600,gid=1000,iocharset=utf8,ro,uid=1000,vers=3
Type=cifs
What=//${MOUNT_HOST}/retro-system
Where=${HOME_PATH}/system

[Unit]
After=network-online.target
After=remote-fs.target
Description=CIFS Mount (roms)
EOF

cat << 'EOF' > "/root/credentials-cifs"
password=kuWdxYy3uk2qxpXQ4MoVAcM4
username=retro
EOF

systemctl enable home-retro-es.automount
systemctl enable home-retro-roms.automount
systemctl enable home-retro-saves.automount
systemctl enable home-retro-states.automount
systemctl enable home-retro-system.automount
