# vim:ft=zsh ts=2 sw=2 sts=2

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

#rvm_current() {
#  rvm current 2>/dev/null
#}

#rbenv_version() {
#  rbenv version 2>/dev/null | awk '{print $1}'
#}

PROMPT='
%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) ⌚ %{$fg_bold[red]%}%*%{$reset_color%}
$ '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#if [ -e ~/.rvm/bin/rvm-prompt ]; then
#  RPROMPT='%{$fg_bold[red]%}‹$(rvm_current)›%{$reset_color%}'
#else
#  if which rbenv &> /dev/null; then
#    RPROMPT='%{$fg_bold[red]%}$(rbenv_version)%{$reset_color%}'
#  fi
#fi

RPROMPT='$(check_last_exit_code)'
