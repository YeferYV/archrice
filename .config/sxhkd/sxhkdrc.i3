
###################################
###    mousebuttons_hotkeys     ###
##################################

# super/alt click
{XF86Finance,XF86Game}
  xdotool click {1,2}

#################################
###     xdo(tool)_hotkeys    ###
###############################

# # xdo click 1
# super+{Escape,@Escape}
#   xdo button_{press,release} -k 1

# # xdo click 3
# super+{Tab,@Tab}
#   xdo button_{press,release} -k 3

# # xdotool click 1
# super+{Escape,@Escape}
#   xdotool {mousedown 1,mouseup 1}

# # xdotool click 3
# super+{Tab,@Tab}
#   xdotool {mousedown 3,mouseup 3}

# # xdotool click 1 (buggy)
# ctrl + {t,@t}
#   xdotool key{down,up} super mousedown 1

# # xdotool click 3 (buggy)
# ctrl + {button1,@button1}
#   xdotool key{down,up} super mousedown 3


#####################################
###      arrow_hotkeys           ###
###################################

# # mod5 as super
# mod5+any
#   xdotool key Super_L+any

# # mod5 as super excluding hjkl
# mod5+{a-h,m-z,0-9}
#   xdotool key Super_L+{a-h,m-z,0-9}

# # mod5 generating vim keys
# mod5+@{i,j,k,l}
#   xdotool getactivewindow key {Up,Left,Down,Right}



# # To map mod5+key as Alt+key in alacritty otherwise arrowkeys
# mod5+@{i,j,k,l}
#   { d1=i;  d2=Up;    \
#   , d1=j;  d2=Left;  \
#   , d1=k;  d2=Down;  \
#   , d1=l;  d2=Right; \
#   } \
#   [[ "$(xprop -id "$(xdotool getactivewindow)")" == *"lacritty"* ]]&& \
#   xdotool getactivewindow key Alt_L+"$d1" || \
#   xdotool getactivewindow key --clearmodifiers "$d2"

# mod5+@i
#   [[ "$(xprop -id "$(xdotool getactivewindow)")" == *"lacritty"* ]]&& \
#   xdotool getactivewindow key alt+i || \
#   xdotool getactivewindow key --clearmodifiers Up

# mod5+@j
#   [[ "$(xprop -id "$(xdotool getactivewindow)")" == *"lacritty"* ]]&& \
#   xdotool getactivewindow key alt+j || \
#   xdotool getactivewindow key --clearmodifiers Left

# mod5+@k
#   [[ "$(xprop -id "$(xdotool getactivewindow)")" == *"lacritty"* ]]&& \
#   xdotool getactivewindow key alt+k || \
#   xdotool getactivewindow key --clearmodifiers Down

# mod5+@l
#   [[ "$(xprop -id "$(xdotool getactivewindow)")" == *"lacritty"* ]]&& \
#   xdotool getactivewindow key alt+l || \
#   xdotool getactivewindow key --clearmodifiers Right



########################################
###      window_hotkeys           ###
#######################################

#
# hover window
#

# hover move by 40/80
super + shift + {j,k,l,semicolon}
  hover {moveleft 80,movedown 40,moveup 40,moveright 80}

# hover move by 10
super + ctrl + {j,k,l,semicolon}
  hover move{left,down,up,right} 10

# hover left/right/down/up
super + {u,i,o,p}
  hover {left,down,up,right}

#
# move window
#

# move fixedscreen
super + n
  xdo move -x 200 -y 15; xdo resize -w 1151 -h 738

# move fullscreen
super + shift + n
  xdo move -x -1 -y -1; xdo resize -w 1366 -h 768

# move left
super + m
  xdo move -x 1 -y 1; xdo resize -w 681 -h 766

# move down
super + comma
  xdo move -x 1 -y 385; xdo resize -w 1364 -h 382

# move up
super + period
  xdo move -x 1 -y 1; xdo resize -w 1364 -h 382

# move right
super + slash
  xdo move -x 684 -y 1; xdo resize -w 681 -h 766

#
# resize window
#

# resize small/medium
super + {g,backslash}
  xdo resize {-w 681 -h 382,-w 800 -h 600}

# increase window
super + shift + backslash
  hover moveleft 50; hover moveup 25; xdo resize -w +100 -h +50

# decrease window
super + shift + g
  hover moveright 50; hover movedown 25; xdo resize -w -100 -h -50

#
# resize edge by +30
#

# resize left by 30
super + shift + u
  hover moveleft 30; xdo resize -w +30

# resize down/right by 30
super + shift + {i,p}
  xdo resize {-h,-w} +30

# resize up by 30
super + shift + o
  hover moveup 30; xdo resize -h +30

#
# resize edge by +10
#

# resize left by 10
super + ctrl + u
  hover moveleft 10; xdo resize -w +10

# resize down/right by 10
super + ctrl + {i,p}
  xdo resize {-h,-w} +10

# resize up by 10
super + ctrl + o
  hover moveup 10; xdo resize -h +10

#
# resize edge by -30
#

# resize right by -30
super + shift + m
  hover moveright 30 && xdo resize -w -30

# resize down by -30
super + shift + comma
  hover movedown 30 && xdo resize -h -30

# resize up/left by -30
super + shift + {period,slash}
  xdo resize {-h,-w} -30

#
# resize edge by -10
#

# resize right by -10
super + ctrl + m
  hover moveright 10 && xdo resize -w -10

# resize down by -10
super + ctrl + comma
  hover movedown 10 && xdo resize -h -10

# resize up/left by -10
super + ctrl + {period,slash}
  xdo resize {-h,-w} -10



########################################
###      alphabetic_hotkeys          ###
#######################################

