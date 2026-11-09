#!/bin/bash
# vim: fdl=1 sw=2:

# cp $OSL/script_dir.sh $vimfiles/repos-packs/packs-colo/script_dir.sh
# bash $nvim/pack/colo/script_dir.sh

wdn=$(dirname "${BASH_SOURCE[0]}")  # get the working directory name of this script
echo $wdn
sdn=$(realpath "${wdn}")  # resolve to source (of symlink) directory name
echo $sdn

