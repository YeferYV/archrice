#!/bin/env zsh

# export PATH="$PATH:$HOME/.local/appimage:$HOME/.local/bin"
# export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
# export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
export PATH="$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':'):$HOME/.local/share/npm/bin:$PATH"

# unsetopt PROMPT_SP
# export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
# export PROMPT_COMMAND='echo -ne "\033]0;$(TMP=${PWD/#$HOME/\~};echo ${TMP##*/})\007"'
# export PS1="[\w]\$ "

#-- Default programs:
# export NEOVIDE_MULTIGRID=true
export TERM="xterm-256color" # inside docker TERM is xterm which makes tmux 8 colors
export BAT_THEME="base16"
export BROWSER="google-chrome-stable"
export EDITOR="nvim"
export OPENER="gio open" #"xdg-open"
export PAGER="less"
export SHELL="$(which zsh)"
export SURFRAW_graphical=no
export SURFRAW_text_browser='w3m -sixel'
export SWALLOWER="bspswap"
export TERMINAL="wezterm"
export VISUAL="nvim"

#-- ~/Clean-up:
# export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
# export DRI_PRIME=1 #Dedicated GPU as default
# export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
# export GPG_TTY=$(tty)
# export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
# export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/.xinitrc"
# export XSERVERRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/.xserverrc"
# export ZSH_COMPDUMP="$HOME/.cache/zsh/.zcompdump"
# export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
# export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
# export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
# export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export CHTSH_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/cht.sh/cht.sh.conf"
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export LESSHISTFILE="-"
export LESSKEYIN="${XDG_CONFIG_HOME:-$HOME/.config}/shell/lesskey"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"

#-- Other program settings:
# export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border"
# export LOCALE_ARCHIVE="/lib/locale/locale-archive" # nix locale
export DEBIAN_FRONTEND=noninteractive
export FZF_DEFAULT_OPTS="--multi --color='hl:#cccc00,hl+:#cccc00'"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

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

export LF_ICONS="\
tw=󰉋:\
or=:\
ex=:\
bd=:\
di=󰉋:\
ow=󰉋:\
ln=:\
fi="

if [ -e /.dockerenv ]; then export APPIMAGE_EXTRACT_AND_RUN=1; fi
if [ -e /.dockerenv ]; then sudo chown $USER:$USER /run/user/1000; fi
if [ -e /.dockerenv ]; then alias mpv="XDG_RUNTIME_DIR=/run/user/1000 mpv"; fi
if [ -e /.dockerenv ] && [ -e /bin/sshd ]; then sudo ssh-keygen -A && sudo /bin/sshd; fi
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Start graphical server on user's current tty if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
