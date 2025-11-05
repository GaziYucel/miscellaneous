echo '******************************'
echo remove snap
echo '******************************'

snap list

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

sudo rm -rf /var/cache/snapd/
rm -rf ~/snap
