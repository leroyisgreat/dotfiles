export EDITOR=nvim
export VISUAL=nvim
export LC_TYPE=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR=$(readlink -f "$HOME/.config/zsh/")
export ZSH_CUSTOM=$(readlink -f "$HOME/.config/zsh/custom/")
export HISTFILE=$(readlink -f "$HOME/.cache/zhistory")
export FZF_DEFAULT_OPTS='--height 20% --border' # decorates fzf search window with a border, and make the search box 20% high
