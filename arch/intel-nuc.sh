#!/usr/bin/env zsh

nvme format --ses 1 /dev/nvme0n1

archinstall \
  --config 'https://raw.githubusercontent.com/asininemonkey/bootstrap/main/arch/user-configuration-intel-nuc.json' \
  --creds 'https://raw.githubusercontent.com/asininemonkey/bootstrap/main/arch/user-credentials.json' \
  --disk-layout 'https://raw.githubusercontent.com/asininemonkey/bootstrap/main/arch/user-disk-layout-nvme.json'
