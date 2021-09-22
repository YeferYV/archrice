#!/bin/sh

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *.jpg) chafa --size=480x150 "$1" || echo "no chafa :(" ;;
    *.png) chafa --size=480x150 "$1" || echo "no chafa :(" ;;
    #*.png) img2sixel "$1";;
    #*) highlight -O ansi "$1" || cat "$1";;
    *) highlight --out-format xterm256 -s pablo "$1" || cat "$1";;
esac

