exit

#!/bin/bash
set -x #echo on

echo post install

echo Press enter to continue; read dummy;

sudo apt update
sudo apt upgrade -y

echo '******************************'
echo Misc
echo '******************************'

sudo apt install curl -y
sudo apt install net-tools -y
sudo apt install apt-transport-https -y
sudo apt install wget -y
sudo apt install software-properties-common -y
sudo apt install ca-certificates -y
sudo apt install lsb-release -y

echo '******************************'
echo Configure
echo '******************************'

echo 'add user to sudo'
sudo usermod -aG sudo $USER

echo '******************************'
echo remove apps
echo '******************************'

sudo apt autoremove aisleriot --purge -y
sudo apt autoremove cheese --purge -y
sudo apt autoremove five-or-more --purge -y
sudo apt autoremove four-in-a-row --purge -y
sudo apt autoremove gnome-2048 --purge -y
sudo apt autoremove gnome-boxes --purge -y
sudo apt autoremove gnome-calendar --purge -y
sudo apt autoremove gnome-chess --purge -y
sudo apt autoremove gnome-klotski --purge -y
sudo apt autoremove gnome-mahjongg --purge -y
sudo apt autoremove gnome-mines --purge -y
sudo apt autoremove gnome-nibbles --purge -y
sudo apt autoremove gnome-robots --purge -y
sudo apt autoremove gnome-sudoku --purge -y
sudo apt autoremove gnome-taquin --purge -y
sudo apt autoremove gnome-tetravex --purge -y
sudo apt autoremove gnome-todo --purge -y
sudo apt autoremove hitori --purge -y
sudo apt autoremove iagno --purge -y
sudo apt autoremove lightsoff --purge -y
sudo apt autoremove quadrapassel --purge -y
sudo apt autoremove rhythmbox --purge -y
sudo apt autoremove shotwell --purge -y
sudo apt autoremove swell-foop --purge -y
sudo apt autoremove tali --purge -y
sudo apt autoremove thunderbird --purge -y
sudo apt autoremove totem --purge -y

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean
sudo apt update
sudo apt upgrade -y

echo '******************************'
echo flatpak
echo '******************************'

sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo apt update

sudo flatpak install flathub ch.threema.threema-web-desktop -y
sudo flatpak install flathub chat.rocket.RocketChat -y
sudo flatpak install flathub com.github.tchx84.Flatseal -y
sudo flatpak install flathub com.jetpackduba.Gitnuro -y
sudo flatpak install flathub com.ktechpit.whatsie -y
sudo flatpak install flathub com.mattermost.Desktop -y
sudo flatpak install flathub com.nextcloud.desktopclient.nextcloud -y
sudo flatpak install flathub com.protonvpn.www -y
sudo flatpak install flathub com.slack.Slack
sudo flatpak install flathub com.usebruno.Bruno -y
sudo flatpak install flathub fr.romainvigier.MetadataCleaner -y
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y
sudo flatpak install flathub io.github.giantpinkrobots.flatsweep -y
sudo flatpak install flathub net.cozic.joplin_desktop -y
sudo flatpak install flathub net.hovancik.Stretchly -y
sudo flatpak install flathub org.filezillaproject.Filezilla -y
sudo flatpak install flathub org.freefilesync.FreeFileSync -y
sudo flatpak install flathub org.gimp.GIMP -y
sudo flatpak install flathub org.inkscape.Inkscape -y
sudo flatpak install flathub org.signal.Signal -y
sudo flatpak install flathub org.videolan.VLC -y

echo '******************************'
echo deb apps
echo '******************************'

sudo apt install gufw -y
sudo apt install evolution evolution-ews -y
sudo apt install gnome-tweaks -y
sudo apt install stacer -y
sudo apt install dconf-editor -y
sudo apt install hardinfo -y
sudo apt install ubuntu-restricted-extras -y

echo 'install the following apps manually'
echo ' * balenaEtcher.AppImage'
echo ' * XnView.AppImage'

echo '******************************'
echo signal messenger
echo '******************************'

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update
sudo apt install signal-desktop

echo '******************************'
echo matrix element
echo '******************************'
‍
sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
sudo apt update
sudo apt install element-desktop

echo '******************************'
echo remmina
echo '******************************'
# TIB: version 1.4.25; Gateway transport type: RPC
#sudo apt install remmina -y

echo '******************************'
echo chromium
echo '******************************'

sudo add-apt-repository ppa:xtradeb/apps -y
sudo apt update
sudo apt install chromium -y

echo '******************************'
echo veracrypt
echo '******************************'

