## config for the Zoomer Shell

## To activate tab completion support for cht.sh
fpath=(~/.config/zsh/ $fpath)

## Enable colors and change prompt:
# autoload -U colors && colors	# Load colors

## Bash like prompt
# PS1="\
# %B%{$fg[red]%}[\
# %{$fg[yellow]%}%n\
# %{$fg[green]%}@\
# %{$fg[blue]%}%M \
# %{$fg[magenta]%}%~\
# %{$fg[red]%}]\
# %{$reset_color%}$%b "

## enable command-subsitution in PS1
# setopt PROMPT_SUBST
# PROMPT="${PWD/#$HOME/~} ﲵ "
# RPROMPT="$GITSTATUS_PROMPT"  # right prompt
# PS1="%B%~ ﲵ "

# customprompt()
# {
#   if [[ $PWD == $HOME ]]; then
#     # PS1="%F{green}%Bﲵ "
#     # starship config directory.disabled true
#     export SPACESHIP_DIR_SHOW="false"
#   else
#     # PS1="%F{green}%~ ﲵ "
#     # starship config directory.disabled false
#     export SPACESHIP_DIR_SHOW="true"
#   fi
# }
# typeset -a precmd_functions
# precmd_functions+=(customprompt)
# precmd() { customprompt }

# prompt_command() { echo -ne "\033]0; $(pwd | awk -F '/' '{if ( $NF == ENVIRON["USER"] ) print "~"; else print ENVIRON["PWD"] }') \007"; }
# precmd() { prompt_command; }

# export PROMPT_COMMAND='echo -ne "\033]0; ${${PWD/#$HOME/~}##*/} \a"'
# export PROMPT_COMMAND='echo -ne "\033]0; ${${PWD/#$HOME/~}##*/} \007"'
export PROMPT_COMMAND='echo -ne "\033]0; $(TMP=${PWD/#$HOME/\~}; echo ${TMP##*/}) \007"'
precmd() { eval "$PROMPT_COMMAND" }

# export LC_ALL=en_US.UTF-8
export LS_COLORS="tw=30:di=90:ow=94:ln=34"

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

## History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

## Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-dirs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-dirs"
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-files" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-files"
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"

## Basic auto/tab complete:
autoload -U compinit && compinit -d ~/.cache/zsh/.zcompdump
zmodload zsh/complist
zstyle ':completion:*' menu select
_comp_options+=(globdots)		# Include hidden files.

## vi mode
bindkey -v
export KEYTIMEOUT=1

## Use vim keys in tab complete menu:
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
        vicmd) echo -ne '\e[2 q';;      # block
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
# x2xalarm() { ssh -YC drksl@4l4rm x2x -north -to :0.0; }

## Tmux not-printed(archwiki)
tmux-attach() {
    (exec </dev/tty; exec <&1; tty >> /tmp/sixel-$WEZTERM_PANE; tmux attach || tmux new-session)
    trap "rm /tmp/sixel-$WEZTERM_PANE" EXIT
}
tmux-choose-tree() {
    (exec </dev/tty; exec <&1; tty >> /tmp/sixel-$WEZTERM_PANE; tmux attach\; choose-tree -s -w)
    trap "rm /tmp/sixel-$WEZTERM_PANE" EXIT
}
tmux-new-session() {
    (exec </dev/tty; exec <&1; tty >> /tmp/sixel-$WEZTERM_PANE; tmux new-session)
    trap "rm /tmp/sixel-$WEZTERM_PANE" EXIT
}
zle -N tmux-attach
zle -N tmux-choose-tree
zle -N tmux-new-session
bindkey '^a' tmux-attach      #wezterm-leaderkey
bindkey '^e' tmux-choose-tree #tree-explorer
bindkey '^s' tmux-new-session

## Show ncpmcpp(archwiki)
ncmpcppBrowserMedia() {
  ncmpcpp <$TTY
  zle redisplay
}

## Show ncpmcpp printed(archwiki)
ncmpcppPlayerMedia() {
  BUFFER="ncmpcpp"
  zle accept-line
}

zle -N ncmpcppPlayerMedia
zle -N ncmpcppBrowserMedia
bindkey '^p' ncmpcppPlayerMedia
bindkey '^n' ncmpcppBrowserMedia

cdUndoKey() {
  popd > /dev/null
  zle       reset-prompt
  eval "$PROMPT_COMMAND"
}

