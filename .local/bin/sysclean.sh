#!/bin/sh

read -p "reset to essential packages? [y/N]" ans
[ "$ans" != "y" ] && exit

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages
# pacman -Qqe

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_everything_but_essential_packages
sudo pacman -D --asdeps $(pacman -Qqe)
sudo pacman -D --asexplicit \
autoconf \
automake \
base \
base-devel \
bat \
bison \
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
fakeroot \
festival-us \
flex \
fzf \
gcc \
git \
gnome-keyring \
google-chrome \
groff \
grub \
gtk-theme-arc-gruvbox-git \
htop-vim \
kitty \
lazygit \
lf \
libnotify \
libsixel \
libtool \
light \
linux \
linux-firmware \
m4 \
make \
man-db \
mediainfo \
moreutils \
mpc \
mpd \
mpv-mpris \
ncmpcpp \
network-manager-applet \
networkmanager \
ntfs-3g \
patch \
perl-file-mimeinfo \
picom \
pipewire-pulse \
pkgconf \
playerctl \
polybar \
pywal-16-colors \
redshift \
ripgrep \
rofi \
rofimoji \
siji-git \
snapper \
snapper-rollback \
starship \
stow \
sudo \
sxhkd \
sxiv \
texinfo \
touchcursor-linux-git \
unclutter \
unzip \
visual-studio-code-bin \
wezterm \
which \
xcape \
xclip \
xdo \
xdotool \
xf86-input-synaptics \
xorg-server \
xorg-xinit \
xorg-xmodmap \
xorg-xsetroot \
xwallpaper \
zathura-pdf-poppler \
zram-generator \
zsh-autosuggestions \
zsh-fast-syntax-highlighting

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
