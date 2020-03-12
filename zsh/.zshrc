# OH-MY-ZSH CONFIGURATION -- {{{
#
# Boilerplate from installing OH-MY-ZSH
# I'm leaving these comments here in case I change my mind about them

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
[[ -f "$ZSH_CUSTOM/work.zsh-theme" ]] && ZSH_THEME="work" || ZSH_THEME="home"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

source $ZSH/oh-my-zsh.sh
# }}}

function include() {
  [[ -f "$1" ]] && source "$1"
}

# AUTOLOAD -- {{{
#
# ZSH functions to be loaded on source

  autoload -U history-pattern-search
  autoload -U add-zsh-hook

# }}}

# KEYBINDINGS -- {{{
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
    [[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
    [[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
    [[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
    [[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
    [[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
    [[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

    bindkey '<C-Left>'  backward-word
    bindkey '<C-Right>' forward-word
    bindkey ''        backward-delete-word  # <C-backspace>
    bindkey '5~'        delete-word           # <C-del>
    # TODO: Fix these, they don't work perhaps because of Terminator.
    #bindkey '<M-BS>'    backward-kill-line
    #bindkey '^[[3;3~'   kill-line
    #bindkey ''        kill-word

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

    #zle -N history-beginning-search-backward-end history-search-end
    zle -N history-pattern-search-backward history-pattern-search
    zle -N history-pattern-search-forward history-pattern-search
    bindkey '^_' history-incremental-pattern-search-backward
    bindkey '^[[1;5A' history-incremental-search-backward # <C-Up>
    bindkey '^[[1;5B' history-incremental-search-forward  # <C-Down>, i think
# }}}

# DIRSTACK -- {{{
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

# WORKING DIRECTORY -- {{{
# function to change the current Working Directory
function cwd() {
  dir=$(realpath $1)
  if [[ -z "$dir" ]]; then
    echo "ERROR: cannot set Working Directory to NULL"
  elif [[ ! -d "$dir" ]]; then
    echo "ERROR: "$1" not a directory"
  else
    echo $dir > $WDFILE
    cd $(cat $WDFILE)
  fi
}

# actually cd into the current Working Directory
WDFILE="$HOME/.cache/zsh/wd"
if [[ ! -f $WDFILE ]]; then
  echo $HOME > $WDFILE
else
  cd $(cat $WDFILE)
fi
# }}}

# ALIASES -- {{{
#
# Set of aliased commands
# For a full list of active aliases, run `alias`.
    alias clr="clear"
    alias e="nvim"
    alias ls="ls --color"
    alias oct="octave --no-gui"
    alias sudo="sudo -E "
    alias tm="tmux -f ~/.config/tmux/tmux.conf -2"
    alias tmh="cat ~/.config/tmux/tmux.help"

    # Mercurial
    alias hga="hg add"
    alias hgcc="hg citc"
    alias hgcl-mod="hg amend"
    alias hgcl-new="hg commit"
    alias hgcl-up="hg uploadchain"
    alias hgs="hg status"
    alias hgup="hg update"

    # TaskWarrior
    alias ta="task add"
    alias tdel="task delete"
    alias tdo="task done"
    alias tl="task list"
    alias tmod="task modify"
    alias tst="task start"
    alias tsyn="task sync"
# }}}

include $ZDOTDIR/.zprofile # Surprise! Some LightDM versions ignore .profile :(
include $XDG_CONFIG_HOME/workrc


# If we are not currenlty in a tmux session, either attach to an existing
# session or create a new one. This config assumes there will always be one
# local session for opening terminals on-device, and another that will always
# open if connection remotely.

if [[ -z "$TMUX" ]]; then
  if [ "$SSH_CONNECTION" != "" ]; then
    tm attach-session -t ssh_tmux || tm new-session -s ssh_tmux
  else
    tm attach-session -t lo_tmux || tm new-session -s lo_tmux
  fi
  cat ~/.config/tmux/tmux.help
fi

[[ -z "$TMUX" ]] && export TERM=xterm || export TERM=tmux-256color
