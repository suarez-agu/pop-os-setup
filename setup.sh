sudo apt update && sudo apt upgrade -y
sudo apt-get install -y vim tilix code zsh gnome-tweak-tool exa fzf ripgrep jq 

# Set up dotfiles
git clone https://github.com/heuristicAL/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
zsh

# Fix brightness for gmux_backlight
echo "sudo setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0" >> ~/.profile
source ~/.profile

# Set up mac like gestures
sudo apt-get install -y libinput-tools xdotool python3-setuptools
sudo gpasswd -a $(whoami) input

git clone https://github.com/bulletmark/libinput-gestures.git ~/.libinput-gestures
cd ~/.libinput-gestures
sudo make install
sudo ./libinput-gestures-setup install

git clone https://gitlab.com/cunidev/gestures ~/.gestures
cd ~/.gestures
sudo python3 setup.py install

cd
cp gestures.conf ~/.config/libinput-gestures.conf
libinput-gestures-setup start
libinput-gestures-setup autostart

# Terminal config
sudo update-alternatives --set x-terminal-emulator /usr/bin/tilix.wrapper
mkdir -p ~/.config/tilix/schemes
wget -qO ~/.config/tilix/schemes/solarized-darcula.json https://git.io/v7Qa9


cat <<EOT >> ~/.zsh
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi
EOT

# Set git configs
git config --global pull.ff only
