#!/bin/env zsh

# export FZF_DEFAULT_COMMAND='rg --color=always --line-number ""'
# export FZF_DEFAULT_OPTS='--ansi --delimiter : --preview "bat --color=always {1} --highlight-line {2}"  --preview-window "up,60%,+{2}" --bind "enter:become(echo {1}; nvim -u $HOME/.vscode/extensions/yeferyv.retronvim/nvim/init.lua {1} +{2} >/dev/tty)"'
# export LANG=en_US.UTF-8
# export LC_ALL=C.UTF-8 # `locale` lists all user's locale https://wiki.archlinux.org/title/Locale
# export NVIM_APPNAME="sixelrice"
# export VISUAL="code"
export BAT_THEME="base16"
export BROWSER="google-chrome-stable"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export CHTSH_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/cht.sh/cht.sh.conf"
export EDITOR="nvim"
export EZA_COLORS="reset:uu=0:ur=0:uw=0:ux=0:ue=0:gu=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:da=0:sn=0:di=34"
export FZF_DEFAULT_OPTS='--color "hl:-1:reverse,hl+:-1:reverse" --preview "bat --color=always {}" --preview-window "hidden" --bind "?:toggle-preview"'
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HISTFILE="$HOME/.cache/.zsh_history"
export LESSHISTFILE="-"
export LESSKEYIN="$HOME/.config/yazi/lesskey"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm"
export PATH="$HOME/.pixi/bin:$HOME/.local/share/pnpm:$HOME/.local/share/npm/bin:$HOME/.local/bin:$HOME/.console-ninja/.bin:$PATH"
export PNPM_HOME=$HOME/.local/share/pnpm
export SAVEHIST=10000
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export SWALLOWER="bspswap"
export TERM="xterm-256color" # inside docker terminal
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

## To activate tab completion support for cht.sh if `nix-env -iA nixpkgs.cht-sh`
fpath=(~/.nix-profile/share/zsh/site-functions/ $fpath)

# export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"
export LESS='-RS'
export LESSOPEN="| /usr/bin/bat --style full --color always --paging always --wrap never %s"
# # export LESS_TERMCAP_so="$(printf '%b' '[01;43;30m')"                                # f: black b: yellow  # start standout (reversed)
# export LESS_TERMCAP_mb="$(printf '%b' '[1;34m')"                                      # f: blue             # start blinking
# export LESS_TERMCAP_md="$(printf '%b' '[1;32m')"                                      # f: green            # start bold
# export LESS_TERMCAP_me="$(printf '%b' '[0m')"                                         #                     # stop bold, blink and underline
# export LESS_TERMCAP_so="$(printf '%b' '[01;33m')"                                     # f: yellow           # start standout (reversed)
# export LESS_TERMCAP_se="$(printf '%b' '[0m')"                                         #                     # stop standout
# export LESS_TERMCAP_us="$(printf '%b' '[1;31m')"                                      # f: red              # start underline
# export LESS_TERMCAP_ue="$(printf '%b' '[0m')"                                         #                     # stop underline
# # export LESS_TERMCAP_so=$(tput -T ansi smso; tput -T ansi rev ; tput -T ansi setaf 3)  # f: black b: yellow  # start standout (reversed)
export LESS_TERMCAP_mb=$(tput -T ansi blink)                                              #                     # start blinking
export LESS_TERMCAP_md=$(tput -T ansi bold; tput -T ansi setaf 2)                         # f: green            # start bold
export LESS_TERMCAP_me=$(tput -T ansi sgr0)                                               #                     # stop bold, blink and underline
export LESS_TERMCAP_so=$(tput -T ansi smso; tput -T ansi setaf 0; tput -T ansi setab 3)   # f: black b: yellow  # start standout (reversed)
export LESS_TERMCAP_se=$(tput -T ansi rmso)                                               #                     # stop standout
export LESS_TERMCAP_us=$(tput -T ansi smul; tput -T ansi setaf 1)                         # f: red              # start underline
export LESS_TERMCAP_ue=$(tput -T ansi rmul)                                               #                     # stop underline

export LS_COLORS="\
tw=90:\ #black
or=91:\ #red
ex=92:\ #green
bd=93:\ #yellow
di=94:\ #blue
ow=95:\ #magenta
ln=96:\ #cyan
fi=97"  #white

if [ -e /.dockerenv ]; then export APPIMAGE_EXTRACT_AND_RUN=1; fi
if [ -e /.dockerenv ]; then sudo chown $USER:$USER /run/user/1000; fi
if [ -e /.dockerenv ]; then alias mpv="XDG_RUNTIME_DIR=/run/user/1000 mpv"; fi
if [ -e /.dockerenv ] && [ -e /bin/sshd ]; then sudo ssh-keygen -A && sudo /bin/sshd; fi
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Start graphical server on user's current tty if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

# alias youtubeaudiowebm="youtube-dl --add-metadata --ignore-errors --write-thumbnail --format bestaudio " \
# alias youtubeaudioopus="youtube-dl --add-metadata --ignore-errors --write-thumbnail --extract-audio --format bestaudio/best " \
# alias youtubevidaudiosub="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo+bestaudio' " \
# alias youtubevidsub720="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo[height<=720]+bestaudio' " \
# alias youtubevidsub480="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo[height<=480]+bestaudio' " \
# alias youtubevidsub360="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo[height<=360]+bestaudio' " \
# alias youtubevid720="yt-dlp --add-metadata --format 'bestvideo[height<=720]+bestaudio' " \
# alias youtubearia2c="yt-dlp --add-metadata --external-downloader aria2c --external-downloader-args '-c -j 5 -x 5 -s 5 -k 1M'" \
