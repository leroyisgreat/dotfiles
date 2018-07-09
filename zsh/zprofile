if [[ -z "$TMUX" ]]; then
  if [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
  fi
else
  cat ~/.tm_help
fi
