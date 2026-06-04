vim: nospell:

    ls -l --time-style=+ /dev/disk/by-id/
    ls -l --time-style=+ /dev/disk/by-label/
    umount /dev/sdxx
    umount /mountpoint

# ioping
    ioping
    sudo ioping /dev/sda

# mount
    mount | grep /dev/sd

mount(8)

# non-optical
    blockid -h  # --help
    df -h /mnt/*
    df -h [<disk>]
    du -sh [<bigDirectory>]

## burn ISO image
1. (optional) `sudo wipefs [-a] /dev/sdx` wipes signatures
1. burn: `sudo pv image.iso -Yo /dev/sdx` with nice progress line, but doesn't report bytes
1. check: `dd if=/dev/sdg | cmp 'image.iso'` shouldn't see "dd: error reading..."

## permissions
    ---------- 	0000  no permissions
    ---x--x--x 	0111  execute
    --w--w--w- 	0222  write
    --wx-wx-wx 	0333  write & execute
    -r--r--r-- 	0444  read
    -r-xr-xr-x 	0555  read & execute
    -rw-rw-rw- 	0666  read & write
    -rwxrwxrwx 	0777  read, write, & execute

## fsck
`fsck` manages `lost+found` directory

### e2fsck
    sudo e2fsck -pv /dev/sdx1  # p = automatic, or just hit enter at each question

e2fsck(8)

## lsblk
    lsblk -f  # --fs - filesystems
    lsblk -h  # --help
    lsblk -l  # --list - removes tree structure glyphs
    lsblk -p  # --paths - of devices
    lsblk -V  # --version

lsblk(8)

## partitions
    sudo exfatlabel /dev/sdxx <new_label>
    sudo mkfs.exfat -n <label> /dev/sdxx
    sudo mkfs.ext4 -L <label> /dev/sdxx

### FAT
    sudo fatlabel /dev/sdi1 [<newLabel>]
    sudo mkfs.vfat -n 'label' -I /dev/sdxn

### gdisk
    sudo gdisk /dev/sdx
    sudo gdisk -l /dev/sda

gdisk(8)

### GParted
- can't set the volume-name
- GNU Parted User Manual
- parted(8)

#### interactive mode
    sudo parted /dev/sdg

##### commands
- `mklabel <label>` destroys existing partitions
- `p` (= `print`)
- `q` (= `quit`)

#### script mode
    sudo parted -l | grep sdg -B 1 -A 6  # --list
    sudo parted /dev/sda -s mklabel msdos mkpart primary 0% 100%  # also creates an MBR
    sudo parted /dev/sdg p  # quick print of device info

`-s` (`--script`) never prompts for user intervention

## Trash
    du -hs ~/.local/share/Trash
    rm -rf ~/.local/share/Trash

### trash-cli
    $OSL/bashrc-console-fm
    trash-empty  # lists before query
    trash-put

# optical
    cd-drive  # info
    growisofs -dvd-compat -speed=n -Z /dev/sr0=image.iso  # n x 1385 KB/s

## cdrtools - cdrecord
    cdrecord dev=/dev/sr0 -checkdrive  # Vendor_info etc
    cdrecord -v -sao dev=/dev/sr0 linux.iso

- `-sao` Session At Once, good for data
- `-v` verbose

## cdrtools - mkisofs
    mkisofs -V 'max32charVolName' -J -r -o <file.iso> <directory>

`-r` = `-rational-rock`

## tray
    eject  # opens tray
    eject -h
    eject -t  # closes tray (might fail)
    eject -T  # toggles tray

## Whipper
    whipper -h
    whipper cd rip
    whipper drive list
    ~/.config/whipper/whipper.conf

