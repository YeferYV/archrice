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
dragon-drop \
dunst \
efibootmgr \
exfat-utils \
eza \
festival-us \
fzf \
ghostscript \
gnome-keyring \
grub \
imagemagick \
kanata-bin \
kitty \
lazygit \
lf \
libnotify \
light \
linux \
linux-firmware \
man-db \
moreutils \
mpc \
mpd \
mpv-mpris \
ncmpcpp \
network-manager-applet \
networkmanager \
noto-fonts \
noto-fonts-emoji \
ntfs-3g \
perl-file-mimeinfo \
picom \
pipewire-pulse \
playerctl \
polybar \
redshift \
ripgrep \
rofi \
rofimoji \
siji-git \
snapper \
starship \
stow \
sxhkd \
sxiv \
ttf-3270-nerd \
ttf-firacode-nerd \
ttf-font-awesome \
unclutter \
wezterm \
xclip \
xdo \
xdotool \
xf86-input-synaptics \
xorg-server \
xorg-xinit \
xorg-xsetroot \
xorg-xwininfo \
xwallpaper \
zathura-pdf-poppler \
zram-generator \
zsh-autosuggestions \
zsh-fast-syntax-highlighting

# pywal-16-colors \
# xorg-xwininfo \
# polkit \
# libertinus-font \
# ttf-font-awesome \
# ttf-dejavu \
# lf-git \
# ueberzug \
# bc \
# xcompmgr \
# xorg-xprop \
# arandr \
# calcurse \
# nsxiv \
# ffmpegthumbnailer \
# python-qdarkstyle \
# newsboat \
# librewolf-bin \
# arkenfox-user.js \
# noto-fonts \
# noto-fonts-emoji \
# wireplumber \
# pulsemixer \
# sc-im \
# maim \
# abook \
# lynx \
# yt-dlp \
# zathura \
# zathura-pdf-mupdf \
# atool \
# xorg-xbacklight \
# task-spooler \
# simple-mtpfs \
# mutt-wizard-git \
# slock \
# socat \

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
