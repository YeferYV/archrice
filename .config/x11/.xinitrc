#!/bin/sh

## Set Wallpaper
#hsetroot -solid "#080808" &
#feh --bg-fill ~/.local/share/bg &
#setbg &
#wal -i "~/.local/share/bg" -o "~/.config/wal/postrun"
xwallpaper --zoom "$HOME/.local/share/bg"

## to start notification server
dunst &

# Uncomment this line when using i3.
# export STATUSBAR="i3blocks" &

## to start a transparent systray
# stalonetray -t &
# dwmbar.sh &

## music player daemon
#mpd &
#mpDris2 &

## to screen temperature
redshift -O 4444 &

## Load a remaps file
remaps &

## To cycle i3wm
# ~/.config/i3/i3-focus-last.py &

## Window Switcher EWMH complain
# ukui-window-switch &

## Remove mouse when idle
unclutter --timeout 1 &

## Load a resource file, and merge with the current settings (for urxvt)
xrdb -merge ~/.config/x11/xresources &

## To Load pointer
xsetroot -cursor_name left_ptr &

## bsp-layout flags
# bsp-layout set rtall I --master-size 0.8 &

# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p "$HOME"/.local/share/keyrings

## to execute wm at startup
# exec openbox-session
# exec i3
# exec dwm
exec bspwm

