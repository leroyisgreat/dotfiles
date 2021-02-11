# TODO(sez): doc

# Custom Helper Functions {{{
function include() {
  [[ -f "$1" ]] && source "$1"
}
# }}}

# Plugins {{{
# Autocomplete from History
include $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# Better command script highlighting
include $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Better command history search
include /usr/share/doc/fzf/examples/key-bindings.zsh
include /usr/share/doc/fzf/examples/completion.zsh
if [[ -f $HISTFILE ]]; then
  HISTSIZE=1000
  SAVEHIST=1000
  FZF_CTRL_R_OPTS="--history=$HISTFILE"
fi
#autoload -U history-pattern-search
autoload -U add-zsh-hook
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# }}}

# Keybindings {{{
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Key assignment
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
#[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
#[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
#[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

local WORDCHARS="${WORDCHARS:s#/#}"
bindkey '^[[1;5D'   backward-word         # <C-Left>
bindkey '^[[1;5C'   forward-word          # <C-Right>
bindkey ''        backward-delete-word  # <C-backspace>
bindkey '^[[3;5~'   delete-word           # <C-del>
# Broken!
#bindkey '<M-BS>'    backward-kill-line        # <M-backspace>
bindkey '^[^[[3~'   kill-line                 # <M-del>

# Vi switch from Insert to Normal (Command) mode
# Alt-Backspace is... broken or something... on my machine and maps to ^[,
#   just like escape. Don't know how to fix...
# I press Alt-Backspace (which worked in OhMyZsh) very often and it confuses
#   me when I suddenly dump into Vi CMD mode.
bindkey -vr '^['  # unbind <Esc>
bindkey -v '^[^[' # <M-Esc>

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

#zle -N history-pattern-search-backward history-pattern-search
#zle -N history-pattern-search-forward history-pattern-search

#bindkey '^_' history-incremental-pattern-search-backward
#bindkey '^[[1;5A' history-incremental-search-backward # <C-Up>
#bindkey '^[[1;5B' history-incremental-search-forward  # <C-Down>
# }}}

# Dirstack {{{
#
# cd -#n to list top $DIRSTACKSIZE recent directories
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  #[[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus
# }}}

# Aliases {{{
#
# Set of aliased commands
# For a full list of active aliases, run `alias`.
alias clr="clear"
alias e="nvim"
alias ls="ls --color"
alias oct="octave --no-gui"
alias sudo="sudo -E "
alias tm="tmux -f ~/.config/tmux/tmux.conf -2"
alias tma="tmux attach-session"
alias tmh="cat ~/.config/tmux/tmux.help"

# Mercurial
alias hga="hg add"
alias hgcc="hg citc"
alias hgcl-mod="hg amend"
alias hgcl-new="hg commit"
alias hgcl-up="hg uploadchain"
alias hgcl-rm="hg cls-drop -p"
alias hgs="hg status"
alias hgup="hg update"
alias hgx="hg xl"

# TaskWarrior
alias ta="task add"
alias tdel="task delete"
alias tdo="task done"
alias tl="task list"
alias tmod="task modify"
alias tst="task start"
alias tsyn="task sync"
# }}}

# Theming {{{
# Powerlevel9K and other theming config
#POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_CUSTOM_FIG='get_fig_prompt'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable custom_fig )
#POWERLEVEL9K_CUSTOM_FIG_BACKGROUND="237"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="237"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="009"
POWERLEVEL9K_DIR_HOME_BACKGROUND="237"
POWERLEVEL9K_DIR_HOME_FOREGROUND="006"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="237"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="004"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status vi_mode time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_FOLDER_MARKER=".citc"
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_folder_marker"
POWERLEVEL9K_STATUS_VERBOSE=false

include $ZSH_CUSTOM/plugins/powerlevel9k/powerlevel9k.zsh-theme
# }}}

include $XDG_CONFIG_HOME/work/workrc
include $ZDOTDIR/.zprofile # Surprise! Some LightDM versions ignore .profile :(
