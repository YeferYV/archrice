#!/bin/sh

pacman -Rscn $(yay -Qtdq)
updatedb
pkgfile -u
pacman -Fyy
pacman-db-upgrade
yes | pacman -Scc
sync
## to check .cache size:
# du -sh .cache
## to remove .cache:
# rm -rf .cache/*
