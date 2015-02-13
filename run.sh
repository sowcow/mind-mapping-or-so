#!/bin/sh 

tmux new-session -d 'tech-graph'

tmux neww -n main 'guard'
tmux split-window -h "vim $GRAPH_SOURCE"
tmux neww -n preview "eog $GRAPH_OUTPUT"
tmux selectw -t 1

tmux attach-session -d 
