#!/usr/bin/env sh

#offset="$(cat "$LF_SCROLLINGPREVIEW_TEMPDIR/offset")"
offset="$LF_SCROLLINGPREVIEW_TEMPVAR"

file="$1"; shift
case "$(basename "$file" | tr '[:upper:]' '[:lower:]')" in
*.tar*) tar tf "$file" ;;
*.zip) unzip -l "$file" ;;
*.rar) unrar l "$file" ;;
*.7z) 7z l "$file" ;;
*.avi|*.mp4|*.mkv|*.pdf|*.jpg|*.jpeg|*.png|*.bmp|*.svg|*.gif)
	file "$file" # dummy; use 'lf-ueberzug' for gui previews
	;;
*) sed -n "$offset,\$p" "$file" ;;
esac
