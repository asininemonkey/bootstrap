#!/usr/bin/env bash

git clone https://github.com/paroj/xpad.git /usr/src/xpad-0.4
dkms install -k $(ls /usr/lib/modules) -m xpad -v 0.4
