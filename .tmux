#!/bin/sh

set -e

if tmux -f ~/.tmux.conf has-session -t dot 2> /dev/null; then
  tmux -f ~/.tmux.conf attach -t dot
  exit
fi

tmux -f ~/.tmux.conf new-session -d -s dot -n vim -x $(tput cols) -y $(tput lines)

tmux -f ~/.tmux.conf send-keys -t dot:vim "nvim" Enter
tmux -f ~/.tmux.conf split-window -t dot:vim -h
tmux -f ~/.tmux.conf send-keys -t dot:vim.right "git status" Enter

tmux -f ~/.tmux.conf attach -t dot:vim.left
