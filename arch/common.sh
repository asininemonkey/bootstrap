#!/usr/bin/env bash

HOME_PATH="/home/jcardoso"

mkdir --parents \
    "${HOME_PATH}/.local/share/backgrounds"

cat << 'EOF' > /etc/environment
MOZ_DBUS_REMOTE=1
MOZ_DISABLE_RDD_SANDBOX=1
MOZ_ENABLE_WAYLAND=1
EOF

cat << 'EOF' > /etc/fail2ban/jail.d/default.local
[DEFAULT]
bantime = 28d
findtime = 7d
maxretry = 3
EOF

cat << 'EOF' > /etc/fail2ban/jail.d/sshd.local
[sshd]
enabled = true
ignoreip = 100.64.0.0/10 127.0.0.1/8 192.168.1.0/24
mode = aggressive
EOF

cat << 'EOF' > /etc/NetworkManager/conf.d/mdns.conf
[connection]
connection.mdns=2
EOF

cat << 'EOF' > /etc/polkit-1/rules.d/cupspkhelper.rules
polkit.addRule(function(action, subject) {
    if (/^org\.opensuse\.cupspkhelper\.mechanism\./.test(action.id) &&
        subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
});
EOF

cat << 'EOF' > /etc/ssh/sshd_config
AllowUsers jcardoso
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

cat << 'EOF' > /etc/systemd/resolved.conf
[Resolve]
FallbackDNS=1.1.1.1 1.0.0.1
EOF

cat << 'EOF' > /etc/systemd/timesyncd.conf
[Time]
NTP=uk.pool.ntp.org
EOF

cat << 'EOF' > /usr/lib/firefox/defaults/pref/autoconfig.js
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF

cat << 'EOF' > /usr/lib/firefox/firefox.cfg
//
lockPref("autoadmin.global_config_url", "https://raw.githubusercontent.com/asininemonkey/bootstrap/main/firefox.js");
lockPref("autoadmin.offline_failover", true);
lockPref("autoadmin.offline_failover_to_cached", true);
lockPref("autoadmin.refresh_interval", 10);

lockPref("distribution.archlinux.bookmarksProcessed", true);

lockPref("media.ffmpeg.vaapi.enabled", true);
lockPref("media.navigator.mediadatadecoder_vpx_enabled", true);
EOF

curl \
    --location \
    --output '/etc/arch-ascii' \
    --silent \
    'https://raw.githubusercontent.com/macchina-cli/macchina/main/contrib/ascii/archlinux.ascii'

curl \
    --location \
    --output "${HOME_PATH}/.local/share/backgrounds/Forest.jpeg" \
    --silent \
    'https://r4.wallpaperflare.com/wallpaper/410/867/750/vector-forest-sunset-forest-sunset-forest-wallpaper-b3abc35d0d699b056fa6b247589b18a8.jpg'

# ln --force --symbolic /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

sed --in-place '/^auth.*include.*system-login$/i auth      sufficient  pam_fprintd.so' /etc/pam.d/system-local-login
sed --in-place 's/include   /include     /' /etc/pam.d/system-local-login

usermod --comment 'Jose Cardoso' --password "$(echo password | openssl passwd -6 -stdin)" --shell '/usr/bin/zsh' jcardoso
