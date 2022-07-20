#!/usr/bin/env bash

git clone \
    --branch 'macos' \
    --config 'status.showUntrackedFiles=no' \
    --separate-git-dir "${HOME}/.git" \
    'https://github.com/asininemonkey/dotfiles.git' \
    /tmp/dotfiles

cat << 'EOF' >> "${HOME}/.git/config"
[user]
	email = 65740649+asininemonkey@users.noreply.github.com
	name = Jose Cardoso
EOF

cd "${HOME}"

chown -R "${USER}:staff" "${HOME}"

git checkout --force
git remote set-url origin git@github.com:asininemonkey/dotfiles.git

rm -fR /tmp/dotfiles
