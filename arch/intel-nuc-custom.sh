#!/usr/bin/env bash

HOME_PATH="/home/jcardoso"

mkdir --mode 0755 /data

mkdir --parents \
     "${HOME_PATH}/.config" \
     "${HOME_PATH}/.local/state/wireplumber" \
     "/var/lib/gdm/.config"

cat << 'EOF' > "${HOME_PATH}/.config/monitors.xml"
<monitors version="2">
  <configuration>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-2</connector>
          <vendor>DEL</vendor>
          <product>Dell AW3423DW</product>
          <serial>#GjMYMxgwABcQ</serial>
        </monitorspec>
        <mode>
          <width>3440</width>
          <height>1440</height>
          <rate>119.99089050292969</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
</monitors>
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-nodes"
[default-nodes]
default.configured.audio.sink=alsa_output.usb-SteelSeries_Arctis_7P_-00.iec958-stereo
default.configured.audio.source=alsa_input.usb-SteelSeries_Arctis_7P_-00.mono-fallback
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-profile"
[default-profile]
alsa_card.usb-SteelSeries_Arctis_7P_-00=output:iec958-stereo+input:mono-fallback
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-routes"
[default-routes]
alsa_card.usb-SteelSeries_Arctis_7P_-00:input:analog-input-mic:channelMap=MONO;
alsa_card.usb-SteelSeries_Arctis_7P_-00:input:analog-input-mic:channelVolumes=1.0;
alsa_card.usb-SteelSeries_Arctis_7P_-00:input:analog-input-mic:latencyOffsetNsec=0
alsa_card.usb-SteelSeries_Arctis_7P_-00:output:iec958-stereo-output:channelMap=FL;FR;
alsa_card.usb-SteelSeries_Arctis_7P_-00:output:iec958-stereo-output:channelVolumes=1.0;1.0;
alsa_card.usb-SteelSeries_Arctis_7P_-00:output:iec958-stereo-output:iec958Codecs=
alsa_card.usb-SteelSeries_Arctis_7P_-00:output:iec958-stereo-output:latencyOffsetNsec=0
alsa_card.usb-SteelSeries_Arctis_7P_-00:profile:output:iec958-stereo+input:mono-fallback=iec958-stereo-output;analog-input-mic;
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/restore-stream"
[restore-stream]
Audio/Sink:node.name:auto_null:channelMap=FL;FR;
Audio/Sink:node.name:auto_null:channelVolumes=1.0;1.0;
Audio/Sink:node.name:auto_null:mute=false
Audio/Sink:node.name:auto_null:volume=1.0
Output/Audio:media.role:Notification:channelMap=FL;FR;
Output/Audio:media.role:Notification:channelVolumes=1.0;1.0;
Output/Audio:media.role:Notification:mute=false
Output/Audio:media.role:Notification:volume=1.0
EOF

cat << 'EOF' > /etc/samba/smb.conf
[global]
create mask = 0644
directory mask = 0755
fruit:metadata = stream
guest account = nobody
map to guest = bad user
protocol = smb3
security = user
vfs objects = fruit streams_xattr

[roms]
guest ok = yes
path = /data/roms
read only = yes

[temporary]
guest ok = yes
path = /data/temporary
read only = no
EOF

cat << 'EOF' > /etc/systemd/system/docker-compose-media.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/bin/docker-compose --file /data/docker/media/docker-compose.yml up
ExecStartPre=/usr/bin/docker-compose --file /data/docker/media/docker-compose.yml pull
ExecStop=/usr/bin/docker-compose --file /data/docker/media/docker-compose.yml down
Group=docker
Restart=always
User=root

[Unit]
After=docker.service network-online.target
Description=docker-compose-media
Requires=docker.service network-online.target
EOF

cat << 'EOF' > /etc/systemd/system/docker-compose-miscellaneous.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/bin/docker-compose --file /data/docker/miscellaneous/docker-compose.yml up
ExecStartPre=/usr/bin/docker-compose --file /data/docker/miscellaneous/docker-compose.yml pull
ExecStop=/usr/bin/docker-compose --file /data/docker/miscellaneous/docker-compose.yml down
Group=docker
Restart=always
User=root

[Unit]
After=docker.service
Description=docker-compose-miscellaneous
Requires=docker.service
EOF

cp "${HOME_PATH}/.config/monitors.xml" "/var/lib/gdm/.config/monitors.xml"

chown --recursive gdm:gdm "/var/lib/gdm"
chown --recursive jcardoso:jcardoso "${HOME_PATH}"

echo "UUID=$(blkid --match-tag UUID --output value /dev/sda1) /data ext4 rw,relatime 0 1" >> /etc/fstab

systemctl enable docker-compose-media
systemctl enable docker-compose-miscellaneous

systemctl mask hibernate.target
systemctl mask hybrid-sleep.target
systemctl mask sleep.target
systemctl mask suspend.target

usermod --append --groups docker jcardoso
