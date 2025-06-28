vim: fdl=3:

    $OSL/nodes/terminal-ranger/JH.md

# JH notes

## 0 first ever install
- `ranger --copy-config=all` populates `~/.config/ranger`
    - `~/.config/ranger/scope.sh` is made executable

## 1 subsequent installs
- `$OSL/nodes/terminal-ranger`
    - rsynced in `$MSn/set/6-WSL-nodes.sh`
    - symlinked in
        - `$OSAB/nodes-set/jo-0.sh`
        - `$OSAB/nodes-set/root.sh`
    - `ll ~/.config/ranger`

## 2 commands.py
    $OSAB/nodes-terminal/ranger/commands.py

`$cGRs/d-unix/r-ranger-ranger/ranger/config/commands.py` latest, not yet Version'd

## 2 rc.conf
    $OSAB/nodes-terminal/ranger/rc.conf

### sources
1. `/usr/lib/python3.13/site-packages/ranger/config/rc.conf` = `/usr/share/doc/ranger/config/rc.conf`
2. `$cGRs/d-unix/r-ranger-ranger/ranger/config/rc.conf` latest, not yet Version'd

## 2 rifle.conf
    $OSAB/nodes-terminal/ranger/rifle.conf

### sources
1. `/usr/lib/python3.13/site-packages/ranger/config/rifle.conf` = `/usr/share/doc/ranger/config/rifle.conf`
2. `$cGRs/d-unix/r-ranger-ranger/ranger/config/rifle.conf` latest, not yet Version'd

## 2 scope.sh
    $OSAB/nodes-terminal/ranger/scope.sh

### sources
1. `/usr/lib/python3.13/site-packages/ranger/data/scope.sh` = `/usr/share/doc/ranger/config/scope.sh`
2. `$cGRs/d-unix/r-ranger-ranger/ranger/data/scope.sh` latest, not yet Version'd