cdParentKey() {
  pushd .. > /dev/null
  zle       reset-prompt
  eval "$PROMPT_COMMAND"
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3D'      cdParentKey
bindkey '^[[1;3C'      cdUndoKey

# ranger_cd() {
#     temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
#     ranger --choosedir="$temp_file" -- "${@:-$PWD}"
#     if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
#         cd -- "$chosen_dir"
#     fi
#     rm -f -- "$temp_file"
# }
# bindkey -s '^r' 'ranger\n'
# [ -n $RANGERCD ] && unset RANGERCD && ranger_cd
# [ -z "$RANGERCD" ] && echo "Empty string"; [ -n "$RANGERCD" ] && echo "No-empty string"

lfcd () {
    # stty echo
    # zle redisplay
    # zle kill-whole-line
    tmp="$(mktemp)"
    # ~/.config/lf/lf-wiki-previewer/lf_ueberzug_previewer -last-dir-path="$tmp" "$@" < $TTY      #tty needed by fzf
    ~/.config/lf/lf-wiki-previewer/lf_scrolling_previewer -last-dir-path="$tmp" "$@" < /dev/tty   #tty needed by fzf
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        # customprompt
        [[ -d $1 ]] || zle reset-prompt
        eval "$PROMPT_COMMAND"
    fi
}
my-script_lfcd() lfcd -command "set nopreview; set ratios 1"
zle -N lfcd
zle -N my-script_lfcd
bindkey '^o' my-script_lfcd
bindkey '\eo' 'lfcd'
[ -n "$LF_CD" ] && unset LF_CD && lfcd $PWD

## fzf scripts
fmzcd () {
    tmp=$(mktemp)
    FZF_DEFAULT_OPTS="--layout=reverse --height=60% --border" \
    command ~/.config/lf/fmz/fmz --cd "$tmp" "$@" <$TTY
    res=$(tail -n 1 "$tmp")
    if [ -d "$res" ] && [ "$res" != "$PWD" ]; then
        cd "$res" || return 1
    fi
    # customprompt
    zle reset-prompt
    rm "$tmp" >/dev/null
}

## stpv-git(AUR)
fzfprev() {
  cd $(dirname "$(fzfp --layout=reverse --height 70% --border --color hl+:#ff0000\
    --bind='?:toggle-preview' <$TTY )")
  # customprompt
  zle reset-prompt
}

fzf_cd () {
  cd $(dirname "$(fzf --layout=reverse --height 40% --border --color hl+:#ff0000 <$TTY )")
  # customprompt
  zle reset-prompt
}

fzf_completion() {
  [[ $#BUFFER == 0 ]] && BUFFER="cd " && CURSOR=5;
  FZF_DEFAULT_OPTS="--layout=reverse --height=60% --border --color hl+:#ff0000 \
    --preview='(bat --style=plain  --color=always {})2>/dev/null || ls --color {} ' \
    --preview-window 'right,40%,border-left,hidden' \
    --bind='?:toggle-preview'" \
  zle fzf-completion
}

zle -N fmzcd
zle -N fzfprev
zle -N fzf_cd
zle -N fzf_completion && \
bindkey '^z' fmzcd
bindkey '^f' fzfprev
bindkey '^g' fzf_cd
bindkey '^K' fzf_completion

my-script1() printf '\x1b[D' >/dev/tty #tput cub1
my-script2() printf '\x1b[B' >/dev/tty #tput cud1
my-script3() printf '\x1b[A' >/dev/tty #tput cuu1
my-script4() printf '\x1b[C' >/dev/tty #tput cuf1
my-script5() printf '\x1b[5S' >/dev/tty
my-script6() printf '\x1b[2 q' >/dev/tty
my-script7() nvim -c "terminal zsh"
my-script8() lazygit
zle -N my-script1
zle -N my-script2
zle -N my-script3
zle -N my-script4
zle -N my-script5
zle -N my-script6
zle -N my-script7
zle -N my-script8
bindkey '^[n' my-script1
bindkey '^[m' my-script2
bindkey '^[,' my-script3
bindkey '^[.' my-script4
bindkey '^[[' my-script5
bindkey '^[]' my-script6
bindkey '^[z' my-script7
bindkey '^[i' my-script8

#fix supress key in st
bindkey '^[[P' delete-char

#fix supress key in alacritty
bindkey '^[[3~' delete-char

# Edit line in vim with ctrl-v:
autoload edit-command-line;
zle -N edit-command-line
bindkey '^v' edit-command-line

# Load zsh plugins; should be last.
[ -e $HOME/.nix-profile/share/fzf ]&&{
  source ~/.nix-profile/share/fzf/completion.zsh
  source ~/.nix-profile/share/fzf/key-bindings.zsh }||{
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh }

[ -e $HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]&&\
  source $HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh ||\
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

[ -e $HOME/.nix-profile/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh ]&&\
  source $HOME/.nix-profile/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh ||\
  source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# bindkey '^I' expand-or-complete

# Starship
eval "$(starship init zsh)"