# super volume
super + XF86Audio{Raise,Lower}Volume
  pactl set-sink-volume @DEFAULT_SINK@ {+,-}5% && $refresh_i3status

# volume
XF86Audio{Raise,Lower}Volume
  pactl set-sink-volume @DEFAULT_SINK@ {+,-}2% && $refresh_i3status

# (un)mute
XF86AudioMute
  pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status

# (un)mute mic
XF86AudioMicMute
  pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

# backlight
XF86MonBrightness{Down,Up}
  sudo light -{U,A} .11

# super backlight
super + XF86MonBrightness{Down,Up}
  sudo light -{U,A} 2

# dimmer
shift + XF86MonBrightness{Down,Up}
  xcalib {-co 75 -a,-c}

# dmenu(u)mount
super + {F11,F12}
  {dmenumount,dmenuumount}

# mpv vol-up
super + KP_Up
  [[ "$(playerctl -p mpv volume)" < 1 ]]&& playerctl --player=mpv volume 0.1+

# mpv vol-down
super + KP_Down
  playerctl --player=mpv volume 0.1-

# mpv next-toggle-prev
super + KP_{Right,Begin,Left}
  playerctl --player=mpv {next,play-pause,previous}

# mpc next-toggle-prev
KP_{Right,Begin,Left}
  mpc {next,toggle,prev}

# mpc next-toggle-prev
mod1 + {XF86AudioRaiseVolume,XF86AudioMute,XF86AudioLowerVolume}
  mpc {next,toggle,prev}

# screenshot fullscreen
Print
  maimpick fullscreen
  # maim ~/bgs/bgi/"$(date '+%y%m%d-%H%M-%S').png" && sleep 0.5s && notify-send "screenshot done"

# screenshot dmenu
shift + Print
  maimpick

# screenshot close
ctrl + Print
  killall notify-send

# redshift
mod1 + ctrl + {1,2,3,4,5}
  redshift {-x, -O 2222, -O 3333, -O 4444, -O 5555}

# classic terminals
mod1 + {_, shift, ctrl} + Return
  {urxvt, xterm, mlterm -b black -f green}

# alacritty
{mod5,super} + Return
  alacritty
  #alacritty && xdo move -x 200 -y 15; xdo resize -w 1151 -h 738

# ipython
super + shift + Return
  alacritty -e ipython

# cool-retro-term
super + ctrl + Return
  cool-retro-term

# compositor start
super + equal
  picom --glx-no-rebind-pixmap \
        --use-damage \
        --xrender-sync-fence \
        --backend glx \
        --experimental-backends \
        --transparent-clipping \
        # --refresh-rate 30

# compositor close
super + shift + equal
  killall picom

# focus last
mod{1,4} + apostrophe
  ~/.config/i3/i3-focus-last.py --switch
  #i3-msg-taskswitcher
  #[[ -z "$I3_MSG" ]]&& \{ export I3_MSG="no-empty" && i3-msg focus left ; \} || \{ export I3_MSG="" && i3-msg focus right ; \}
  #[[ I3_MSG == "" ]]&& i3-msg focus right && export I3_MSG="no-empty" || i3-msg focus left && export I3_MSG=""

# focus left
mod{1,4} + BackSpace
  i3-msg focus left

# focus right
mod{1,4} + XF86Shop
  i3-msg focus right

# XF86Shop
#   skippy-xd-runner --toggle

# skippy
mod4 + ~Tab
  skippy-xd-runner --activate --prev

# mod{1,4} + space
#   skippy-xd-runner --toggle

# mod{1,4} + BackSpace
#   skippy-xd-runner --toggle --prev

# super + j
#   skippy-xd-runner --next || (ps aux | grep skippy | awk 'NR==1 {print $2}' ) | xargs -I _ xdotool search --pid _ key j

# rotate layout
# super + {j,k}
#   ~/.config/i3/i3-tools/rotate_layout.py {0,1}

# lf user
super + r
  export LF_CD=true && alacritty

# lf root
super + shift + r
  sudo -E LF_CD=true LS_COLORS="" alacritty
  #sudo -E alacritty -e lf /root

# ranger
super + ctrl + r
  export RANGERCD=true && urxvt

# dmenu launcher
super + d
  dmenu_run

# dmenu launcher alias
super + shift + d
  source $HOME/.config/shell/aliasrc && \
  cmd=$(alias | cut -d'=' -f1 | cut -d\  -f2 | dmenu) && \
  alias | grep $(echo $cmd | cut -d\  -f1 ) | cut -d'=' -f2 | xargs -I __ alacritty -e bash -c "__ $(echo $cmd | awk '\{print $2\}' )"
  # alias | grep $cmd | cut -d'=' -f2 | xargs -I _ alacritty -e bash -c "_"
  # alias | grep $cmd | cut -d'=' -f2 | xargs -I _ bash -c "_"

# dmenu launcher tui
mod1 + ctrl + d
  alacritty -e $(dmenu_path | dmenu)

# bashtop htop gotop
super + {_, shift, ctrl} + z
  alacritty -e {bashtop, htop --tree, gotop}

# # lockscreen
# super + {_, shift} + x
#   {alacritty -e calcurse, slock}

# TextToSpeech
super + {_,shift,ctrl} + x
  {xclip -o | picospeaker, xsel -b | festival --tts, killall picospeaker festival}

# browser open
super + c
  google-chrome-stable
  # google-chrome-stable && xdo move -x 200 -y 15; xdo resize -w 1151 -h 738
  # google-chrome-stable --process-per-site

# browser close
super + shift + c
  killall chrome

# browser vim
super + ctrl + c
  vimb

# browser file
super + b
  pcmanfm

# browser media
super + shift + b
  urxvt -e ncmpcpp

