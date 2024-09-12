# vim: tw=1:

# Joseph Harriott - https://harriott.github.io/ - jeu 12 sept 2024

# $OSL/tmux/copytk.sh  run  from  $OSL/tmux/tmux.conf

#=> for tmux-copy-toolkit
if [[ $(uname -r) =~ 'arch' ]]; then
    tmux set -g @copytk-copy-command 'tmux loadb - && tmux showb | copyq add -'
    # - only gets into X selection once pasted from  CopyQ
else
    tmux set -g @copytk-copy-command 'tmux loadb - && tmux showb | clip.exe'
    # - arrives in  Ditto
fi

