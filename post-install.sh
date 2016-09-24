#!/bin/sh

# Post installation script for Fedora
# ===================================

# run this script as regular user and go to the user's home dir
if [[ `id -u` == 0 ]]; then
	echo "ERROR: Run the script as regular user"
	exit 1
fi
cd $HOME

# remove packages I don't need
sudo dnf remove catfish xfce4-clipman-plugin firefox leafpad xfburn geany parole pragha claws-mail asunder abiword gnumeric xfdashboard

# then update the rest of tha packages
sudo dnf update

# install new packages
sudo dnf install wget binutils gcc make patch libgomp glibc-headers \
  glibc-devel kernel-headers kernel-devel dkms gvfs-mtp gvim vim \
  kernel-{devel,headers} make gcc dkms git dialog unar htop thunderbird \
  shutter luma libreoffice-{writer,calc} wireshark-gtk openldap-clients \
  nmap

# google hangouts for pidgin
sudo dnf install purple-hangouts pidgin-hangouts

# install VLC player
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
sudo dnf install vlc


# clone my dotfiles from github
git clone https://github.com/mmsrubar/.dotfiles
# go into the $HOME/.dotfile and run link-dotfiles.sh

# remove 
rm -r Documents Downloads Music Pictures Public Videos  

