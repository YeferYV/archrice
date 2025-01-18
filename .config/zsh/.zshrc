## To activate tab completion support for cht.sh
fpath=(~/.config/zsh/ $fpath)

# export PROMPT_COMMAND='echo -ne "\033]0; ${${PWD/#$HOME/~}##*/} \a"'
# export PROMPT_COMMAND='echo -ne "\033]0; ${${PWD/#$HOME/~}##*/} \007"'
export PROMPT_COMMAND='echo -ne "\033]0; $(TMP=${PWD/#$HOME/\~}; echo ${TMP##*/}) \007"'
precmd() { eval "$PROMPT_COMMAND" }

# alias youtubeaudiowebm="youtube-dl --add-metadata --ignore-errors --write-thumbnail --format bestaudio " \
# alias youtubeaudioopus="youtube-dl --add-metadata --ignore-errors --write-thumbnail --extract-audio --format bestaudio/best " \
# alias youtubevidaudiosub="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo+bestaudio' " \
# alias youtubevidsub720="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo[height<=720]+bestaudio' " \
# alias youtubevidsub480="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo[height<=480]+bestaudio' " \
# alias youtubevidsub360="youtube-dl --add-metadata --ignore-errors --write-auto-sub --write-sub --format 'bestvideo[height<=360]+bestaudio' " \
# alias youtubevid720="yt-dlp --add-metadata --format 'bestvideo[height<=720]+bestaudio' " \
# alias youtubearia2c="yt-dlp --add-metadata --external-downloader aria2c --external-downloader-args '-c -j 5 -x 5 -s 5 -k 1M'" \

# _colorize_commands_when_possible_
alias \
	ll="ls -l" \
	grep="grep --color=auto" \
	diff="diff --color=auto" \
	pacman="sudo pacman --noconfirm" \
	apt="sudo apt -y" \
	cht="cht.sh" \
	# cht="cheat-sh" \

# _vim_tmux_status_aliases_
alias \
  avim="NVIM_APPNAME=archrice nvim" \
  cvim="NVIM_APPNAME=nvchad nvim" \
  lvim="NVIM_APPNAME=lunarvim nvim" \
  rvim="NVIM_APPNAME=retronvim nvim" \
  svim="NVIM_APPNAME=sixelrice nvim" \
  tvim="NVIM_APPNAME=astronvim nvim" \
  zvim="NVIM_APPNAME=lazyvim nvim"

# Edit line in vim with ctrl-v:
autoload edit-command-line;
zle -N edit-command-line
bindkey '^v' edit-command-line

# fzf files content
fzf-rg() { rg --files-with-matches "" | fzf --preview="rg --pretty --context 3 {q} {}" --preview-window "nohidden" --phony --bind "change:reload:rg --files-with-matches {q}" --bind "enter:become(nvim {1} +{2})"; }

autoload -U compinit && compinit -u -d $HOME/.cache/.zcompdump # enable command completion
bindkey -v '^?' backward-delete-char                           # enable vi-mode with backward-delete-char
setopt inc_append_history                                      # save to history after running a command
setopt interactive_comments                                    # allow comments
zstyle ":completion:*" menu select                             # <tab><tab> to enter menu completion

# linux keyboard repeat rate, xset doesn't support wayland
(xset b off r rate 190 70 2>/dev/null)

# Change cursor shape for different vi modes.
zle-keymap-select() { [[ $KEYMAP == "vicmd" ]] && echo -ne '\e[2 q' || echo -ne '\e[6 q'; }
zle-line-init() { echo -ne "\e[6 q"; } # use beam shape cursor after ctrl+c or enter or startup
zle -N zle-line-init                   # overwriting zle-line-init
zle -N zle-keymap-select               # overwriting zle-keymap-select

# retronvim's neovim
vi() { nvim -u $HOME/.vscode/extensions/yeferyv.retronvim/nvim/init.lua $@; }

# yazi cd on exit (then moves the cursor up and clear until end of line)
y() { yazi --cwd-file=$HOME/.yazi $@; cd "$(cat $HOME/.yazi)"; printf "\x1b[A\x1b[K"; }

# yazi cd on exit (even while writing commands)
yy () { yazi --cwd-file=$HOME/.yazi $@ < /dev/tty; cd "$(cat $HOME/.yazi)"; zle reset-prompt; echo -ne "\e[6 q"; }
zle -N yy          # creating `yy` keymap
bindkey '\eo' 'yy' # \eo = alt + o

source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
which fzf      >/dev/null 2>&1 && source <(fzf --zsh)
which eza      >/dev/null 2>&1 && alias ls="eza --all --icons --group-directories-first"
which starship >/dev/null 2>&1 && eval "$(starship init zsh)"
