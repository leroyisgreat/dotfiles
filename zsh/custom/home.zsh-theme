#!/bin/zsh
# lgary@google.com

# Colors
local arro_cc=$([ $UID -eq 0 ] && echo "%{${fg_bold[red]}%}" || echo "%{${fg_bold[yellow]}%}")
local host_cc="%{${fg_bold[grey]}%}"
local locn_cc="%{${fg_bold[yellow]}%}"
local retn_cc="%{${fg_bold[red]}%}"
local rset_cc="%{$reset_color%}"
local merc_cc="%{${fg[green]}%}"
local merc_flag_cc="%{${fg_bold[green]}%}"

# Prompt substitutions are not quite powerful enough for what I want to do.
# Pipes for instance don't work in prompt substitutions and it's too much work
# to force perl/sed to take an input string.
function working-directory() {
  WD=$(pwd)
  WD=$(echo $WD | perl -lpe "s|$HOME|~|")
  WD=$(echo $WD | perl -lpe 's|\/google\/src\/cloud\/lgary\/(.*)\/google3/?|~\/\/|')
  WD=$(echo $WD | perl -lpe "s|java/com/google|j/c/g|")
  WD=$(echo $WD | perl -lpe "s|javatests/com/google|jt/c/g|")
  psvar[1]=$WD
}
add-zsh-hook precmd working-directory

local return_code="%(?..$retn_cc%? ↵$rset_cc)"
local directory="%v"

local LINE_1="[$host_cc%M$rset_cc] :: [$locn_cc$directory$rset_cc]$(git_prompt_info)"
local LINE_2="$arro_cc»$rset_cc "

PROMPT="$LINE_1
$LINE_2"

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

