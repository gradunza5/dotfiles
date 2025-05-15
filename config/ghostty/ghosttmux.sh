#!/bin/bash

SESSION_NAME="ghostty"

if command -v "tmuxinator" > /dev/null; then 

    tmuxinator main

else

    # Check if the session already exists
    tmux has-session -t $SESSION_NAME 2>/dev/null

    if [ $? -eq 0 ]; then
        # If the session exists, reattach to it
        tmux attach-session -t $SESSION_NAME
    else
        # If the session doesn't exist, start a new one
        tmux new-session -s $SESSION_NAME -d
        tmux attach-session -t $SESSION_NAME

        tmux split-pane -h -t $SESSION_NAME 'NVIM_APPNAME=nvim-renew nvim'
    fi
fi
