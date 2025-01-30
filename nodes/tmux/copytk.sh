#!/usr/bin/env bash
# vim: fdl=1 tw=1:

# dim 05 janv 2025

# on Arch need to  chmod u+x $OSL/nodes/tmux/copytk.sh
# run'd  from  $OSL/nodes/tmux/tmux.conf

#=> for tmux-copy-toolkit
# uname -r > $OSL/tmux/unamer  # checks
ur=$(uname -r); if [[ $ur =~ 'arch' || $ur =~ 'zen' ]]; then
    tmux set -g @copytk-copy-command 'tmux loadb - && tmux showb | copyq add -'
    # - only gets into X selection once pasted from  CopyQ
else  # microsoft WSL
    tmux set -g @copytk-copy-command 'tmux loadb - && tmux showb | clip.exe'
    # - arrives in  Ditto
fi
# tmux show -g @copytk-copy-command

