[[ -z "$TMUX" ]] && export TERM=xterm || export TERM=tmux-256color
export EDITOR=nvim
export GTK_THEME=Numix
export LC_TYPE=en_US.UTF-8
export TERMINAL=rxvt-unicode
export VISUAL=nvim
export ZDOTDIR=$(readlink -m "$HOME/.config/zsh/")
export ZSH_CUSTOM=$(readlink -m "$HOME/.config/zsh/custom/")
