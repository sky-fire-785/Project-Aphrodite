#!/bin/bash

#sets varables
RED='\033[38;2;255;0;0m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m'

chsh -s /bin/bash

#removes kitty configs
rm -rf ~/.config/kitty

#removes fastfetch config
rm -rf ~/.config/fastfetch

#more logic needed here to make so if there was preexisting config files it will build from those instead of just deleting them. this is a work in progress and will be added in the future.
#removes zsh
rm -rf ~/.oh-my-zsh
rm -rf ~/.zshrc ~/.p10k.zsh ~/.zcompdump*

#removes rofi config
rm -rf ~/.config/rofi
rm -rf ~/.local/share/applications/rofi-drun.desktop

#removes pacman config
sudo mv /etc/.old_pacman.conf /etc/pacman.conf || echo "${RED}there is no old pacman file to build from${NC}"

#removes ly
sudo rm -rf /etc/ly
sudo systemctl disable ly@tty2.service
sudo systemctl enable sddm.service 

#removes KDE theme
rm -rf ~/.local/share/icons/Project-Aphrodite-Icons
rm -rf ~/.local/share/plasma/look-and-feel/Project-Aphrodite
rm -rf ~/.icons/Project-Aphrodite-Cursor
rm -rf ~/.local/share/aurorae/themes/fluency
rm -rf ~/.config/project-aphrodite-REF

#resets the KDE shortcuts to defalts
rm -f ~/.config/kglobalshortcutsrc

#updates the system and removes the packages
yay -Rs ly fastfetch kitty rofi zsh visual-studio-code-bin --noconfirm
sudo pacman -Syu --noconfirm