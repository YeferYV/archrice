# config for the Zoomer Shell

# To activate tab completion support for cht.sh
fpath=(~/.config/zsh/ $fpath)

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# PS1="\
# %B%{$fg[red]%}[\
# %{$fg[yellow]%}%n\
# %{$fg[green]%}@\
# %{$fg[blue]%}%M \
# %{$fg[magenta]%}%~\
# %{$fg[red]%}]\
# %{$reset_color%}$%b "

# setopt PROMPT_SUBST
# PROMPT='${PWD/#$HOME/~} ﲵ '
# PS1="%B%~ ﲵ "

#export PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
# precmd() { [[ $TERM == "alacritty" ]] && echo -e "\033]0;hello\007"; }
# precmd() { [[ $TERM == "alacritty" ]] && print "\033]0; $(pwd)"; }
# precmd() { [[ $TERM == "alacritty" ]] && print "\033]0; ${pwd##*/}"; }
# precmd() { [[ $TERM == "alacritty" ]] && print "\033]0; `pwd | awk -F "/" '{print $NF}'` "; }
# precmd() { [[ $TERM == "alacritty" ]] && print "\033]0; $(pwd | awk -F "/" '{print $NF}' | awk '{if ($1 == "drknss") print "~"; else print $1}') "; }
# export PROMPT_COMMAND='echo -ne "\033]0;${${PWD/#$HOME/~}##*/}\a"'
# export PROMPT_COMMAND='echo -ne "\033]0;${${PWD/#$HOME/~}##*/}\007"'
export PROMPT_COMMAND='echo -ne "\033]0;$(TMP=${PWD/#$HOME/\~};echo ${TMP##*/})\007"'
precmd() { eval "$PROMPT_COMMAND" }

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
#[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-dirs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-dirs"
#[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-files" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-files"
#[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
#[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
#export LC_ALL=en_US.UTF-8
#export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
export PATH="$HOME/.local/bin:$PATH"
#export LS_COLORS="ln=94:tw=90:ow=90:st=90:di=90"
export LS_COLORS="ln=94:di=90"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
#  1 -> blinking block
#  2 -> solid block
#  3 -> blinking underscore
#  4 -> solid underscore
#  5 -> blinking vertical bar
#  6 -> solid vertical bar
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# v() { xdotool set_window --name $(TMP=$1;echo ${TMP##*/}) $WINDOWID; vim $1; }
# n() { xdotool set_window --name $(TMP=$1;echo ${TMP##*/}) $WINDOWID; nvim $1; }
x2xalarm() { ssh -YC drksl@4l4rm x2x -north -to :0.0; }

## No Show tmux printed(archwiki)
tmux-attach() {
  # ncmpcpp <$TTY
  ( exec </dev/tty; exec <&1; TMUX= tmux attach || tmux new )
  # zle redisplay
}
zle -N tmux-attach
bindkey '\e1' tmux-attach

tmux-choose-tree() {
  ( exec </dev/tty; exec <&1; TMUX= tmux attach\; choose-tree -s -w )
}
zle -N tmux-choose-tree
bindkey '\e2' tmux-choose-tree

function tmux-new-session() {
    # Launching tmux inside a zle widget is not easy
    # Hence, We delegate the work to the parent zsh
    BUFFER=" { tmux list-sessions >& /dev/null && tmux new-session } || tmux"
    # eval $BUFFER > /dev/null
    zle accept-line
}
zle -N tmux-new-session
bindkey '\e3' tmux-new-session

nvim-terminal() {
  nvim -c "terminal zsh"
}
zle -N nvim-terminal
bindkey '\e4' nvim-terminal

## Show ncpmcpp printed(archwiki)
ncmpcppShow() {
  BUFFER="ncmpcpp"
  zle accept-line
}
zle -N ncmpcppShow
bindkey '\e5' ncmpcppShow

## Show ncpmcpp(archwiki)
ncmpcppShow() {
  ncmpcpp <$TTY
  zle redisplay
}
zle -N ncmpcppShow
bindkey '\e6' ncmpcppShow


cdUndoKey() {
  popd > /dev/null
  #zle       reset-prompt
  #print
  #ls
  zle       reset-prompt
  eval "$PROMPT_COMMAND"
}

cdParentKey() {
  pushd .. > /dev/null
  #zle      reset-prompt
  #print
  #ls
  zle       reset-prompt
  eval "$PROMPT_COMMAND"
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3D'      cdParentKey
bindkey '^[[1;3C'      cdUndoKey

ranger_cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}
#bindkey -s '^r' 'ranger\n'
#$RANGERCD && unset RANGERCD && ranger_cd
#[ -z $RANGERCD ] && unset RANGERCD && ranger_cd
#[ -z "$RANGERCD" ] &&  echo "String is empty"; [ -n "$RANGERCD" ] && echo "String is not empty"
#[ -n "$RANGERCD" ] && unset RANGERCD && ranger_cd



# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    #zle kill-whole-line
    tmp="$(mktemp)"
    #stty echo
    #lf-ueberzug -last-dir-path="$tmp" "$@" < $TTY
    ~/.config/lf/lf-wiki-previewer/lf_previewer.sh -last-dir-path="$tmp" "$@" < $TTY
    #lf -last-dir-path="$tmp" "$@" < $TTY
    #zle redisplay
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        #[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" && xdotool key KP_Enter
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        #zle reset-prompt 2>/dev/null
        [[ -d $1 ]] || zle reset-prompt
        #[ -z "$LF_CD" ] && zle reset-prompt
        eval "$PROMPT_COMMAND"
    fi
}
zle -N lfcd
bindkey '\eo' 'lfcd'
[ -n "$LF_CD" ] && unset LF_CD && lfcd $PWD
# [ -n "$LF_CD" ] && unset LF_CD && lfcd #lfcd:zle:14: widgets can only be called when ZLE is active


## my-script_widget() { cd $BUFFER ; zle reset-prompt; zle kill-whole-line;}
my-script_lfcd() lfcd -command "set nopreview; set ratios 1"
zle -N my-script_lfcd
bindkey '^o' my-script_lfcd


####################bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
#
# my-script_cd () {
#   zle reset-prompt
#   # zle redisplay
#   # stty echo
#   cd "$(dirname "$(fzf)")"
# }
# zle -N my-script_cd
# bindkey '^f' my-script_cd
#

# my-script_fmz() fmz
# zle -N my-script_fmz
# bindkey '^p' my-script_fmz

fmzcd () {
    tmp=$(mktemp)
    command fmz --cd "$tmp" "$@"
    res=$(tail -n 1 "$tmp")
    if [ -d "$res" ] && [ "$res" != "$PWD" ]; then
        echo cd "$res"
        cd "$res" || return 1
    fi
    rm "$tmp"
}
zle -N fmzcd
bindkey '^f' fmzcd

my-script_fzfp() fzfp
zle -N my-script_fzfp
bindkey '^g' my-script_fzfp


#fix supress key in st
bindkey '^[[P' delete-char

#fix supress key in alacritty
bindkey '^[[3~' delete-char

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Exit with ctrl-e
bindkey -s '^e' 'exit\n'

# Load zsh plugins; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
# source /usr/share/gitstatus/gitstatus.prompt.zsh
# PROMPT='%~%# '               # left prompt: directory followed by %/# (normal/root)
# RPROMPT='$GITSTATUS_PROMPT'  # right prompt: git status

## Spaceship Prompt
autoload -U promptinit; promptinit
prompt spaceship



