#!/usr/bin/env bash
# vim: fdl=1 tw=1:

# Joseph Harriott - https://harriott.github.io/ - Tue 17 Sep 2024

# on Arch need to  chmod u+x $OSL/tmux/copytk.sh
# run'd  from  $OSL/tmux/tmux.conf

#=> for tmux-copy-toolkit
# uname -r > $OSL/tmux/unamer  # checks
if [[ $(uname -r) =~ 'arch' ]]; then
    tmux set -g @copytk-copy-command 'tmux loadb - && tmux showb | copyq add -'
    # - only gets into X selection once pasted from  CopyQ
else
    tmux set -g @copytk-copy-command 'tmux loadb - && tmux showb | clip.exe'
    # - arrives in  Ditto
fi
# tmux show -g @copytk-copy-command

