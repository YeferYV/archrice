#!/bin/sh

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *.jpg) chafa --size=480x150 "$1" || echo "no chafa :(" ;;
    *.png) chafa --size=480x150 "$1" || echo "no chafa :(" ;;
    # *.jpg) ~/.config/lf/fzfimg/fzfimg.sh --preview 'draw_preview "$1"';;
    # *.png) ~/.config/lf/fzfimg/fzfimg.sh --preview 'draw_preview $1';;
    # *.jpg) fzfp "$1" || echo "no stpv/fzfp";;
    # *.png) fzfp "$1" || echo "no stpv/fzfp";;
    # *.jpg) img2sixel "$1";;
    # *.png) img2sixel "$1";;
    # *.jpg) kitty +kitten icat "$1";;
    # *.png) kitty +kitten icat "$1";;
    #*) highlight -O ansi "$1" || cat "$1";;
    #*) highlight --out-format xterm256 -s pablo "$1" || cat "$1";;
    *json) bat -l json --style plain --color=always "$1" || echo "no bat :(" ;;
    *) bat --style plain --color=always "$1" || echo "no bat :(" ;;
esac

