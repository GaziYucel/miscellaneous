echo ubuntu customize

echo Press enter to continue; read dummy;

echo '******************************'
echo remove snap
echo '******************************'

sudo snap remove --purge firefox
sudo snap remove --purge gnome-3-38-2004
sudo snap remove --purge gnome-42-2204
sudo snap remove --purge snap-store
sudo snap remove --purge gtk-common-themes
sudo snap remove --purge snapd-desktop-integration
sudo snap remove --purge core20
sudo snap remove --purge core22
sudo snap remove --purge bare
sudo snap remove --purge snapd
sudo apt autoremove snapd --purge -y
echo '# This file forbids snapd from being installed by APT
Package: snapd
Pin: release a=*
Pin-Priority: -10' | sudo tee /etc/apt/preferences.d/nosnap.pref
rm -rf $HOME/snap

echo '******************************'
echo remove apps
echo '******************************'

sudo apt autoremove aisleriot --purge -y
sudo apt autoremove gnome-mines --purge -y
sudo apt autoremove cheese --purge -y
sudo apt autoremove gnome-mahjongg --purge -y
sudo apt autoremove rhythmbox --purge -y
sudo apt autoremove gnome-sudoku --purge -y
sudo apt autoremove shotwell --purge -y
sudo apt autoremove gnome-todo --purge -y
sudo apt autoremove totem --purge -y
sudo apt autoremove thunderbird --purge -y
sudo apt autoremove gnome-calendar --purge -y
sudo apt autoremove libreoffice* --purge -y

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

sudo apt install evolution evolution-ews -y
sudo apt install filezilla -y
sudo apt install kate -y
sudo apt install workrave -y
sudo apt install nextcloud-desktop -y
sudo apt install gnome-tweaks -y
sudo apt install keepassxc -y

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

sudo flatpak install mattermost -y
sudo flatpak install rocketchat -y
sudo flatpak install signal -y
sudo flatpak install slack -y
sudo flatpak install ch.threema.threema-web-desktop -y
sudo flatpak install whatsie -y
sudo flatpak install gittyup -y
sudo flatpak install metadatacleaner -y
sudo flatpak install org.gimp.GIMP -y
sudo flatpak install inkscape -y
sudo flatpak install org.videolan.VLC -y
sudo flatpak install joplin -y
sudo flatpak install freefilesync -y
sudo flatpak install com.protonvpn.www -y

echo '******************************'
echo extension manager
echo '******************************'

sudo apt install gnome-shell-extension-manager -y
echo 'install the following extensions'
echo ' * Alphabetical App Grid'
echo ' * Dash to Panel'
echo ' * Tiling Assistant'
echo ' * Desktop icons NG (DING)'
echo ' * Ubuntu Appindicators'

echo '******************************'
echo firefox
echo '******************************'

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
echo ubuntu cleaner
echo '******************************'

sudo add-apt-repository ppa:gerardpuig/ppa -y
sudo apt update -y
sudo apt install ubuntu-cleaner -y

echo '******************************'
echo libreoffice
echo '******************************'

sudo rm -rf /tmp/libreoffice
mkdir /tmp/libreoffice
wget -c https://ftp.fau.de/tdf/libreoffice/stable/24.2.1/deb/x86_64/LibreOffice_24.2.1_Linux_x86-64_deb.tar.gz -O - | tar -xz -C /tmp/libreoffice --strip-components=1
sudo dpkg -i /tmp/libreoffice/DEBS/*.deb

echo '******************************'
echo bruno
echo '******************************'

sudo mkdir -p /etc/apt/keyrings
sudo mkdir -p /root/.gnupg
sudo find /root/.gnupg -type f -exec chmod 600 {} \;
sudo find /root/.gnupg -type d -exec chmod 700 {} \;
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/bruno.gpg --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266
echo 'deb [signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable' | sudo tee /etc/apt/sources.list.d/bruno.list
sudo apt update -y
sudo apt install bruno

echo '******************************'
echo virtual box
echo '******************************'

wget -O /tmp/virtualbox.deb https://download.virtualbox.org/virtualbox/7.0.14/virtualbox-7.0_7.0.14-161095~Ubuntu~jammy_amd64.deb
sudo apt install /tmp/virtualbox.deb -y
sudo usermod -aG vboxusers $USER
newgrp vboxusers
wget -O /tmp/virtualbox_extension_pack.vbox-extpack https://download.virtualbox.org/virtualbox/7.0.14/Oracle_VM_VirtualBox_Extension_Pack-7.0.14.vbox-extpack
echo 'install extension pack'

echo '******************************'
echo phpstorm
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-phpstorm
mkdir jetbrains-phpstorm
wget -c https://download.jetbrains.com/webide/PhpStorm-2023.3.2.tar.gz -O - | tar -xz -C jetbrains-phpstorm --strip-components=1
mv jetbrains-phpstorm $HOME/apps
echo "[Desktop Entry]
Name=PhpStorm
Exec=$HOME/apps/jetbrains-phpstorm/bin/phpstorm.sh
Icon=$HOME/apps/jetbrains-phpstorm/bin/phpstorm.png
Terminal=false
Type=Application
StartupWMClass=jetbrains-phpstorm
Categories=Qt;Development;
" | tee $HOME/.local/share/applications/jetbrains-phpstorm.desktop

echo '******************************'
echo pycharm CE
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-pycharm-ce
mkdir jetbrains-pycharm-ce
wget -c https://download.jetbrains.com/python/pycharm-community-2023.3.2.tar.gz -O - | tar -xz -C jetbrains-pycharm-ce --strip-components=1
mv jetbrains-pycharm-ce $HOME/apps
echo "[Desktop Entry]
Name=PyCharm Community
Exec=$HOME/apps/jetbrains-pycharm-ce/bin/pycharm.sh
Icon=$HOME/apps/jetbrains-pycharm-ce/bin/pycharm.png
Terminal=false
Type=Application
StartupWMClass=jetbrains-pycharm-ce
Categories=Qt;Development;
" | tee $HOME/.local/share/applications/jetbrains-pycharm-ce.desktop

echo '******************************'
echo intellij idea CE
echo '******************************'

mkdir $HOME/apps
rm -rf $HOME/apps/jetbrains-idea-ce
mkdir jetbrains-idea-ce
wget -c https://download.jetbrains.com/idea/ideaIC-2023.3.2.tar.gz -O - | tar -xz -C jetbrains-idea-ce --strip-components=1
mv jetbrains-idea-ce $HOME/apps
echo "[Desktop Entry]
Name=IntelliJ IDEA Community
Exec=$HOME/apps/jetbrains-idea-ce/bin/idea.sh
Icon=$HOME/apps/jetbrains-idea-ce/bin/idea.png
Terminal=false
Type=Application
StartupWMClass=jetbrains-idea-ce
Categories=Qt;Development;
" | tee $HOME/.local/share/applications/jetbrains-idea-ce.desktop

echo '******************************'
echo bluegriffon
echo '******************************'

wget -O /tmp/bluegriffon.deb http://bluegriffon.org/freshmeat/3.1/bluegriffon-3.1.Ubuntu18.04-x86_64.deb
sudo apt install /tmp/bluegriffon.deb -y

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

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean
sudo apt update -y
sudo apt upgrade -y

echo '******************************'
echo end of script
echo '******************************'

echo Press enter to exit; read dummy;
