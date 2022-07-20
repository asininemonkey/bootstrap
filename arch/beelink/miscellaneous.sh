#!/usr/bin/env bash

HOME_PATH="/home/retro"

mkdir --parents \
    "${HOME_PATH}/.local/state/wireplumber" \
    "${HOME_PATH}/.ssh"

cat << 'EOF' > "/etc/ssh/sshd_config"
AllowUsers retro
Ciphers aes256-gcm@openssh.com,aes256-ctr
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
KexAlgorithms curve25519-sha256@libssh.org,curve25519-sha256
LoginGraceTime 15
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-512
MaxAuthTries 3
PasswordAuthentication no
PermitRootLogin no
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-nodes"
[default-nodes]
default.configured.audio.sink=alsa_output.pci-0000_00_1f.3.hdmi-stereo-extra2
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/default-routes"
[default-routes]
alsa_card.pci-0000_00_1f.3:output:hdmi-output-2:channelMap=FL;FR;
alsa_card.pci-0000_00_1f.3:output:hdmi-output-2:channelVolumes=1.0;1.0;
alsa_card.pci-0000_00_1f.3:output:hdmi-output-2:iec958Codecs=
alsa_card.pci-0000_00_1f.3:output:hdmi-output-2:latencyOffsetNsec=0
alsa_card.pci-0000_00_1f.3:profile:off=hdmi-output-2;
alsa_card.pci-0000_00_1f.3:profile:output:hdmi-stereo-extra2=hdmi-output-2;
EOF

cat << 'EOF' > "${HOME_PATH}/.local/state/wireplumber/restore-stream"
[restore-stream]
Audio/Sink:node.name:auto_null:channelMap=FL;FR;
Audio/Sink:node.name:auto_null:channelVolumes=1.0;1.0;
Audio/Sink:node.name:auto_null:mute=false
Audio/Sink:node.name:auto_null:volume=1.0
EOF

cat << 'EOF' > "${HOME_PATH}/.ssh/authorized_keys"
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYDHpVs4nKaLG+tnLUGH+4Ivnq9ELPW0S3W/uJhxNd/
EOF

chmod 0400 "${HOME_PATH}/.ssh/authorized_keys" "/root/credentials-cifs"
chmod 0500 "${HOME_PATH}/.ssh"

chown --recursive retro:retro "${HOME_PATH}"

systemctl mask hibernate.target
systemctl mask hybrid-sleep.target
systemctl mask sleep.target
systemctl mask suspend.target

usermod --comment 'Retro' retro
