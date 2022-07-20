#!/usr/bin/env bash

HOME_PATH=/home/jcardoso

mkdir --parents \
    "${HOME_PATH}/Pictures/Screenshots"

git clone \
    --branch 'arch' \
    --config 'status.showUntrackedFiles=no' \
    --separate-git-dir "${HOME_PATH}/.git" \
    'https://github.com/asininemonkey/dotfiles.git' \
    /tmp/dotfiles

cat << 'EOF' >> "${HOME_PATH}/.git/config"
[user]
	email = 65740649+asininemonkey@users.noreply.github.com
	name = Jose Cardoso
EOF

cd "${HOME_PATH}"

chown --recursive jcardoso:jcardoso "${HOME_PATH}"

sudo --user jcardoso git checkout --force
sudo --user jcardoso git remote set-url origin git@github.com:asininemonkey/dotfiles.git

sudo --user jcardoso sh -c "$(curl --fail --location --show-error --silent 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh')" '' --keep-zshrc --unattended

rm --force --recursive /tmp/dotfiles
