#!/bin/sh

set -e

if tmux has-session -t dot 2> /dev/null; then
  tmux attach -t dot
  exit
fi

tmux new-session -d -s dot -n vim -x $(tput cols) -y $(tput lines)

tmux send-keys -t dot:vim "nvim" Enter
tmux split-window -t dot:vim -h
tmux send-keys -t dot:vim.right "git status" Enter

tmux attach -t dot:vim.left
