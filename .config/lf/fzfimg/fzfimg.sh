#!/usr/bin/env bash

# This is just an example how ueberzug can be used with fzf.
# Copyright (C) 2019  Nico Bäurer
# see https://github.com/seebye/ueberzug/blob/master/examples/fzfimg.sh

readonly BASH_BINARY="$(which bash)"
readonly REDRAW_COMMAND="toggle-preview+toggle-preview"
readonly REDRAW_KEY="µ"
declare -r -x DEFAULT_PREVIEW_POSITION="right"
declare -r -x UEBERZUG_FIFO="$(mktemp --dry-run --suffix "fzf-$$-ueberzug")"
declare -r -x PREVIEW_ID="preview"


function is_option_key [[ "${@}" =~ ^(\-.*|\+.*) ]]
function is_key_value [[ "${@}" == *=* ]]


function map_options {
    local -n options="${1}"
    local -n options_map="${2}"

    for ((i=0; i < ${#options[@]}; i++)); do
        local key="${options[$i]}" next_key="${options[$((i + 1))]:---}"
        local value=true
        is_option_key "${key}" || \
            continue
        if is_key_value "${key}"; then
            <<<"${key}" \
                IFS='=' read key value
        elif ! is_option_key "${next_key}"; then
            value="${next_key}"
        fi
        options_map["${key}"]="${value}"
    done
}


function parse_options {
    declare -g -a script_options=("${@}")
    declare -g -A mapped_options
    map_options script_options mapped_options
    declare -g -r -x PREVIEW_POSITION="${mapped_options[--preview-window]%%:[^:]*}"
}


function start_ueberzug {
    mkfifo "${UEBERZUG_FIFO}"
    <"${UEBERZUG_FIFO}" \
        ueberzug layer --parser bash --silent &
    # prevent EOF
    3>"${UEBERZUG_FIFO}" \
        exec
}


function finalise {
    3>&- \
        exec
    &>/dev/null \
        rm "${UEBERZUG_FIFO}"
    &>/dev/null \
        kill $(jobs -p)
}


function calculate_position {
    # TODO costs: creating processes > reading files
    #      so.. maybe we should store the terminal size in a temporary file
    #      on receiving SIGWINCH
    #      (in this case we will also need to use perl or something else
    #      as bash won't execute traps if a command is running)
    < <(</dev/tty stty size) \
        read TERMINAL_LINES TERMINAL_COLUMNS

    case "${PREVIEW_POSITION:-${DEFAULT_PREVIEW_POSITION}}" in
        left|up|top)
            X=1
            Y=1
            ;;
        right)
            X=$((TERMINAL_COLUMNS - COLUMNS - 2))
            Y=1
            ;;
        down|bottom)
            X=1
            Y=$((TERMINAL_LINES - LINES - 1))
            ;;
    esac
}


function draw_preview {
    calculate_position
    >"${UEBERZUG_FIFO}" declare -A -p cmd=( \
        [action]=add [identifier]="${PREVIEW_ID}" \
        [x]="${X}" [y]="${Y}" \
        [width]="${COLUMNS}" [height]="${LINES}" \
        [scaler]=forced_cover [scaling_position_x]=0.5 [scaling_position_y]=0.5 \
        [path]="${@}") \
        # add [synchronously_draw]=True if you want to see each change
}


function print_on_winch {
    # print "$@" to stdin on receiving SIGWINCH
    # use exec as we will only kill direct childs on exiting,
    # also the additional bash process isn't needed
    </dev/tty \
        exec perl -e '
            require "sys/ioctl.ph";
            while (1) {
                local $SIG{WINCH} = sub {
                    ioctl(STDIN, &TIOCSTI, $_) for split "", join " ", @ARGV;
                };
                sleep;
            }' \
            "${@}" &
}

# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#     trap finalise EXIT
#     parse_options "${@}"
#     # print the redraw key twice as there's a run condition we can't circumvent
#     # (we can't know the time fzf finished redrawing it's layout)
#     print_on_winch "${REDRAW_KEY}${REDRAW_KEY}"
#     start_ueberzug

#     export -f draw_preview calculate_position
#     SHELL="${BASH_BINARY}" \
#         fzf --preview "draw_preview {}" \
#             --preview-window "${DEFAULT_PREVIEW_POSITION}" \
#             --bind "${REDRAW_KEY}:${REDRAW_COMMAND}" \
#             "${@}"
# fi

# function clear_preview {
#     printf '{"action": "remove", "identifier": "preview"}\n' >"${UEBERZUG_FIFO}"
# }

function previewer {
  case "$1" in
      *.tar*) draw_preview && tar tf "$1";;
      *.zip) draw_preview && unzip -l "$1";;
      *.rar) draw_preview && unrar l "$1";;
      *.7z) draw_preview && 7z l "$1";;
      *.pdf) draw_preview && pdftotext "$1" -;;
      *.jpg) draw_preview "$1";;
      *.png) draw_preview "$1";;
      *json) draw_preview && bat -l json --style plain --color=always "$1" || echo "no bat :(" ;;
      # *) finalise && clear_preview && bat --style plain --color=always "$1" || echo "no bat :(" ;;
      *) draw_preview && bat --style plain --color=always "$1" || echo "no bat :(" ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    trap finalise EXIT
    parse_options "${@}"
    # print the redraw key twice as there's a run condition we can't circumvent
    # (we can't know the time fzf finished redrawing it's layout)
    print_on_winch "${REDRAW_KEY}${REDRAW_KEY}"
    start_ueberzug

    export -f previewer draw_preview calculate_position
    SHELL="${BASH_BINARY}" \
        fzf --preview "previewer {}" \
            --preview-window "${DEFAULT_PREVIEW_POSITION}" \
            --bind "${REDRAW_KEY}:${REDRAW_COMMAND}" \
            "${@}"
fi



