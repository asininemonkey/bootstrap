#!/usr/bin/env bash

HOME_PATH="/home/jcardoso"

MOUNT_HOST="172.16.30.195"
MOUNT_PATH="${HOME_PATH}/Documents/Mounts"

mkdir --parents \
    "${HOME_PATH}/.local/state/wireplumber" \
    "${MOUNT_PATH}/admin" \
    "${MOUNT_PATH}/retro-saves" \
    "${MOUNT_PATH}/retro-states" \
    "${MOUNT_PATH}/retro-system" \
    "${MOUNT_PATH}/roms-curated" \
    "${MOUNT_PATH}/roms-full" \
    "${MOUNT_PATH}/temporary" \
    "/var/lib/bluetooth/14:18:C3:FE:26:E8/cache" \
    "/var/lib/gdm/.config"

cat << 'EOF' > "${HOME_PATH}/.config/monitors.xml"
<monitors version="2">
  <configuration>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <monitor>
        <monitorspec>
          <connector>DP-3</connector>
          <vendor>DEL</vendor>
          <product>DELL U2421E</product>
          <serial>CKN1Y83</serial>
        </monitorspec>
        <mode>
          <width>1920</width>
          <height>1200</height>
          <rate>59.950172424316406</rate>
        </mode>
      </monitor>
    </logicalmonitor>
    <logicalmonitor>
      <x>1920</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-4</connector>
          <vendor>IVM</vendor>
          <product>PL2792QN</product>
          <serial>1179215305130</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>59.950550079345703</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
</monitors>
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-nodes"
[default-nodes]
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-profile"
[default-profile]
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-routes"
[default-routes]
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/restore-stream"
[restore-stream]
EOF

cat << EOF >> /etc/fstab
# CIFS Mounts
//${MOUNT_HOST}/admin        ${MOUNT_PATH}/admin        cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
//${MOUNT_HOST}/retro-saves  ${MOUNT_PATH}/retro-saves  cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
//${MOUNT_HOST}/retro-states ${MOUNT_PATH}/retro-states cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
//${MOUNT_HOST}/retro-system ${MOUNT_PATH}/retro-system cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
//${MOUNT_HOST}/roms-curated ${MOUNT_PATH}/roms-curated cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
//${MOUNT_HOST}/roms-full    ${MOUNT_PATH}/roms-full    cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
//${MOUNT_HOST}/temporary    ${MOUNT_PATH}/temporary    cifs credentials=/root/credentials-cifs,dir_mode=0777,file_mode=0666,iocharset=utf8,nofail,vers=3 0 0
EOF

cat << 'EOF' > /etc/systemd/system/docker-compose-miscellaneous.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/bin/docker-compose --file /etc/systemd/system/docker-compose-miscellaneous.yaml up
ExecStartPre=/usr/bin/docker-compose --file /etc/systemd/system/docker-compose-miscellaneous.yaml pull
ExecStop=/usr/bin/docker-compose --file /etc/systemd/system/docker-compose-miscellaneous.yaml down
Group=docker
Restart=always
User=root

[Unit]
After=docker.service
Description=docker-compose-miscellaneous
Requires=docker.service
EOF

cat << 'EOF' > /etc/systemd/system/docker-compose-miscellaneous.yaml
---
services:
  portainer:
    image: portainer/portainer-ce
    ports:
      - 9000:9000/tcp
    restart: always
    volumes:
      - portainer:/data:rw
      - /var/run/docker.sock:/var/run/docker.sock:ro

version: '3.9'

volumes:
  portainer: null
EOF

cat << 'EOF' > /etc/ufw/ufw.conf
ENABLED=yes
LOGLEVEL=low
EOF

cat << 'EOF' > /root/credentials-cifs
username=admin
password=xxx
EOF

cat << 'EOF' > "/var/lib/bluetooth/14:18:C3:FE:26:E8/settings"
[General]
Discoverable=false
EOF

cp "${HOME_PATH}/.config/monitors.xml" "/var/lib/gdm/.config/monitors.xml"

chmod 0400 /root/credentials-cifs

chown --recursive gdm:gdm "/var/lib/gdm"
chown --recursive jcardoso:jcardoso "${HOME_PATH}"

find /var/lib/bluetooth -type d -print0 | xargs -0 chmod 0700
find /var/lib/bluetooth -type f -print0 | xargs -0 chmod 0600

systemctl enable docker-compose-miscellaneous

systemctl mask hibernate.target
systemctl mask hybrid-sleep.target
systemctl mask sleep.target
systemctl mask suspend.target

usermod --append --groups docker jcardoso
