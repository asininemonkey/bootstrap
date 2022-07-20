#!/usr/bin/env bash

#
# Console Colours
#

export OUTPUT_COLOUR_CLEAR=$(echo -en '\e[m')

export OUTPUT_COLOUR_BOLD_BLACK=$(echo -en '\e[1;30m')
export OUTPUT_COLOUR_BOLD_RED=$(echo -en '\e[1;31m')
export OUTPUT_COLOUR_BOLD_GREEN=$(echo -en '\e[1;32m')
export OUTPUT_COLOUR_BOLD_YELLOW=$(echo -en '\e[1;33m')
export OUTPUT_COLOUR_BOLD_BLUE=$(echo -en '\e[1;34m')
export OUTPUT_COLOUR_BOLD_MAGENTA=$(echo -en '\e[1;35m')
export OUTPUT_COLOUR_BOLD_CYAN=$(echo -en '\e[1;36m')
export OUTPUT_COLOUR_BOLD_WHITE=$(echo -en '\e[1;37m')

#
# Change macOS Screenshot Settings
#

if [ ! -d "${HOME}/Pictures/Screenshots" ]
then
    mkdir -p "${HOME}/Pictures/Screenshots"

    defaults write com.apple.screencapture disable-shadow -bool true
    defaults write com.apple.screencapture location "${HOME}/Pictures/Screenshots"
fi

#
# Install Xcode Command Line Tools
#

if [ ! -f "/Library/Developer/CommandLineTools/usr/bin/swift-frontend" ]
then
    xcode-select --install
fi

#
# Install Homebrew
#

if [ ! -f "/usr/local/Homebrew/bin/brew" ]
then
    /bin/bash -c "$(curl --fail --location --show-error --silent 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh')"
fi

#
# Install Homebrew Packages
#

brew tap homebrew/cask-fonts

brew install --cask \
    font-fira-code-nerd-font

brew install \
    aws-iam-authenticator \
    awscli \
    bash \
    btop \
    cosign \
    diff-so-fancy \
    envchain \
    fzf \
    git \
    gnu-sed \
    googler \
    helm \
    hey \
    internetarchive \
    jq \
    k9s \
    kubernetes-cli \
    macchina \
    mas \
    ngrok \
    nmap \
    p7zip \
    prettyping \
    speedtest-cli \
    starship \
    stern \
    terraform \
    tmux \
    tree \
    watch \
    wget \
    youtube-dl

brew upgrade

brew cleanup

#
# Install macOS App Store Applications
#

echo

# Apple Applications
mas install 0409183694 # Keynote
mas install 0409201541 # Pages
mas install 0409203825 # Numbers
mas install 0497799835 # Xcode
mas install 0899247664 # TestFlight

# General Applications
mas install 0403504866 # PCalc *
mas install 0406825478 # Telephone *
mas install 0411643860 # DaisyDisk *
mas install 0417375580 # BetterSnapTool
mas install 0419330170 # Moom
mas install 0425264550 # Blackmagic Disk Speed Test
mas install 0425424353 # The Unarchiver
mas install 0430798174 # HazeOver
mas install 0457622435 # Yoink
mas install 0488764545 # The Clock
mas install 0803453959 # Slack
mas install 0824171161 # Affinity Designer
mas install 0824183456 # Affinity Photo
mas install 1153157709 # Speedtest
mas install 1176895641 # Spark
mas install 1191449274 # ToothFairy
mas install 1289583905 # Pixelmator Pro
mas install 1333542190 # 1Password 7
mas install 1350044974 # PingDoctor
mas install 1466185689 # Blackmagic RAW Speed Test
mas install 1529448980 # Reeder 5
mas install 1544577573 # Pluto

# Microsoft Applications
# mas install 0462054704 # Microsoft Word
# mas install 0462058435 # Microsoft Excel
# mas install 0462062816 # Microsoft PowerPoint
# mas install 0784801555 # Microsoft OneNote
# mas install 0985367838 # Microsoft Outlook

#
# Check For Manually Installed Applications
#

echo

function checkApplications () {
    for APPLICATION in "${!APPLICATION_MAP[@]}";
    do
        if [ ! -d "/Applications/${APPLICATION_MAP[${APPLICATION}]}.app" ]
        then
            echo "${OUTPUT_COLOUR_BOLD_YELLOW}${APPLICATION}${OUTPUT_COLOUR_CLEAR} has ${OUTPUT_COLOUR_BOLD_RED}not${OUTPUT_COLOUR_CLEAR} been installed!"
        fi
    done
}

declare -A APPLICATION_MAP

# Personal Applications
APPLICATION_MAP['Audio Hijack']="Audio Hijack"
APPLICATION_MAP['Bartender']="Bartender 4"
APPLICATION_MAP['Docker']="Docker"
APPLICATION_MAP['Firefox']="Firefox"
APPLICATION_MAP['Fission']="Fission"
APPLICATION_MAP['GeForceNOW']="GeForceNOW"
APPLICATION_MAP['Kaleidoscope']="Kaleidoscope"
APPLICATION_MAP['Lens']="Lens"
APPLICATION_MAP['Loopback']="Loopback"
APPLICATION_MAP['Mozilla VPN']="Mozilla VPN"
APPLICATION_MAP['Obsidian']="Obsidian"
APPLICATION_MAP['OpenEmu']="OpenEmu"
APPLICATION_MAP['RemotePlay']="RemotePlay"
APPLICATION_MAP['Ring']="Ring"
APPLICATION_MAP['Signal']="Signal"
APPLICATION_MAP['SoundSource']="SoundSource"
APPLICATION_MAP['Steam']="Steam"
APPLICATION_MAP['Swish']="Swish"
APPLICATION_MAP['Visual Studio Code']="Visual Studio Code"
APPLICATION_MAP['VLC']="VLC"
APPLICATION_MAP['VMware Fusion']="VMware Fusion"

# Work Applications
APPLICATION_MAP['krisp']="krisp"
APPLICATION_MAP['Zoom']="zoom.us"

checkApplications

unset APPLICATION_MAP

#
# Install Oh My Zsh
#

if [ ! -f "${HOME}/.oh-my-zsh/oh-my-zsh.sh" ]
then
    /bin/bash -c "$(curl --fail --location --show-error --silent 'https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh')"
fi

#
# Configure Z Shell
#

chmod 0755 "/usr/local/share/zsh"
chmod 0755 "/usr/local/share/zsh/site-functions"
