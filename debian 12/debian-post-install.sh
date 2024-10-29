echo debian customize

echo Press enter to continue; read dummy;

echo '******************************'
echo Configure
echo '******************************'

echo 'add user to sudo'

echo '******************************'
echo Firewall
echo '******************************'

sudo ufw enable -y
sudo ufw allow from 127.0.0.1
sudo ufw reload

echo '******************************'
echo remove snap
echo '******************************'

# sudo snap remove --purge firefox
# sudo snap remove --purge gnome-3-38-2004
# sudo snap remove --purge gnome-42-2204
# sudo snap remove --purge snap-store
# sudo snap remove --purge gtk-common-themes
# sudo snap remove --purge snapd-desktop-integration
# sudo snap remove --purge core20
# sudo snap remove --purge core22
# sudo snap remove --purge bare
# sudo snap remove --purge snapd
# sudo apt autoremove snapd --purge -y
# echo '# This file forbids snapd from being installed by APT
# Package: snapd
# Pin: release a=*
# Pin-Priority: -10' | sudo tee /etc/apt/preferences.d/nosnap.pref
# rm -rf $HOME/snap

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
echo misc
echo '******************************'

sudo apt update -y

sudo apt install gufw -y
sudo apt install remmina -y
sudo apt install evolution evolution-ews -y
# sudo apt install filezilla -y
sudo apt install workrave -y
# sudo apt install nextcloud-desktop -y
sudo apt install gnome-tweaks -y
sudo apt install keepassxc -y
sudo apt install stacer -y
sudo apt install dconf-editor -y
sudo apt install hardinfo -y
sudo apt install chromium -y

echo 'install the following apps manually'
echo ' * balenaEtcher.AppImage'
echo ' * KeePassXC.AppImage'
echo ' * nextcloud.AppImage'
echo ' * XnView.AppImage'

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
# sudo flatpak install flathub com.vscodium.codium -y
# sudo flatpak install flathub org.libreoffice.LibreOffice -y

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

sudo add-apt-repository ppa:mozillateam/ppa -y
echo 'Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt update -y
sudo apt install firefox -y

echo '******************************'
echo librewolf
echo '******************************'

sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update -y
sudo apt install librewolf -y

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

wget -O /tmp/virtualbox.deb https://download.virtualbox.org/virtualbox/7.1.0/virtualbox-7.1_7.1.0-164728~Debian~bookworm_amd64.deb
sudo apt install /tmp/virtualbox.deb -y
sudo usermod -aG vboxusers $USER
newgrp vboxusers
wget -O /tmp/virtualbox_extension_pack.vbox-extpack https://download.virtualbox.org/virtualbox/7.1.0/Oracle_VirtualBox_Extension_Pack-7.1.0.vbox-extpack
echo 'install extension pack'

echo '******************************'
echo Beyond Compare
echo '******************************'

wget https://www.scootersoftware.com/files/bcompare-5.0.2.30045_amd64.deb
sudo apt update
sudo apt install ./bcompare-5.0.2.30045_amd64.deb

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
echo LAMP
echo '******************************'

sudo apt update -y

sudo apt install apache2
sudo apt install mariadb-server

# PHP
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https 
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php

# PHP 8.2
phpVersion="php8.2"
sudo apt install "$phpVersion"
sudo apt install "$phpVersion-mysql" "$phpVersion-mbstring" "$phpVersion-xml" "$phpVersion-curl" "libapache2-mod-$phpVersion" "$phpVersion-intl"

# PHP 8.3
phpVersion="php8.3"
sudo apt install "$phpVersion"
sudo apt install "$phpVersion-mysql" "$phpVersion-mbstring" "$phpVersion-xml" "$phpVersion-curl" "libapache2-mod-$phpVersion" "$phpVersion-intl"

echo "change php version with: sudo update-alternatives --config php"

echo '
sudo mysql -u root
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('');
FLUSH PRIVILEGES;
exit;
sudo mysql_secure_installation
'

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