sudo add-apt-repository ppa:unit193/encryption
sudo apt update
sudo apt install veracrypt -y

echo '******************************'
echo firefox
echo '******************************'

sudo add-apt-repository ppa:mozillateam/ppa -y
echo 'Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt update
sudo apt install firefox -y

echo '******************************'
echo librewolf
echo '******************************'

sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update
sudo apt install librewolf -y

echo '******************************'
echo vscodium
echo '******************************'

sudo apt install extrepo -y
sudo extrepo enable vscodium
sudo apt update
sudo apt install codium

echo '******************************'
echo Beyond Compare
echo '******************************'

wget https://www.scootersoftware.com/DEB-GPG-KEY-scootersoftware.asc
sudo cp DEB-GPG-KEY-scootersoftware.asc /etc/apt/trusted.gpg.d/
wget https://www.scootersoftware.com/scootersoftware.list
sudo cp scootersoftware.list /etc/apt/sources.list.d/
sudo apt update
sudo apt install bcompare -y


echo '******************************'
echo extension manager
echo '******************************'

sudo apt install gnome-shell-extension-manager -y
echo 'install the following extensions'
echo ' * Alphabetical App Grid'
echo ' * AppIndicator and KStatusNotifierItem Support'
echo ' * Dash to Panel'
echo ' * Desktop icons NG (DING)'

echo '******************************'
echo git
echo '******************************'

sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git -y

echo '******************************'
echo nvm / nodejs
echo '******************************'

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
#nvm install 22
#node -v
#npm -v

echo '******************************'
echo virtual box
echo '******************************'

# ubuntu 22.04 jammy
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib' | sudo tee /etc/apt/sources.list.d/virtualbox.list
# debian 12 bookworm
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib' | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
sudo apt-get update
sudo apt-get install virtualbox-7.1
echo 'install extension pack'
wget https://download.virtualbox.org/virtualbox/7.1.4/Oracle_VirtualBox_Extension_Pack-7.1.4.vbox-extpack

echo '******************************'
echo LAMP
echo '******************************'

sudo apt update

sudo apt install apache2 -y
sudo apt install mariadb-server -y

# PHP
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php

# PHP 8.1
phpVersion="php8.1"
sudo apt install "$phpVersion" -y
sudo apt install "$phpVersion-mysql" "$phpVersion-mbstring" "$phpVersion-xml" "$phpVersion-curl" "libapache2-mod-$phpVersion" "$phpVersion-intl" "$phpVersion-zip" "$phpVersion-bcmath" "$phpVersion-gd" -y

# PHP 8.2
phpVersion="php8.2"
sudo apt install "$phpVersion" -y
sudo apt install "$phpVersion-mysql" "$phpVersion-mbstring" "$phpVersion-xml" "$phpVersion-curl" "libapache2-mod-$phpVersion" "$phpVersion-intl" "$phpVersion-zip" "$phpVersion-bcmath" "$phpVersion-gd" -y

# PHP 8.3
phpVersion="php8.3"
sudo apt install "$phpVersion" -y
sudo apt install "$phpVersion-mysql" "$phpVersion-mbstring" "$phpVersion-xml" "$phpVersion-curl" "libapache2-mod-$phpVersion" "$phpVersion-intl" "$phpVersion-zip" "$phpVersion-bcmath" "$phpVersion-gd" -y

# PHP 8.4
phpVersion="php8.4"
sudo apt install "$phpVersion" -y
sudo apt install "$phpVersion-mysql" "$phpVersion-mbstring" "$phpVersion-xml" "$phpVersion-curl" "libapache2-mod-$phpVersion" "$phpVersion-intl" "$phpVersion-zip" "$phpVersion-bcmath" "$phpVersion-gd" -y

echo "change php version with: "
echo "sudo update-alternatives --config php"

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
echo firewall
echo '******************************'

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default deny outgoing

### localhost
sudo ufw allow from 127.0.0.1

# imap
sudo ufw allow out 993

# smtp
sudo ufw allow out 465

# qbitorrent
sudo ufw allow 6969

# dns
sudo ufw allow out 53

# http
sudo ufw allow out http
sudo ufw allow out https

# ssh
sudo ufw allow out 22

# rdp
sudo ufw allow out 3389
sudo ufw allow out 51972

# printer
sudo ufw allow out 9100

sudo ufw reload

echo '******************************'
echo cleanup / update / upgrade
echo '******************************'

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean
sudo apt update
sudo apt upgrade -y

echo '******************************'
echo end of script
echo '******************************'

echo Press enter to exit; read dummy;
