#!/bin/bash

#sets some varables
RED='\033[38;2;255;0;0m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m'

echo "installing..."

#install all needed things
echo "Updating system & installing essential tools..."
if ! sudo pacman -Syu --needed git kitty zsh fastfetch wget fuse ly extra/ttf-noto-nerd base-devel vivaldi zig curl rofi rofi-calc --noconfirm ;then
    echo "${RED}WARNING: Failed to update. Exiting...${NC}"
    exit 1
fi
rm -rf ~/yay && git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si --noconfirm && cd ~ || echo -e "${RED}WARNING: yay Install Failed${NC}"
yay -Sy visual-studio-code-bin rofi-file-browser-extended-patched --noconfirm || echo -e "${RED}WARNING: Install Failed${NC}"

#install zsh & pk10 with some plugins
sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || echo -e "${RED}WARNING: ZSH Install Failed${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || echo -e "${RED}WARNING: ZSH Plugin Install Failed${NC}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || echo -e "${RED}WARNING: ZSH Plugin Install Failed${NC}"
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k || echo -e "${RED}WARNING: P10K Install Failed${NC}"

#builds env
mkdir -p ~/.local/bin
curl -#L -o ~/.local/bin/env "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/zsh%20config/env" || echo -e "${RED}WARNING: ENV Install Failed${NC}"

#makes config file for zsh and pk10
rm -rf ~/.zshrc
curl -#L -o ~/.zshrc "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/zsh%20config/.zshrc" || echo -e "${RED}WARNING: ZSH config Install Failed${NC}"
curl -#L -o ~/.p10k.zsh "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/p10k/.p10k.zsh" || echo -e "${RED}WARNING: P10K config Install Failed${NC}"

#kitty config
mkdir -p ~/.config/kitty
curl -#L -o ~/.config/kitty/current-theme.conf "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/kitty/current-theme.conf" || echo -e "${RED}WARNING: Kitty Theme Install Failed${NC}"
curl -#L -o ~/.config/kitty/kitty.conf "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/kitty/kitty.conf" || echo -e "${RED}WARNING: Kitty config Install Failed${NC}"

#makes a fastfetch derectory
mkdir -p ~/.config/fastfetch
curl -#L -o ~/.config/fastfetch/arch.txt "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/FastFetch/arch.txt" || echo -e "${RED}WARNING: FastFetch ASCII-art Install Failed${NC}"
curl -#L -o ~/.config/fastfetch/config.jsonc "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/FastFetch/config.jsonc" || echo -e "${RED}WARNING: FastFetch config Install Failed${NC}"

#configures rofi
mkdir -p ~/.config/rofi
curl -#L -o ~/.config/rofi/config.rasi "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/rofi/config.rasi" || echo -e "${RED}WARNING: RoFi config Install Failed${NC}"

#configures shortcuts
#makes the applcation
mkdir -p ~/.local/share/applications
curl -#L -o ~/.local/share/applications/net.local.rofi.desktop "https://raw.githubusercontent.com/sky-fire-785/Project-Aphrodite/refs/heads/Main-PC/rofi/net.local.rofi.desktop" || echo -e "${RED}WARNING: RoFi Shortcut Install Failed${NC}"

kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "org.kde.konsole.desktop" --key "_launch" "none"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "org.kde.krunner.desktop" --key "_launch" "none"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "org.kde.krunner.desktop" --key "RunClipboard" "none"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "kitty.desktop" --key "_launch" "Ctrl+Shift+T"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "net.local.rofi.desktop" --key "_launch" "Meta+Space"$'\t'"Alt+Space"
kwriteconfig6 --file krunnerrc --group "General" --key "ActivateWhenTypingOnDesktop" "false"
qdbus6 org.kde.KWin /KWin reconfigure

#edit the pacman.conf
sudo mv /etc/pacman.conf /etc/.old_pacman.conf
sudo curl -#L -o /etc/pacman.conf "https://raw.githubusercontent.com/sky-fire-785/project-aphrodite/refs/heads/Main-PC/pacman/pacman.conf" || echo -e "${RED}WARNING: Install Failed${NC}"

#makes a new kde theme
echo "Makeing Project-Aphrodite-Theme..."
mkdir -p ~/.config/Project-Aphrodite-REF
mkdir -p ~/.icons
mkdir -p ~/.local/share/plasma/look-and-feel
mkdir -p ~/.local/share/icons
mkdir -p ~/.local/share/aurorae/themes

curl -#L -o ~/.config/Project-Aphrodite-REF/ref0 "https://github.com/sky-fire-785/Project-Aphrodite/raw/c2b99b3346a94b4c56c561154c70484ff23680e8/KDE%20Theme/Project-Aphrodite-Cursor.tar.xz" || echo -e "${RED}WARNING: Install Failed${NC}"
curl -#L -o ~/.config/Project-Aphrodite-REF/ref1 "https://github.com/sky-fire-785/Project-Aphrodite/raw/c2b99b3346a94b4c56c561154c70484ff23680e8/KDE%20Theme/project-Aphrodite.tar.xz" || echo -e "${RED}WARNING: Install Failed${NC}"
curl -#L -o ~/.config/Project-Aphrodite-REF/ref2 "https://github.com/sky-fire-785/Project-Aphrodite/raw/c2b99b3346a94b4c56c561154c70484ff23680e8/KDE%20Theme/fluency.tar.xz" || echo -e "${RED}WARNING: Install Failed${NC}"
curl -#L -o ~/.config/Project-Aphrodite-REF/ref3 "https://github.com/sky-fire-785/Project-Aphrodite/raw/c2b99b3346a94b4c56c561154c70484ff23680e8/KDE%20Theme/Project-Aphrodite-Icons.tar.gz" || echo -e "${RED}WARNING: Install Failed${NC}"

tar -xf ~/.config/Project-Aphrodite-REF/ref0 -C ~/.icons &&  rm -rf ~/.config/Project-Aphrodite-REF/ref0 || echo -e "${RED}WARNING: Extration Failed. ${NC}"
tar -xf ~/.config/Project-Aphrodite-REF/ref1 -C ~/.local/share/plasma/look-and-feel &&  rm -rf ~/.config/Project-Aphrodite-REF/ref1 || echo -e "${RED}WARNING: Extration Failed. ${NC}"
tar -xf ~/.config/Project-Aphrodite-REF/ref2 -C ~/.local/share/aurorae/themes &&  rm -rf ~/.config/Project-Aphrodite-REF/ref2 || echo -e "${RED}WARNING: Extration Failed. ${NC}"
tar -xf ~/.config/Project-Aphrodite-REF/ref3 -C ~/.local/share/icons &&  rm -rf ~/.config/Project-Aphrodite-REF/ref3 || echo -e "${RED}WARNING: Extration Failed. ${NC}"

#sets ly's configs
echo "Seting ly configs..."
sudo sed -i 's/^[# \t]*asterisk.*/asterisk = 0x2022/' /etc/ly/config.ini || echo -e "${RED}WARNING: Failed To Update ly${NC}"
sudo sed -i 's/^[# \t]*numlock.*/numlock = true/' /etc/ly/config.ini || echo -e "${RED}WARNING: Failed To Update ly${NC}"
sudo sed -i 's/^[# \t]*save.*/save = true/' /etc/ly/config.ini || echo -e "${RED}WARNING: Failed To Update ly${NC}"

#sets defalts 
kbuildsycoca6 --noincremental # I dont know if this works but i hink it douse ill hve to check
sudo systemctl disable sddm.service
sudo systemctl enable ly@tty2.service -f
chsh -s /usr/bin/zsh
