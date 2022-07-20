#!/usr/bin/env zsh

hdparm --user-master u --security-set-pass password /dev/sda
hdparm --user-master u --security-erase password /dev/sda

archinstall \
  --config 'https://raw.githubusercontent.com/asininemonkey/bootstrap/main/arch/beelink/user-configuration.json' \
  --creds 'https://raw.githubusercontent.com/asininemonkey/bootstrap/main/arch/beelink/user-credentials.json' \
  --disk-layout 'https://raw.githubusercontent.com/asininemonkey/bootstrap/main/arch/user-disk-layout-sata.json'
