echo '******************************'
echo phpstorm
echo '******************************'

version = "2024.2.1"

mkdir ~/apps
rm -rf ~/apps/jetbrains-phpstorm
mkdir jetbrains-phpstorm
wget -c https://download.jetbrains.com/webide/PhpStorm-$version.tar.gz -O - | tar -xz -C jetbrains-phpstorm --strip-components=1
mv jetbrains-phpstorm ~/apps
echo "[Desktop Entry]
Name=PhpStorm
Exec=~/apps/jetbrains-phpstorm/bin/phpstorm %u
Icon=~/apps/jetbrains-phpstorm/bin/phpstorm.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-phpstorm
" | tee ~/.local/share/applications/jetbrains-phpstorm.desktop
echo "fs.inotify.max_user_watches = 1048576" | tee /etc/sysctl.d/idea.conf
sudo sysctl -p --system

echo '******************************'
echo pycharm CE
echo '******************************'

mkdir ~/apps
rm -rf ~/apps/jetbrains-pycharm-ce
mkdir jetbrains-pycharm-ce
wget -c https://download.jetbrains.com/python/pycharm-community-$version.tar.gz -O - | tar -xz -C jetbrains-pycharm-ce --strip-components=1
mv jetbrains-pycharm-ce ~/apps
echo "[Desktop Entry]
Name=PyCharm Community
Exec=~/apps/jetbrains-pycharm-ce/bin/pycharm %u
Icon=~/apps/jetbrains-pycharm-ce/bin/pycharm.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-pycharm-ce
" | tee ~/.local/share/applications/jetbrains-pycharm-ce.desktop

echo '******************************'
echo intellij idea CE
echo '******************************'

mkdir ~/apps
rm -rf ~/apps/jetbrains-idea-ce
mkdir jetbrains-idea-ce
wget -c https://download.jetbrains.com/idea/ideaIC-$version.tar.gz -O - | tar -xz -C jetbrains-idea-ce --strip-components=1
mv jetbrains-idea-ce ~/apps
echo "[Desktop Entry]
Name=IntelliJ IDEA Community
Exec=~/apps/jetbrains-idea-ce/bin/idea %u
Icon=~/apps/jetbrains-idea-ce/bin/idea.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-idea-ce
" | tee ~/.local/share/applications/jetbrains-idea-ce.desktop

echo '******************************'
echo RustRover CE
echo '******************************'

mkdir ~/apps
rm -rf ~/apps/jetbrains-rustrover-ce
mkdir jetbrains-rustrover-ce
wget -c https://download.jetbrains.com/rustrover/RustRover-$version.tar.gz -O - | tar -xz -C jetbrains-rustrover-ce --strip-components=1
mv jetbrains-rustrover-ce ~/apps
echo "[Desktop Entry]
Name=IntelliJ IDEA Community
Exec=~/apps/jetbrains-rustrover-ce/bin/idea %u
Icon=~/apps/jetbrains-rustrover-ce/bin/idea.png
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
Type=Application
StartupWMClass=jetbrains-rustrover-ce
" | tee ~/.local/share/applications/jetbrains-rustrover-ce.desktop
