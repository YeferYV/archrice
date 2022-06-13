#!/bin/env zsh

## notification daemon
dunst &

## music player daemon
# mpd &
# mpDris2 &

## simple hotkey daemon
# sxhkd &

## screen temperature
redshift -O 4444 &

## xmodmaps and xcapes
remaps &

## space-leader remapping
# touchcursor &

## Remove mouse when idle
unclutter --timeout 1 &

## Load a resource file, and merge with the current settings (for urxvt)
# xrdb -merge ~/.config/x11/xresources &

## To Load pointer
xsetroot -cursor_name left_ptr &

## Set Wallpaper
# hsetroot -solid "#080808" &
xwallpaper --zoom "$HOME/.local/share/bg" &

## vncserver
# x0vncserver -rfbauth ~/.vnc/passwd &

###############################################################################
# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p "$HOME"/.local/share/keyrings
###############################################################################

##############################################################################
# # see https://github.com/microsoft/vscode/issues/120392#issuecomment-814210643
# # init keyring
# eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# # export keyring
# export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
# exec dbus-launch bspwm
###############################################################################

###############################################################################
# see https://bbs.archlinux.org/viewtopic.php?id=273011
# exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
###############################################################################

## window-manager (exec for logout)
# exec i3
# exec dwm
exec bspwm

