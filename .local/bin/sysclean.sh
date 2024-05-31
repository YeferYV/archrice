#!/bin/sh

read -p "reset to essential packages? [y/N]" ans
[ "$ans" != "y" ] && exit

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages
# pacman -Qqe

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_everything_but_essential_packages
sudo pacman -D --asdeps $(pacman -Qqe)
sudo pacman -D --asexplicit \
base \
base-devel \
bat \
broadcom-wl \
bspwm-git \
btrfs-progs \
cht.sh-git \
cronie \
dmenu \
dosfstools \
dunst \
efibootmgr \
exfat-utils \
eza \
festival-us \
fzf \
gnome-keyring \
grub \
imagemagick \
kanata-bin \
lazygit \
libnotify \
light \
linux \
linux-firmware \
man-db \
mpc \
mpd \
mpv-mpris \
ncmpcpp \
network-manager-applet \
noto-fonts \
noto-fonts-emoji \
ntfs-3g \
picom \
pipewire-pulse \
polybar \
redshift \
ripdrag-git \
ripgrep \
siji-git \
snapper \
starship \
stow \
sxhkd \
sxiv \
ttf-firacode-nerd \
unclutter \
wezterm \
xclip \
xf86-input-synaptics \
xorg-server \
xorg-xinit \
xorg-xsetroot \
xwallpaper \
yazi \
zathura-pdf-poppler \
zram-generator \
zsh-autosuggestions \
zsh-fast-syntax-highlighting
# dragon-drop \
# ghostscript \
# kitty \
# lf \
# perl-file-mimeinfo \
# playerctl \
# rofi \
# rofimoji \
# ttf-font-awesome \
# xdo \
# xdotool \
# xorg-xrdb \
# xorg-xwininfo \

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)
sudo pacman -Rscn $(yay -Qtdq)
sudo pacman -Fy
sudo pacman-db-upgrade
yes | yay -Scc
yay -Ps
sync
# updatedb
# pkgfile -u
# du -sh ~/.cache
