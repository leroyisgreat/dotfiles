[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
#unset -v HOME
#
#if shopt -q login_shell; then
#    [[ -f ~/.bashrc ]] && source ~/.bashrc
#    [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx
#else
#    exit 1
#fi
