echo debian customize

echo Press enter to continue; read dummy;

echo '******************************'
echo remove apps
echo '******************************'

sudo apt autoremove aisleriot --purge -y
sudo apt autoremove gnome-mines --purge -y
sudo apt autoremove gnome-mahjongg --purge -y
sudo apt autoremove rhythmbox --purge -y
sudo apt autoremove gnome-sudoku --purge -y
sudo apt autoremove shotwell --purge -y
sudo apt autoremove gnome-todo --purge -y
sudo apt autoremove totem --purge -y
sudo apt autoremove gnome-calendar --purge -y
# sudo apt autoremove libreoffice* --purge -y

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

echo '******************************'
echo shared
echo '******************************'
sudo apt update -y
sudo apt install -y libasound2 wget gnupg lsb-release apt-transport-https ca-certificates
sudo apt install gjs libgjs0g python3-update-manager update-manager update-manager-core --reinstall

echo '******************************'
echo misc
echo '******************************'

sudo apt update -y

sudo apt install remmina -y
sudo apt install evolution evolution-ews -y
sudo apt install workrave -y
sudo apt install gnome-tweaks -y
sudo apt install keepassxc -y
sudo apt install stacer -y
echo 'install the following apps manually'
echo ' * balenaEtcher'
echo ' * nextcloud-desktop'

echo '******************************'
echo flatpak
echo '******************************'

sudo apt update -y
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo apt update -y

echo '******************************'
echo flatpak apps
echo '******************************'

# sudo flatpak install flathub org.libreoffice.LibreOffice -y
sudo flatpak install flathub mattermost -y
sudo flatpak install flathub rocketchat -y
sudo flatpak install flathub org.signal.Signal -y
sudo flatpak install flathub slack -y
sudo flatpak install flathub ch.threema.threema-web-desktop -y
sudo flatpak install flathub whatsie -y
sudo flatpak install flathub com.jetpackduba.Gitnuro -y
sudo flatpak install flathub metadatacleaner -y
sudo flatpak install flathub org.gimp.GIMP -y
sudo flatpak install flathub inkscape -y
sudo flatpak install flathub org.videolan.VLC -y
sudo flatpak install flathub joplin -y
sudo flatpak install flathub freefilesync -y
sudo flatpak install flathub com.protonvpn.www -y
sudo flatpak install flathub flatsweep -y
sudo flatpak install flathub flatseal -y
sudo flatpak install flathub com.usebruno.Bruno -y
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y
sudo flatpak install flathub org.filezillaproject.Filezilla -y

echo '******************************'
echo extension manager
echo '******************************'

sudo apt install gnome-shell-extension-manager -y
echo 'install the following extensions'
echo ' * Alphabetical App Grid'
echo ' * AppIndicator and KStatusNotifierItem Support'
echo ' * Dash to Panel'
echo ' * Desktop icons NG (DING)'
echo ' * Tiling Assistant'

echo '******************************'
echo firefox
echo '******************************'

sudo apt autoremove firefox-esr -y
sudo add-apt-repository ppa:mozillateam/ppa -y
echo 'Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt update -y
sudo apt install firefox -y

echo '******************************'
echo librewolf
echo '******************************'

distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/librewolf.gpg
echo 'Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg' | sudo tee /etc/apt/sources.list.d/librewolf.sources
sudo apt update -y
sudo apt install librewolf -y

echo '******************************'
echo virtual box
echo '******************************'

wget -O /tmp/virtualbox.deb https://download.virtualbox.org/virtualbox/7.1.0/virtualbox-7.1_7.1.0-164728~Debian~bookworm_amd64.deb
sudo apt install /tmp/virtualbox.deb -y
sudo usermod -aG vboxusers $USER
newgrp vboxusers
wget -O /tmp/virtualbox_extension_pack.vbox-extpack https://download.virtualbox.org/virtualbox/7.1.0/Oracle_VirtualBox_Extension_Pack-7.1.0.vbox-extpack
echo 'install extension pack'

echo '******************************'
echo phpstorm
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-phpstorm
mkdir jetbrains-phpstorm
wget -c https://download.jetbrains.com/webide/PhpStorm-2024.2.1.tar.gz -O - | tar -xz -C jetbrains-phpstorm --strip-components=1
mv jetbrains-phpstorm $HOME/apps
echo "[Desktop Entry]
Name=PhpStorm
Exec=$HOME/apps/jetbrains-phpstorm/bin/phpstorm %u
Icon=$HOME/apps/jetbrains-phpstorm/bin/phpstorm.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-phpstorm
" | tee $HOME/.local/share/applications/jetbrains-phpstorm.desktop

echo '******************************'
echo pycharm CE
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-pycharm-ce
mkdir jetbrains-pycharm-ce
wget -c https://download.jetbrains.com/python/pycharm-community-2024.2.1.tar.gz -O - | tar -xz -C jetbrains-pycharm-ce --strip-components=1
mv jetbrains-pycharm-ce $HOME/apps
echo "[Desktop Entry]
Name=PyCharm Community
Exec=$HOME/apps/jetbrains-pycharm-ce/bin/pycharm %u
Icon=$HOME/apps/jetbrains-pycharm-ce/bin/pycharm.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-pycharm-ce
" | tee $HOME/.local/share/applications/jetbrains-pycharm-ce.desktop

echo '******************************'
echo intellij idea CE
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-idea-ce
mkdir jetbrains-idea-ce
wget -c https://download.jetbrains.com/idea/ideaIC-2024.2.1.tar.gz -O - | tar -xz -C jetbrains-idea-ce --strip-components=1
mv jetbrains-idea-ce $HOME/apps
echo "[Desktop Entry]
Name=IntelliJ IDEA Community
Exec=$HOME/apps/jetbrains-idea-ce/bin/idea %u
Icon=$HOME/apps/jetbrains-idea-ce/bin/idea.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-idea-ce
" | tee $HOME/.local/share/applications/jetbrains-idea-ce.desktop


echo '******************************'
echo RustRover CE
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-rustrover-ce
mkdir jetbrains-rustrover-ce
wget -c https://download.jetbrains.com/rustrover/RustRover-2024.2.1.tar.gz -O - | tar -xz -C jetbrains-rustrover-ce --strip-components=1
mv jetbrains-rustrover-ce $HOME/apps
echo "[Desktop Entry]
Name=IntelliJ IDEA Community
Exec=$HOME/apps/jetbrains-rustrover-ce/bin/idea %u
Icon=$HOME/apps/jetbrains-rustrover-ce/bin/idea.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-rustrover-ce
" | tee $HOME/.local/share/applications/jetbrains-rustrover-ce.desktop

echo '******************************'
echo vscodium
echo '******************************'

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update -y
sudo apt install codium -y

echo '******************************'
echo cleanup / update / upgrade
echo '******************************'

sudo flatpak update

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean
sudo apt update -y
sudo apt upgrade -y

echo '******************************'
echo end of script
echo '******************************'

echo Press enter to exit; read dummy;
