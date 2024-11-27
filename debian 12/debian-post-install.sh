echo debian customize

echo Press enter to continue; read dummy;

echo '******************************'
echo Misc
echo '******************************'

sudo apt install curl

echo '******************************'
echo Configure
echo '******************************'

echo 'add user to sudo'

echo '******************************'
echo Firewall
echo '******************************'

sudo ufw enable
sudo ufw allow from 127.0.0.1
sudo ufw reload

echo '******************************'
echo remove snap
echo '******************************'

sudo apt purge snapd
sudo apt remove gnome-software-plugin-snap
# echo '# This file forbids snapd from being installed by APT
# Package: snapd
# Pin: release a=*
# Pin-Priority: -10' | sudo tee /etc/apt/preferences.d/nosnap.pref
sudo rm -rf /var/cache/snapd/
rm -rf ~/snap

echo '******************************'
echo remove apps
echo '******************************'

sudo apt autoremove gnome-mines --purge -y
sudo apt autoremove gnome-mahjongg --purge -y
sudo apt autoremove gnome-sudoku --purge -y
sudo apt autoremove gnome-todo --purge -y
sudo apt autoremove gnome-calendar --purge -y
sudo apt autoremove aisleriot --purge -y
sudo apt autoremove cheese --purge -y
sudo apt autoremove rhythmbox --purge -y
sudo apt autoremove shotwell --purge -y
sudo apt autoremove totem --purge -y
sudo apt autoremove thunderbird --purge -y
sudo apt autoremove libreoffice* --purge -y

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

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

sudo flatpak install flathub im.riot.Riot -y
sudo flatpak install flathub mattermost -y
sudo flatpak install flathub rocketchat -y
sudo flatpak install flathub org.signal.Signal -y
sudo flatpak install flathub com.slack.Slack
sudo flatpak install flathub com.mattermost.Desktop -y
sudo flatpak install flathub ch.threema.threema-web-desktop -y
sudo flatpak install flathub com.ktechpit.whatsie -y
sudo flatpak install flathub com.jetpackduba.Gitnuro -y
sudo flatpak install flathub fr.romainvigier.MetadataCleaner -y
sudo flatpak install flathub org.gimp.GIMP -y
sudo flatpak install flathub org.inkscape.Inkscape -y
sudo flatpak install flathub org.videolan.VLC -y
sudo flatpak install flathub net.cozic.joplin_desktop -y
sudo flatpak install flathub org.freefilesync.FreeFileSync -y
sudo flatpak install flathub com.protonvpn.www -y
sudo flatpak install flathub io.github.giantpinkrobots.flatsweep -y
sudo flatpak install flathub com.github.tchx84.Flatseal -y
sudo flatpak install flathub com.usebruno.Bruno -y
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y
sudo flatpak install flathub org.filezillaproject.Filezilla -y
sudo flatpak install flathub com.nextcloud.desktopclient.nextcloud -y
sudo flatpak install flathub net.hovancik.Stretchly -y
sudo flatpak install flathub com.usebruno.Bruno -y

echo '******************************'
echo matrix element
echo '******************************'
sudo apt install -y wget apt-transport-https
‍
sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
‍
echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list

sudo apt update

sudo apt install element-desktop

echo '******************************'
echo remmina
echo '******************************'
# TIB: version 1.4.25; Gateway transport type: RPC
#sudo apt install remmina -y

echo '******************************'
echo misc
echo '******************************'

sudo apt update -y

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
echo chromium
echo '******************************'

sudo add-apt-repository ppa:xtradeb/apps -y
sudo apt update
sudo apt install chromium -y

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
wget -c https://download.documentfoundation.org/libreoffice/stable/24.2.7/deb/x86_64/LibreOffice_24.2.7_Linux_x86-64_deb.tar.gz -O - | tar -xz -C /tmp/libreoffice --strip-components=1
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

# ubuntu 22.04
#echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib' | sudo tee /etc/apt/sources.list.d/virtualbox.list
# debian 12
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib' | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
sudo apt-get update
sudo apt-get install virtualbox-7.1
echo 'install extension pack'
wget https://download.virtualbox.org/virtualbox/7.1.4/Oracle_VirtualBox_Extension_Pack-7.1.4.vbox-extpack

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
echo vscodium
echo '******************************'

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update -y
sudo apt install codium -y

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
echo "fs.inotify.max_user_watches = 1048576" | tee /etc/sysctl.d/idea.conf
sudo sysctl -p --system

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
echo LAMP
echo '******************************'

sudo apt update -y

sudo apt install apache2 -y
sudo apt install mariadb-server -y

# PHP
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https 
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
