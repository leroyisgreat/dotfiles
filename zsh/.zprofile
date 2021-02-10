# If we are not currenlty in a tmux session, either attach to an existing
# session or create a new one. This config assumes there will always be one
# local session for opening terminals on-device, and another that will always
# open if connection remotely.

# TODO: come up with a clever way to case on being inside IntelliJ
# IDEA=$(pgrep -x idea.sh)

if [[ -z "$TMUX" ]]; then
  # In-IDE terminals
  if [[ -v CLION ]]; then
    tm attach-session -t clion_tmux || tm new-session -s clion_tmux
  elif [[ -v VSCODE ]]; then
    tm attach-session -t vscode_tmux || tm new-session -s vscode_tmux
  elif [[ -v IDEA ]]; then
    tm attach-session -t idea_tmux || tm new-session -s idea_tmux
  # Out-of-IDE terminals
  elif [ "$SSH_CONNECTION" != "" ]; then
    tm attach-session -t ssh_tmux || tm new-session -s ssh_tmux
  else
    tm attach-session -t lo_tmux || tm new-session -s lo_tmux
  fi
else
  cat ~/.config/tmux/tmux.help
fi
