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
else
  cat ~/.config/tmux/tmux.help
fi
