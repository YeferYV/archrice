#!/bin/sh
draw() {
  # ~/.config/lf/lf-previewer.sh/draw_img.sh "$@"
  ~/.config/lf/lf-wiki-previewer/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

if [ -n "$FIFO_UEBERZUG" ]; then
  case "$(file -Lb --mime-type -- "$file")" in

    ##DjVu
    image/vnd.djvu)
      #cache="$(hash "$file").tiff"
      cache="$(hash "$file").ppm"
      cache "$cache" "$@"
      #ddjvu -format=tiff -page=1 ${file} ${cache}
      ddjvu -format=ppm -page=1 ${file} ${cache}
      draw "$cache" "$@"
      ;;

    #image/png|image/jpeg)
    image/*)
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
      ;;
    video/*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      ffmpegthumbnailer -i "$file" -o "$cache" -s 0
      draw "$cache" "$@"
      ;;
    application/pdf)
      cache="$(hash "$file")"
      cache "$cache" "$@"
      #pdftoppm -f 1 -l 1 -singlefile -jpeg -tiffcompression jpeg -- "$file" "$cache"
      #pdftoppm -f 1 -l 1 -png "$file" output
      #pdftoppm -f 1 -l 1 -jpeg "$file" "${cache}"
      pdftoppm -f 1 -l 1 -singlefile -jpeg "$file" "${cache}"
      #draw "${cache}-1.jpg" "$@"
      draw "${cache}.jpg" "$@"
      ;;
  esac
fi
case "$(file -Lb --mime-type -- "$file")" in
  image/*)
    #img2sixel "$file" || echo "no sixel :(";;
    #ncls -b ascii "$file" || echo "no ncls :(";;
    #chafa -c 256 --size=320x100 "$file" || echo "no chafa :(";;
    chafa --size=480x150 "$file" || echo "no chafa :(";;

  video/*)
    cache="$(hash "$file").jpg"
    cache "$cache" "$@"
    ffmpegthumbnailer -i "$file" -o "$cache" -s 0
    chafa --size=480x150 "${cache}.jpg" || echo "no chafa :("
    ;;

  #*pdf) pdftotext "$file" - || echo "no pdftotext :(" ;;
  application/pdf)
    cache="$(hash "$file")"
    cache "$cache" "$@"
    pdftoppm -f 1 -l 1 -singlefile -jpeg "$file" "${cache}"
    chafa --size=480x150 "${cache}.jpg" || echo "no chafa :("
    ;;

  *tar*) tar tf "$file" || echo "no tar :(" ;;
  *zip) unzip -l "$file" || echo "no unzip :(" ;;
  *rar) unrar l "$file" || echo "no unrar :(" ;;
  *7z) 7z l "$file" || echo "no 7z :(" ;;
  # *json) python -m json.tool < "$file"  || echo "no python :(" ;;
  *json) bat -l json --style plain --color always "$file" || echo "no bat :(" ;;
  #*) highlight --out-format xterm256 -s pablo "$file" || echo "no highlight :(";;
  *) bat --style plain --color always "$file" || echo "no bat :(" ;;
esac

file -Lb -- "$1" | fold -s -w "$width"
exit 0


