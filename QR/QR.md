vim: nospell:

    $OSL/QR; m4ps 0 1

commands here are generic, except for those under the Ubuntu heading, see also `$OSAB/QR`

    $cITcr/unix-like/usr_lib_X11_rgb.txt  # colours
    $misc/unix_like/linux
    dotnet --list-runtimes
    dotnet --list-sdks
    info info
    rainbow -h | mo  # nicoulaj/rainbow
    wcsf=$(wc -l <samplefile>); echo $wcsf

Pipe Viewer

# audio
    kew -h
    soxi <audioFile>  # info, including duration

## ALSA
    alsamixer -V all
    speaker-test -c 2
    sudo alsactl store

## cmus
    :Man cmus
    cmus --help
    cmus --plugins
    cmus_notify -h

- C* Music Player
- sends low urgency notifications

### commands
    7        settings

    ^c       echo Type :quit<enter> to exit cmus.
    ^l       refresh
    space    win-toggle => mark
    e        win-add-q

    P        win-mv-before
    p        win-mv-after

    b        player-next
    x        player-play (from start)
    v        player-stop
    z        player-prev

    h, left  seek -5s
    l, right seek +5s
    ,        seek -1m
    .        seek +1m

    ^r       toggle repeat_current
    C        toggle continue
    r        toggle repeat

    -        vol -10%
    + =      vol +10%

### media
- can play: `mka`, `ogg`, `opus`
- can't play: `m4a`, `oma`, `omv`, `rmj`, `wma`

## convert
    f=sox.flac; ffi $f -c:a libvorbis -aq 4 ${f%.*}.ogg
    for f in *.flac; do ffi "$f" -c:a libvorbis -aq 4 "${f%.*}.ogg" ; done
    for f in *.oma; do ffi "$f" -c:a libvorbis "${f%.*}.ogg" ; done  # at default VBR quality 3
    for f in *.rmj; do ffi "$f" -c:a libvorbis -aq 4 "${f%.*}.ogg" ; done
    for f in *.wma; do ffi "$f" -c:a libvorbis -aq 4 "${f%.*}.ogg" ; done
    for f in *.wav; do ffi "$f" -c:a libvorbis -aq 4 "${f%.*}.ogg"; rm "$f"; done
    for f in *; do ffi "$f" -b:a 128K -vn "${f%.*}.mp3" ; done

### m4a
    for f in *.m4a; do ffi "$f" -c:a libvorbis -aq 4 "${f%.*}.ogg" ; done

VBR quality 4 is closer to the original size

## gst123
    gst123 -h  # --help
    gst123 -Z .  # play random audio files recursively forever

### control
    left/right -> seek 10 seconds
    down/up -> seek 1 minute
    PgDn/Up -> seek 10 minute
    space -> toggle pause
    +/- -> change volume by 10%
    m -> toggle mute
    n -> next file
    q -> quit
    ? -> help

## MPD
    mpd
    mpd --kill
    pgrep mpd

- can play: `m4a`, `mka`, `ogg`, `opus`, `wma`
- Music Player Daemon

### vimpc - normal mode
- `-`/`+` decrease/increase volume
- `ZZ` quits completely
- `space` start/stop
- `backspace`/`s` stop playlist

#### song
- `f`/`F` scroll to current song
- `e` toggle info
- `E` toggle repeat
- `I` restart the song
- `R` toggle random
- `S` toggle single
- `<`/`>` previous/next song

## playerctl
    playerctl  # quick guide
    playerctl -l  # (--list-all) available players - firefox, mpd
    playerctl metadata  # from the current player
    playerctl pause
    playerctl play
    playerctl play-pause  # toggles
    playerctl status
    playerctl stop

## PulseAudio
    pactl -h
    pactl info
    pactl list short
    pgrep -af pulseaudio
    pulseaudio -k  # --kill
    pulsemixer

### libpulse
    pacat --list-file-formats
    pactl list sinks short
    pactl list sources short
    pactl set-sink-mute 0 toggle
    pactl set-sink-volume 0 60%  # master volume to reasonable level
    parecord -d 0 parecord.flac
    parecord -d 1 parecord.flac
    parecord -d 16 parecord.flac
    pavucontrol

# bc
    bc -q
    bc <<< 'scale=2; 3 * 2.004 / 1'  # the final redundant division fixes  scale

- "an arbitrary precision calculator language"
- command: `scale=n  => results to n decimal places`

## limitations
- `<circumflex>i` = to power of integer i
- can be inaccurate

# CopyQ
    copyq tab  # lists the tab headings
    copyq tab clipboard read 0  # pastes the first one
    pkill copyq; copyq &

## internal commands
- `Ctrl+Home` = `move_to_top`
- `Ctrl+p` = `Preferences`

# datetime
    strftime

## cal
    cal           " this month
    cal (command)
    cal -3        " last month, this, next
    cal -n 18     " all 18 months from now
    cal -w[y]     " week numbers
    cal -y        " year

## date
    date '+%F %a %H:%M'
    date +%j-%H%M
    date +%s; sleep 1; date +%s
    date +%Y%m%d
    date +%y%m%d-%H%M
    date +%y%m%d-%H%M%S
    date +%Y-%m-%d -d 'now -1 year 1 day'
    date -d @<unixTimeToConvert>
    date -R
    date -r <fileToGetDateOf>

- `%j` day of year (001..366)
- `date -d @$((1767468248734330/1000000))` microseconds, as in sqlite3's `.dump`

# documenting
    aspell dicts

## Foliate
- `ctrl-q` = quit
- mouse to bottom for scrollbar
- mouse to top for adjustments

## PDFs
- `Firefox` shows `Document Outline`
- Outline = the hyperref bookmarks that correspond to headings of a LaTeX document

### C5 printing
- `Firefox` can't figure it's portrait
- `LibreOffice Writer` gets it right
- Ubuntu's `qpdfview` gets it almost right

### qpdfview
    F6 = View > Docks > Outline (such as the headings of a LaTeX document)
    F8 = Thumnails

### sizes
    pdfinfo <a_pdf_file>  # A5 = 420x595. See GSview for more sizes.

1 PostScript point = 0.3528 mm

### XpdfReader
    [-f <firstPage>] [-l <lastPage>]
    pdftoppm -png -r 300 <pdf> <basename_for_png_sequence>
    pdftoppm -jpeg -r 300 <pdf> <basename_for_jpeg_sequence>

### Zathura
    zathura --mode=fullscreen a.pdf &

zathura man page

#### commands
    :info

- `<tab>` toggles Outline view
- `f11` toggle fullscreen
- `r` rotate by 90 degrees
- `R` reload document

##### resizing
- `+/-/=` zoom in/out/original
- `a` best-fit mode
- `s` width mode

# Emacs
    ctrl-x > ctrl-c => quit
    emacs -mm &  # maximized
    emacs -nw  # in terminal
    emacs -nw --debug-init

## view movements
    alt-v => scroll up
    ctrl-l => centre text in view
    ctrl-v => scroll down

# encoding
    delta <file1> <file2>
    echo 'bGludXhoaW50LmNvbQo=' | base64 --decode
    echo 'linuxhint.com' | base64
    git diff <file1> <file2>
    ~\.pyenv

Make (software)

## Git
    :Man git
    fd -tf -u index.lock -x rm
    git extras --version
    gitui

### Git - configurations
    $ fd -HI -tf ^config$ | xargs rg -l 'remote = gh'  # ripgrep
    $ find . -wholename '*.git'
    $ find . -wholename '*.git/config' > gitconfig-all.txt
    $ find . -wholename '*.gitignore' > gitignore-all.txt
    $ find . -wholename '*.git/config' | wc -l
    $ grep -rl --include "config" harriott . > gitconfig-harriott.txt

#### gitconfig
    r ~/.ssh

`$machBld/jo/gitconfig` inludes `$misc/CP/gitconfig`

## Ruby - rbenv
    rbenv
    rbenv global
    rbenv global 4.0.5
    rbenv help
    rbenv help global
    rbenv help versions
    rbenv install 4  # installs latest major version
    rbenv uninstall 4.0.5

## TeX
    pdfjam --help

### TeX Live
    /etc/texmf/web2c/fmtutil.cnf
    sudo tlmgr -gui
    sudo tlmgr update -all -dry-run

#### tests
    pdflatex sample2e.tex
    tex --version

#### texmf.cnf
    $ABjo/texmf.cnf

defines variables for `kpathsea`

## webish - PHP
    php-fpm -h
    php-fpm -v

# Fcitx Clipboard
- `fcitx5-configtool & > Addons > Clipboard > Configure > Trigger Key` defaults to `ctrl+;`
- works in `Firefox`, `WezTerm`

# fcron
    fcrontab -l
    sudo systemctl restart fcron.service
    systemctl status fcron.service

# file contents
    diff <file1> <file2>
    enca -l surfaces
    tac --help
    shuf
    sk --ansi -i -c 'rg --color=always --line-number "{}"'
    sort <file> | uniq -d  # prints only duplicate lines
    wc -l <file>  # counts lines
    xargs < <file_to_return_as_one_line>

- sharkdp/bat
- `uniq -c` (`--count`) prefix lines by counts

## awk
    awk '{print $0}' # prints all columns - doesn't work with  OFS
    awk '{print $1}' ORS='\t' <file_with_column_to_print_tsv>
    awk -f script.awk input.txt
    awk -F, '{print sprintf("%02d",NR),NF}' file_to_check_field_counts.csv
    awk -h  # --help
    awk -i inplace -F, '{print $3,$2,$1}' OFS='┊' toReorder.csv
    awk -V  # --version
    awk 1 ORS=' ' <file_to_return_as_one_line>
    v=variable; awk -v var="$v" 'BEGIN {print var}'
    za $cIThul/gawk.pdf
    {print $1,sprintf("%08d",$2)} # 2nd field is 0-padded to length 8

- `'{if($1==2){if(gsub(/┊/,"┊")<1){$3=$3"┊"}}}{print $1,$2,$3}'` adds a `┊` if there aren't 2
- `'{if($1~/^$/)print $0}` # print row if nothing in column 1
- `-F` = `--field-separator`
- `-i` = `--include`
- GNU Awk
- `gsub(/old/,"new"[,target])` returns the number of substitutions made
- no backreferences
- `substr($4,2,length($4)-2)` removes outer characters

### built-in variables
- `FILENAME` name of the current input-file
- `FNR` input record number in the current input file
- `FS` input field separator character (default = any space and tab characters)
- `NR` number of input records seen so far
- `NF` number of fields in an input record
- `OFMT` format for numeric output (default = `%.6g`)
- `OFS` output field separator (default = <space>)
- `ORS` output record separator (default = <newline>)
- `RS` record separator (default = newline)

### octal codes
- `\047` = '
- `\057` = /

### input field separation
- `F,`
- `F'\t'`

#### csv
- `F,`
- `-vFPAT='([^,]*)|("[^"]+")'` f1,"f2a, f2b",f3

### numbers
    awk -F, '{ if ( $1+0 > 2025 ) print $1 }" <first_column_could_be_year.csv> # only those > 2025
    awk '{ print ($1 % 2 == 0) ? "even" : "odd" }' numbers.txt
    awk '{printf("%06.2f\n", $1)}' <<< -9.111111
    o -e "a 1\nb 2\nc 3" | awk '{s+=$2;}END{print s;}' # sum of column 2
    o -e "a 1\nb 2\nc 3" | awk '{print $2}' ORS=' ' | sed 's/ $/\n/'

`$1 ~ /^[0-9]+$/` checks if first field is an integer

### select lines
    awk 'FNR==2 {print}' <file>  # line 2
    awk '{if(NR>=2){print}}' <file>  # lines from 2
    awk -i inplace 'FNR==1 {print tolower($0)}' $1  # only line 1

## file
    fd -Itf -x file

Vim fileencoding utf8 reported as ASCII

## grepping
    grep -c '^PatternAtStartOfLine' <file>  # returns count of occurances
    grep -P '[\p{Devanagari}]' **/*  # finds Devanagari characters
    if grep -q '‡' <file_that_may_contain_‡>; then o ‡; fi

- `-A num` (`--after-context=num`)
- `-i` (`--ignore-case`)
- `-E` (`--extended-regexp`)
- `-F` (interpret patterns as `--fixed-strings`, not regex)
- `-o` (`--only-matching`)
- `-q` (`--quiet`, `--silent`) no standard out
- GNU Grep Manual

### igrep
    ig -h  # --help

#### commands
- `?` toggle help
- `f5` toggle search pattern
- `<enter>` edit the file on the line
- `<esc>`/`q` quit

##### context view
- `s`  toggle horizontal
- `v`  toggle vertical
- `-`/`+` decrease/increase size

## non-printing characters
    cat -A <file> # --show-all  non-printing stuff

### CRLF line terminators
    fd -tf -e dw -x sed -i 's/\r$//'
    grep -rIl -m 1 $'\r' <directory_to_check_for_CRLFs>
    printf "line terminated with CRLF\r\n" > crlf.txt

### dos2unix
    dos2unix -i *
    fd -tf -x dos2unix -ic | wc -l  # count files that would be converted

- `-c` print only the files that would be converted
- `-e` (=`--add-eol`) not on `WSL Ubuntu`
- `-i` (=`--info`) no conversion is done
- CRLF -> LF

## sed
    $cITcr/unix-like/sed/learnsed.sed
    $cIThul/sed
    :Man sed
    echo "blia blib bou blf" | sed -E 's/bl(ia|f)//g'
    sed --version
    sed 5q <file> prints first 5 lines
    sed G <file>  # double-spaced

- `-E`/`-r` (`--regexp-extended`) extended regular expressions
- `[0-9]` = `[[:digit:]]`
- GNU sed
- linewise, so don't try to replace newline
- stream editor

### bracket expressions
    echo ' she' | sed 's/[^[:space:]]/!/'
    echo '20230516' | sed -r 's/(20[0-9][0-9])([0-9][0-9])/\1-\2-/' # 2023-05-16
    echo 'gray, grey' | sed 's/gr[ae]y/blue/g'

#### character classes
- `[:alpha:]`=`[:lower:]`+`[:upper:]`=`[A-Za-z]`
- `[:alnum:]` alphanumerics (`[:alpha:]`+`[:digit:]` = `[0-9A-Za-z]`)
- `[:digit:]`: could `echo '12' | sed 's/[[:digit:]]//'`, but `echo '12' | sed 's/[0-9]//'` is more compact

### make changes
    echo -e '1\n2\n3' | sed $'s/.*/\t&/g'  # inserting tabs
    echo "don't forget that" | sed 's/\x27/\"/'
    echo "é" | sed 's/é/e/'
    echo "Oo" | sed 's/o/a/Ig'  # case insensitive
    echo "THIS is a test!" | sed 's/.*/\L&/; s/[a-z]*/\u&/g'  # title case
    sed -i $'s/\t/tab_gone/g' <file_with_tabs>
    sed -i '/<regex>/!d' <filetoreduce>  # removes lines that don't match
    sed -i '/match/,+2d' <file>  # removes matched line and 2 after
    sed -i '0~2 a\\' <fileToAddBlankLineAfterEach2ndLine>
    sed -e '0,/first/ s/first/this_first_only/' -i <file_to_make_just_one_single_change_to>

- `&` whole matched pattern
- replace a string in multiple files

#### delete lines
    sed -i '1,4d' <file>
    sed -i '2d' <file>  # deletes 2nd line
    sed '1{/~~stoggle_buttons~~/d;}' <DokuWiki_file>

##### last line
    sed -i '$d' <file_to_lose_last_line>
    sed -i '${/unwanted/d;}' <file_to_possibly_remove_last_line_from>

#### prepend
    sed '1i\nNewFirstLineText' <fileToPrependTo>
    sed -i '1s/^/vim: ft=<filetype>:\n\n/' <file_to_prepend_vim_modeline>

### show file contents
    sed '/pattern/q' <file>  # cat's  <file>  until  pattern
    sed 5q <file> print first 5 lines
    sed -e '' <file>  # mimics cat
    sed -n '/<regex>/p' <file>  # prints only the matching lines
    sed -n '2,$p' <file>  # prints from the 2nd line

# file manage
    $cGRs/unix/ranger-ranger
    fuseiso <ISO_image> <mountDirectory>
    mkdir -p  # --parents = make parent directories as needed (no error if existing)
    sudo chown -R <user>:<group> <dir> # --recursive

- `$OSL/nodes/bashrc-console-fm` `nnn`
- `chmod 600 file` - owner can read and write
- `chmod 644 file` - owner can change it, everyone else can read it
- `chmod 660 file` - owner can read and write, and group members
- `chmod 666 file` - all can read and write
- `chmod 700 file` - owner can read, write and execute
- `chmod 711 file` - `drwx--x--x` group & others can get into the directory
- `chmod 755 file` - `-rwxr-xr-x` group & others can read
- `chmod 775 file` - `-rwxrwxr-x` group can write
- `chmod 777 file` - all can read, write and execute
- FILE(1)
- `fsearch`: `Ctrl+p` = Preferences
- install(1)
- `ls **/*` and no variations of that!
- `lsd`: `-I` (`--ignore-glob`)

## compressed
    :Man gzip

`gzip -r *` will recursively convert all files to `*.gz`

### 7-Zip
    7z -h  # -mhe (metadata encryption) not there
    7z.exe a -mhe -p<pw> dir.zip dir
    for z in *.zip; do 7z x $z; done

#### compression level
- `-mx0` less than no option
- `-mx1` seems optimal

### tar
    :Man tar
    tar -xzf archive.tar.gz [-C <(already_existing)_target_directory>]

- `--gunzip` (or `--ungzip`)
- `-v` (`--verbose`)
- `-z` (`--gzip`)

### zip
    :Man zip
    zip -qr dir.zip dir

- `-q` (`--quiet`)
- `-r` (`--recurse-paths`)

## cp
    cp -r <sourceDir> .

`-L`, `--dereference`

## digests
    md5sum -c <md5file>
    rhash -a --bsd <somefile>
    rhash -h  # --help
    rhash -M  # --md5
    rhash --list-hashes => list names of all supported hashes
    rhash --sha256 <file>
    rhash --sha256 *  # to see if files are identical
    rhash --sha512 <file>
    shasum -a 256 <file>

## Dolphin
    F4        -> Konsole  attached below
    Shift+F4  -> Konsole  in a new window

## fd
    fd -tl -HL -X rm  # removes dead links
    fd -tf -e dw -x cat | wc -w  # recursively count all words in dokuwiki files
    fd -tf stderr.txt -X rm

## find
    find $PWD -name <file>  # gets full path
    find -cmin 1  # files whos status changed in last minute
    find -exec stat -c '%U %G %n' {} +
    find -regex ".*a.*\|.*b.*"
    find . ! -wholename '*/.git/*' -printf %TY%Tm%Td-%TH:%TM:%.2TS\ %p\\n | sort  # excluding contents of  .git
    find . -maxdepth 1 -mindepth 1 -type f -name "*"  # those in working directory
    find . -name "*" -type f ! -path '*/.git/*'
    find . -name '*.txt' ! -name 'build*'  # excluding build*
    find . -newer oldFile
    find . -path '*exclude_path*' -prune -o -name 'partial_filename*' -print
    find . -type f -exec du -h {} + | sort -hr > descendingSizes.txt
    find . -xtype l -delete  # quickly removes broken symlinks

find(1)

## GIO
    gio help
    gio version

(Gnome Input/Output)

## investigations
    diff --no-dereference -qr dir1 dir2
    find $Drpbx | awk '{print length,$0}' | sort -n  # path lengths
    find . -name '.?*'  #  recursively list hidden files
    for n in *; do find "$n" | echo "$n"; done
    stat -c '%a %n' *  # show octal permissions

### by extension
    find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -rn > ext_counts
    find . -type f -name "*.*" | grep -o -E "\.[^\.]+$" | grep -o -E "[[:alpha:]]{2,16}" | awk '{print tolower($0)}' | sort -u
    find . -type f | grep -oE '\.(\w+)$' | sort -u
    find . -type f | sed -rn 's|.*/[^/]+\.([^/.]+)$|\1|p' | sort -u  # extensions list (no hiddens)
    for f in **/*.*; do echo "${f##*.}"; done | sort -u

### counts
    echo `find . -type d | wc -l`-1 | bc  # counts all subdirectories
    find . -name "*" -type f -path '*/.git/*' | wc
    for d in $(fd -d1 -td); do find "$d" | o "$(wc -l) : $d"; done  # files in directories
    isutf8 **/* | wc -l  # non UTF-8 files (fails when too many)

#### including hidden
    find . | wc -l  # very fast in $Drpbx
    find . -type f | sed 's/\.\/.*\.//' | sort | uniq -c  # by extension

### ls
    dircolors  # LS_COLORS=...
    dircolors --help
    dircolors --version
    dircolors -p  # --print-database
    ls -l  # show permissions, owners, exact sizes, and date-time

- `-d` (= `--directory`)
- `-A` (= `--almost-all`) exclude `.` and `..`
- `-R` (= `--recursive`) delve into subdirectory contents
- `-t` sort, newest first
- ls(1)

### mlocate
    locate .asc | grep '\.asc$'
    locate .dat | grep '/\.dat'
    locate -c <target>  # --count
    locate -h

### most recent
    find -L . -type f -printf '%TY-%Tm-%Td-%TH:%TM:%.2TS %p\n' | sort -k1,1r | head -5
    ls -Alt | head -n9

### sizes
    diskonaut -h
    dust -x /  # graphical size representation of root, not descending into mounts

#### listed
    ls -1Rhs | sed -e "s/^ *//" | grep "^[0-9]" | sort -hr | head -n50  # neat recursive list of largest

##### du
    du -ah . | grep -v "/$" | sort -rh | head -44  # recursive list of largest 44 files
    du -h --max-depth=0 <directory>
    du -h --max-depth=1  # for a quick list of folder sizes
    du -hs  # size of current directory
    du -hs <glob>
    du -s **/.git

- `-c` = grand `--total` of list
- `-h` = `--human-readable`
- `-s` - `--summarize`, don't recurse
- `-x` = `--one-file-system`
- du(1)

#### ncdu
    ncdu [<directory>]

##### commands
- `?` -> help
- `g` -> rotate through % graph none
- `n` -> order by name
- `s` -> order by size

### symlinks
    [[ -L $s ]] && echo 'symlink exists'
    find . -type l -ls  # recursively list all symlinks with their references
    readlink $s  # returns referenced node

### tree
    tree -a  # include hidden
    tree -d [-L n]  # directories only, maximum Level (= depth) n
    tree -f  # print path
    tree -fi  # print path without indentation lines

- `-l` follows symbolic links, but still showing `-> <real_path>`
- tree(1)

## ln
- `-s` (`--symbolic`) not hard
- ln(1)

## privileges
    directory user group other
    d         rwx  rwx   rwx

    permission binary octal
    r          100    4
    w          010    2
    x          001    1

    rwx 7
    rw- 6
    r-x 5
    r-- 4
    --x 1
    --- 0

## rm
rm(1)

### with Pipe Viewer
1. `find <directory> | wc -l  # gets the <filecount>`
2. `sudo rm -rv <directory> | pv -l -s <filecount> > /dev/null  # shows progress for rm`

## rsnapshot
    ncdu --exclude *rsnapshot
    rsnapshot configtest
    sudo rsnapshot du  # can takes many hours...
    systemctl list-unit-files | grep rsnapshot

> /usr/bin/rsnapshot sync: completed successfully

## rsync
    rsync -h  # --help
    rsync -irtv --delete $TeNo/ $Drpbx/Play1/TextNotes 2>&1 | tee $Drpbx/Play1/TextNotes_rsync.log
    rsync -inrtv --delete --progress path1/large_file_dir1/ path2/large_file_dir2

### options
    --exclude=PATTERN

- `-h` (`--help`)
- `-i` (`--itemize-changes`)
- `-l` (`--links`) copy symlinks as symlinks (so no "skipping non-regular file" if the symlink's reference exists)
- `-L` (`--copy-links`) transform symlink into referent file/dir
- `-n` (`--dry-run`)
- `-r` (`--recursive`)
- `-t` (`--times`) keep modification times
- `-v` (`--verbose`)
- `-V` (`--version`)

#### for system files
- `-A` (`--acls`) keep ACLs, implies `-p`
- `-a` (`--archive` = `-Dgloprt`, no `-A`, `-H`, `-X`) handles symlinks with no reference
    - `-D` (`--devices --specials`)
        - `--devices` keep device files
        - `--specials` keep special files
    - `-g` (`--group`)
    - `-o` (`--owner`) if super-user
    - `-p` (`--perms`) keep permissions
- `-H` (`--hard-links`)
- `-X` (`--xattrs`) keep extended attributes

### output info
    YXcstpoguax  path/to/file
    |||||||||||
    ||||||||||╰- x: The extended attribute information changed
    |||||||||╰-- a: The ACL information changed
    ||||||||╰--- u: The u slot is reserved for future use
    |||||||╰---- g: Group is different
    ||||||╰----- o: Owner is different
    |||||╰------ p: Permission are different
    ||||╰------- t: Modification time is different
    |||╰-------- s: Size is different
    ||╰--------- c: Different checksum (for regular files), or
    ||              changed value (for symlinks, devices, and special files)
    |╰---------- the file type:
    |            f: for a file,
    |            d: for a directory,
    |            L: for a symlink,
    |            D: for a device,
    |            S: for a special file (e.g. named sockets and fifos)
    ╰----------- the type of update being done::
                 <: file is being transferred to the remote host (sent)
                 >: file is being transferred to the local host (received)
                 c: local change/creation for the item, such as:
                    - the creation of a directory
                    - the changing of a symlink,
                    - etc.
                 h: the item is a hard link to another item (requires --hard-links).
                 .: the item is not being updated (though it might have
                    attributes that are being modified)
                 *: means that the rest of the itemized-output area contains
                    a message (e.g. "deleting")

## touch
- `-c` (`--no-create`)
- change file timestamps

## zoxide
    declare -f z
    zoxide -h

# Flatpak
    du -sh /var/lib/flatpak/.removed
    flatpak -h  # --help
    flatpak --installations  # prints paths
    flatpak config -h
    flatpak config --list
    flatpak info -h
    flatpak list
    flatpak remotes  # list added repositories
    flatpak history
    flatpak install ... # recovers from network outages
    flatpak uninstall <pkg>
    sudo flatpak list
    sudo flatpak repair  # Erasing .removed
    sudo flatpak update

# fortune
    fortune -a
    fortune -f

# get at root on tty2
    Ctrl+Alt+F2 > root + pw

# GNU Privacy Guard
    echo "encrypt me this" | gpg -ase -r jharr
    gpg --full-gen-key

fingerprint: `xxxx xxxx xxxx xxxx xxxx  xxxx xxxx xxxx xxxx xxxx`

## keybox
    gpg --delete-key <anID>
    gpg --import my_private_key.asc
    gpg --import my_public_key.asc
    gpg -ao private.asc --export-secret-keys jh
    kbxutil ~/.gnupg/pubring.kbx | moar  # for a more detailed exploration

# hw
    lsusb
    solaar show
    sudo chmod 777 /run/media/jo/TOSHIBA
    sudo chmod 644 $Obc/autostart/urxvtl.sh
    uname -m  # reports eg  x86_64
    xbacklight -set 50
    :e /run/media/jo

## battery
    acpi -h
    batstat

## CPU
    cpupower frequency-info
    sudo cpupower frequency-set -u 3400Mhz
    sudo turbostat --interval 0.1 --num_iterations 1
    sudo turbostat --interval 2 --quiet

## graphics
    cat /sys/class/graphics/*/virtual_size
    xdpyinfo | grep dimensions: | awk '{print $2}' # combined screen resolution
    xrandr  # all available monitor resolutions
    xrandr | grep ' connected'
    xvidtune -show  # Modeline-style information

### fbset
    fbset -h
    sudo fbset

framebuffer device settings

### query the card specs
    echo $(xrandr -q | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1) $(xrandr -q | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)  # screen size
    GPU=$(lspci | grep VGA | cut -d ":" -f3);RAM=$(cardid=$(lspci | grep VGA |cut -d " " -f1);lspci -v -s $cardid | grep " prefetchable"| cut -d "=" -f2);echo $GPU $RAM
    lspci | grep -e VGA -e 3D  # gets just the graphics card name

## keyboard
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'  # scancodes

### for XF86 symbols
    xmodmap -pke | grep Audio
    xmodmap -pke | grep Brightness

## printing - CUPS
    lnav /var/log/cups
    lpadmin
    lpq  # show printer queue status
    lpstat -s  # status, including URL
    sudo systemctl status cups.service

Command-Line Printing and Options <http://localhost:631/help/options.html>

### cancel print jobs
    cancel -a
    lprm

### lp
    lp -n <number_of_copies> <image>
    lp -o scaling=200 <image>  # prints divided across 4 pages

can't center image on page

#### prints all images in a directory
    lp *
    lp *.JPG
    lp *.png -o ColorModel=KGray  # black cartridge only

#### orientation
automatically selects the best orientation for filling the page

##### specify
    -o orientation-requested=3 - portrait orientation (no rotation)
    -o orientation-requested=4 - landscape orientation (90 degrees)
    -o orientation-requested=5 - reverse landscape or seascape orientation (270 degrees)
    -o orientation-requested=6 - reverse portrait or upside-down orientation (180 degrees)

## printing - HPLIP
    hp-info  # reports version and pops up info
    hp-levels  # takes a little while to show the ink levels (after "Using device : ...")
    hp-printsettings  # dialog pop-up, but no dpi's
    hp-setup -h
    hp-setup -r  # GUI to remove printer
    hp-systray & disown  # HPLIP Status Service tray icon (access to HP Device Manager)
    hp-testpage
    hp-toolbox &  # HP Device Manager

## webcam
    cameractrls

### Guvcview
    guvcview &
    ~/my_video-n.mkv

`Logitech B525`: `Audio Controls > Audio API > PULSEAUDIO`

### V4l-utils
    qv4l2 &
    v4l2-ctl --list-devices
    v4l2-ctl -d /dev/video0 --list-ctrls
    v4l2-ctl -d /dev/video1 --list-ctrls

# imagey
    colorpicker --one-shot --preview
    gphoto2 --auto-detect  # list detected cameras
    gphoto2 -DR  # delete all files in all folders
    gphoto2 -l  # list folders
    gphoto2 -L  # list files
    gphoto2 -P  # get all files
    gpicview  # opens first image in directory (no thumbnails)
    exiftool <image>
    exiftool -Orientation *  # reports
    exiv2 <image>

## feh
    feh -F  # fullscreen
    feh -l [*] # [recursively] list image specifications

- can open `webp`
- can't animate a `gif`

### in-image
    d => toggle_filenames

#### size
```
* => 100%
/ => fit the window size
up/down => zoom in/out
```

## ImageMagick
    magick -flatten transparent.png white_background.png
    magick -list
    magick -list gravity
    magick <people> -paint 9 <people-oil>
    magick <positive> -negate <negative>
    for i in $(ls); do magick -resize 10% $i r$i; done
    for i in $(ls); do magick -resize 15% $i r$i; done
    for i in $(ls); do magick -resize 25% $i r$i; done
    for i in $(ls); do magick -resize 50% $i r$i; done

### convert
    for i in *.bmp; do magick $i ${i%.*}.jpg; done
    for i in *.svg; do magick $i ${i%.*}.ico; done
    for i in *.svg; do magick $i ${i%.*}.png; done
    for i in *.jpeg; do magick $i jpg/${i%.*}.jpg; done  # gets them into subfolder jpg
    for i in *.webp; do magick $i ${i%.*}.jpg; done

### recolour
    for i in *.png; do magick $i -fill green -colorize 100% ${i%.*}-green.ico; done
    for i in *.png; do magick $i -fill orange -colorize 100% ${i%.*}-orange.ico; done
    for i in *.png; do magick $i -fill red -colorize 100% ${i%.*}-red.ico; done
    for i in *.png; do magick $i -fill yellow -colorize 100% ${i%.*}-yellow.ico; done
    magick <colourimage> -colorspace Gray <grayimage>

## nomacs
    nomacs -h
    nomacs -v

- can only fill page for printing
- can't open `avif`, `exr`, `heic`, `webp`
- PrintPreview-PageSetup-Landscape

### keybindings
    ctrl+k => keyboard Shortcuts
    ctrl+r => resize
    ctrl+s => save dialogue
    ctrl+shift+p > Close on ESC
    f => toggles selected panes
    F1 => credits
    F10 => frameless

    `Alt+a` (`Adjustments`) > `i` (`Invert Image`)

#### Alt
    Alt A > Exposure > Gamma
    Alt A > Tiny Planet

#### not having cropped
    Ctrl+w => next tab
    Ctrl+w => close tab

#### Panels
    alt+m => Metadata Info
    i => File Info
    f => hide all
    m => Metadata Ribbon
    mouse right-click to find them

## Pinta
- attempts to shows cursor position in pixels, but underestimates - use GIMP
- `backspace` (= `Edit > Erase Selection`)
- can't send to printer...
- `Rectangle Select > Cut > Paint Bucket` to replace an area with a solid colour fill

## pqiv
    pqiv -i <animateGif> &  # opens the animated gif without the obtrusive info box
    pqiv --auto-montage-mode * &  # flat recursive view of all imagies
    pqiv --show-bindings

- can open `avif`
- changes aren't saved
- plays mp4's
- only sees specified images
- powerful quick image viewer
- recursive
- shows size in status bar tab


## scanimage
    scanimage -A  => --all-options => lists all available options
    scanimage -h
    scanimage -L  => --list-devices

## [n]sxiv
- can't animate a gif
- can't send to printer
- Simple X Image Viewer

### commands
thumbnail mode: `R` reload all

#### image mode
- `n` `p` next previous
- `[` `]` 10x backwards forwards
- `|` `_` flip horizontal vertical
- changes aren't saved

##### pan
- `h` `left`
- `j` `down`
- `k` `up`
- `l` `right`

##### rotate
- `<` 90° ccw
- `>` 90° cw
- `?` 180°

##### scroll
- `H` to left
- `J` to down
- `K` to up
- `L` to right
- `z` to center

##### zoom
- `=` by 100%
- `e` `E` fit width height
- `F` fill (often getting only part of the image)
- `w` fit or 100%
- `W` fit (the default)

#### general
- `q` quit
- `return` toggle image/thumbnail
- `f` toggle fullscreen
- `b` toggle statusbar
- `g` `G` first last
- `r` reload
- `+` `-` zoom in out

### nsxiv
    i nsxiv
    nsxiv *
    nsxiv <path_to_dir>
    nsxiv -c  # --clean-cache
    tree ~/.cache/nsxiv

- can open `avif`
- only sees specified images

### sxiv commands
    b => toggle infobar
    f => toggle fullscreen
    q => quit

No refresh of directories...

## Vimiv
    vimiv &

- can open `avif`
- can't open a gif
- doesn't pick up changes in the directory

### commands
    O => switch focus
    o => toggle the library (the current directory)
    w => write changes

#### thumbnails
    +/- => size
    t => toggle

### tagged file list manipulation
    :tag_remove tagname
    :tag_write tagname
    cat ~/.local/share/vimiv/Tags/tagname | while read i; do mv $i .; done
    rm -r ~/.local/share/vimiv/Tags/tagname

# lsof
    [sudo] lsof -i

list open files

# multimedia
    ffprobe -i <avfile> -show_format -v quiet | sed -n 's/duration=//p'  # fractional seconds
    mediainfo <avfile> | grep Encoded
    mediainfo <avfile> | grep Title

## mpv
    mpv av://v4l2:/dev/video0
    mpv --start=-2 <avfile>  # starts 2 seconds from end

# networking
    arp-scan -lx  # lists subnet hosts
    bluetoothctl -- devices
    sudo iptraf-ng  # ncurses network statistic monitoring utility
    sudo lshw -c network
    sudo lsof -i -P -n | grep LISTEN  # to see the listening ports

## devices
    arp-scan --localnet  # reports MAC addresses on network
    ip link
    networkctl list

## hostname
    hostname
    hostnamectl
    uname -n  # hostname

## iproute2
    ip a  # ip address show
    ip l  # lists machine's ethernet devices
    ip neigh  # subnet hosts
    ip r  # ip route show - compactly shows my internal ip address

## iwd
    man iwd
    sudo ls /var/lib/iwd  # reports internet source
    systemctl status iwd.service

### iwctl
    man iwctl
    iwctl device list  # shows MAC address
    iwctl known-networks list
    iwctl station wlan0 get-networks  # shows if  wlan0  is connected to one

requires a `DHCP` client to get an IP address

## NetworkManager
    nmcli device  # list of networking devices
    nmcli device wifi list | cat  # paged list of SSIDs, with those IN-USE starred
    nmcli device wifi connect <SSID> password <pw>

### saved connections
    nmcli connection delete <SSID>  # can help
    nmcli connection show | cat  # reports UUIDs and colourizes the active device
    nmcli connection up uuid <UUID>

## NordVPN
    nordvpn cities United_Kingdom
    nordvpn cities United_States
    nordvpn countries
    nordvpn rate x  # 1 (poor) to 5 (excellent)
    nordvpn set technology nordlynx
    nordvpn settings
    nordvpn status
    pgrep nordvpn
    sudo pkill -9 -f nordvpn  # doesn't logout

### account
    nordvpn connect CA
    nordvpn connect UK
    nordvpn connect US
    nordvpn disconnect
    nordvpn login
    nordvpn logout
    nordvpn rate 5
    nordvpn status | xcol United

## ss
    bm ss
    ss --tcp --listening
    ss -tulw  # listening on TCP, UDP, RAW sockets

## ssh
    $HOME/.ssh/authorized_keys
    ssh localhost
    sudo systemctl restart sshd.service
    sudo systemctl status sshd.service

### session commands
    ~? => supported escape sequences

#### exit
    exit
    ~.
# npm
    which npm

## cspell
    cspell trace "colour"  # shows which dictionary it's in
    cspell check <filename>
    cspell lint --help

## ffmpeg-concat
- `-d <transition_duration>` default `500`
- `-o <out_file>` default `out.mp4`
- `-t <transition_name>` default `fade`

## npx
    ls ~/.npm/_npx/*/node_modules
    rm -r ~/.npm/_npx/

# one-line of command output
    echo $(ls)
    ls | xargs
    xargs < <file>  # cat alternative

# pass
    pass  # pass ls
    pass help
    pass init <gpg-id>  # creates  ~/.password-store/.gpg-id
    pass add [-f] <node> > <pw> # insert --force
    pass insert <node> > <pw>
    pass <node>
    pass mv <node_old> <node_new>
    pass rm [-f] [-r] <node>  # [--force] [--recursive]

pass(1)

# processes
    lsof -i
    pidof init  # process id of  init, which is always 1
    sudo iotop -o
    time sleep 1
    xprop  # WM_CLASS(STRING) = "instance", "class"

niceness: `-20` = highest priority, `19` = lowest

## kill
    kill -9 **<tab>  # fzf
    pkill zoom

## list
    ps -ef | grep yt-dlp
    ps -ef | grep hp-
    ps -efjH
    pstree -C age

## pgrep
    i pgrep
    pgrep <aprogram>  # reports it's process id

# shell
- `dc` desk calculator (reverse-Polish)
- `echo $SHELL` reveals flavour
- `fc` "fix command"

## Bash
    $misc/linux/QR/script.sh
    $cITcr/unix-like/LearnBash.sh
    $culLB/colours
    $culLB/Scratch0.sh
    /etc/profile
    bash --help
    bash --version
    bind -P
    echo "$floatingpointnumber-$another" | bc  # FP math
    echo "$PS1"
    echo $PWD
    echo $SHELL
    env | grep SHELL
    exit 0  # to quit script
    help compgen
    kill -9 **<tab> # invokes  fzf (if no  ble.sh)
    printf command
    read -p "hit Enter"; echo hello
    read a b; echo $a $b
    shopt
    shopt dotglob  # reports back its status
    shopt -u nullglob  # incase  t=$'\?'; echo $t
    spectroterm -h
    tail -1 <file>  # last line
    tail +3 <file>  # cat from line 3
    za $cITcr/unix-like/linux/GNUOS/bash.pdf

```bash
case 'one' in
  one) echo 1;;
  two) echo 2;;
esac
```

- BASH(1)
- command substitution `$(...)`
- in a script, `"~"` isn't expanded - use `"$HOME`

### aliases
    alias
    compgen -A alias | awk '{print}' ORS=' : '; echo  # compact list
    unalias

### Atuin
    atuin
    atuin stats
    atuin stats last friday
    atuin stats yesterday
    ~/.config/atuin/config.toml
    ~/.local/share/atuin

SQLite database of commands

### ble.sh
Bash Line Editor

#### Vim mode
    ble-bind -P  # --print  the keybinds

- insert-mode: `Ctrl-x Ctrl-v` = `display-shell-version`
- normal-mode: `K` = `command-help`
- once begun, `f1` = `command-help`

### clear screen (saving scrollback)
    clear -x  # erase the all lines not in scrollback
    ctrl+l => scroll the current line to the top
    tput reset

### conditionals
    [ "$a" ] && echo $a
    [ -z "$a" ] && echo zero_string; [ -n "$a" ] && echo string_not_null
    [ true ] && echo y
    [ "y" ] && echo y
    c=1; [[ $c == 1 ]] && echo "true"
    if true; then echo 'not false'; fi
    if <condition1>; then <action1>; elif ... else ... fi
    if [ "$a" ]; then echo '$a is defined'; fi
    t="y"; if [ $t ]; then echo $t; fi

#### =~
    [[ "hello" =~ "ll" ]] && o ll
    v=value; [[ ! $v =~ val ]] && echo val

### echo
    echo "~ stays ~ in double quotes, it's unexpanded to $HOME"

`-n` no trailing newline

#### backslash escapes
    echo -e "\\t" word_after_tab
    echo -e '\t' word_after_tab
    echo $'aa\'bb'

`-E`  # (default) no interpretation

### file manage
    echo */  # lists directories
    echo <file>
    for f in *; do mv $f ${f:2}; done
    man -h ls
    mktemp temp-XXX  # can add more X's, touch's a randomised filename
    pushd ~/some_path; pushd /another_path; popd; popd
    >f  # creates/empties file  f
    >>f  # creates file  f  if necessary

#### find
    find . -maxdepth 1 -mindepth 1 -type d -name "*"  # those in working directory
    find -iname \*.flv -o -iname \*.mp4 -o -iname \*.ogv
    find -type f -name "[[:upper:]]*"  # files beginning with capital letter

`-iregex <pattern>` = case insensitive `-regex`

#### tests
    [ -d "$d" ] && echo "directory $d is there"
    [ -f "$f" ] && echo "file $f is there"
    [ -s "nohup.out" ] && echo non-zero file size
    [[ -d "$d" && ! -L "$d" ]] && echo "It's a directory and not a symbolic link"
    rm a b; touch a; sleep 1; touch b; ls -t; [ a -ot b ] && echo older

### functions
    "$@" = "$1" "$2" ...
    export -f <usefulfunction>  # allows it to be used in a script
    unset -f <function>

#### lists
    compgen -A function | awk '{print}' ORS=' : '; echo
    declare -F  # lists all declare -f possibilities

#### show code
    declare -f <function_name>  # shows its contents
    type <function_name>

### history
    ~/.bash_history

- `!:0 <arguments>` reusing only the command from the last line
- `<command> !*` (`!!:*` in which 2nd `!` refers to last line in history, `*` refers to all of its arguments)
- `<command> !-2:$` from penultimate line in history, select last argument

### Internal Field Separator - set
    IFS=this
    unset IFS
    savedIFS=$IFS; ...; IFS=$savedIFS

### Internal Field Separator - test
    cat -et <<<"$IFS"
    echo "hello$IFS"."there"

### job control
    ctrl+c
    bg
    fg %n
    jobs -l
    kill %n
    kill -9 %n

### Login shell?
    echo $0  # "-bash" = login shell, "bash" = non-login shell
    shopt login_shell

### loops
    break  # breaks out of loop
    continue  # to next iteration of loop
    c=5; for i in $(seq $c); do echo $i; done
    for i in {0..9..2}; do echo $i; done
    for i in bee fly wasp; do echo $i; done
    s=2; e=4; for (( c=$s; c<=$e; c++ )); do echo $c; done
    select f in apple pear grape; do echo "you chose $f"; done
    while read line; do echo "$line"; done <file_to_use_line_by_line

#### globs
    $misc/unix_like/linux/need_for_nullglob.sh
    for d in */; do echo $d; done
    for d in /mnt/*; do echo $d; done
    for f in **/*; do echo $f; done

### managing commands
    o $?  # exit code of last command, 0 if command succeeded
    eval $Command
    vi mode: v  => edit a command in $EDITOR

#### execute last command
    !!
    sudo !!

#### redirecting
```
<somecommand> 2>&1 | tee stdout+stderr.log
<somecommand> > /dev/null 2>&1
```

`find ... 2> /dev/null` suppresses stderr stream

##### key
    1 = stdout file descriptor
    2 = stderr file descriptor
    >& = redirect to a file descriptor
    1>&2 = 2>&1

### online code check
- <https://explainshell.com/>
- ShellCheck <https://www.shellcheck.net/>

### set
    echo $-  # current options
    set -e  # terminate on a fail
    set -v  # show code lines as they're used
    set -x : show commands and arguments

change `-` to `+` to remove the option

### unset
    unset **<tab> # invokes  fzf (if no  ble.sh)
    var1=1; var2=2; echo $var1 $var2; unset var1 var2

### su[do]
    su -  # login shell

substitute user identity

### trap
    trap - debug  # turn off debug
    trap read debug  # puts a read request after each executable line

### variables
    echo $((2*2))
    export  # lists environment variables
    set  # lists all variables

#### arrays
    a=(1 2 3); ((a[0]++)); ((a[1]+=2)); a+=(4); echo ${a[@]}
    a=(1 2 3); echo ${a[-1]}  # last element
    a=(1 2 3); b=("${a[@]}"); b+=("${a[@]}"); echo ${b[@]}
    echo ${#array[@]}  # number of elements
    firstElement=${array[0]}
    string='My string'; [[ $string =~ "My" ]] && echo success

don't export them

##### from file
    aff=$(<$f); aff=(${aff//'\n'/,}) # array from file  $f
    mapfile --help
    mapfile -t found < <(find .)
    mapfile -t array < <(cat file)
    mapfile -t GreekArray < <(printf "Alpha\nBeta\nGamma"); echo ${GreekArray[@]}

##### list
    echo ${array[@]}
    for ((index=0; index<${#array[@]}; ++index)); do echo "$index" "${array[index]}"; done
    for item in "${array[@]}"; do echo; echo "$item"; done
    printf '%s\n' "${array[@]}" | grep 'match'

#### integers
    (( $1 == 1 || $1 == 2 )) && echo "number 1 or 2"
    ((i-=2)) # decrements $i by 2
    i=0; echo $((i+=1))
    n=2; if ! (( $n == 1 )); then echo 'not 1'; fi
    n=1; printf "%03d\n" $n
    n=08; (( 10#$n > 7 )) && o base10  # because 08 is an impossible octal

##### comparison
    if [ "$a" -ge 2 ]
    if [ "$a" -gt 2 ]
    if [ "$a" -le 2 ]
    if [ "$a" -lt 2 ]
    if [ "$a" -ne 2 ]

##### (( > ))
    (( 1 > 0 )) && o 1
    if (( 1 > 0 )); then echo greater; fi
    if (( 1 >= 0 )); then echo greater; fi

#### empty or undefined
    $undefined && echo 'Eh! $undefined true!'
    empty=''; [ -z $empty ] && echo empty

#### strings
    [[ ! $t =~ (y|n) ]] && echo 'good answer'
    [ 'y' == 'n' ] || echo 'nope'
    n=''; n=n; [[ -n $n ]] && echo $n
    o lkj | rev | cut -c 2- | rev
    o ljk | sed 's/.$//'
    s='long'; o ${#s} # length
    qs=$'quote\'*star'; o "$qs"
    s=12345; echo $s | awk '{print substr($1,length($1)-2) }'
    s=12345; echo $s | cut -c $((${#s}-2))-
    s=yes; s+=no; o $s
    s=start; o $s'-end'
    s+=new; o $s
    ${x}and$y

case conversions: `var=vAlUe; o ${var^^}; o "${var,,}"`

##### $PATH
    echo "${PATH//:/$'\n'}"
    echo "$PATH" | tr ':' '\n'

##### brace expansion
    echo {1,2,3}-go
    echo {j,h}el{l,}o

##### parameter expansion
    file=a.b.c; echo ${file##*.}; echo ${file%.*}

    s='strong string'; o ${s//str/p} # all matches
    ${string/substring/firstMatchReplacement}
    ${string/#substringAtStart/replacement}
    ${string/%substringAtEnd/replacement}
    ${string:position:length}
    a=12345; o ${a:0:2}; o ${a:2}; o ${a:1:2}; o ${a:2:1}
    b="a(b(c(d"; o ${b##*\(}
    s=12345; echo ${s::-2}; echo ${s: -2}
    t=lkj; echo ${t:0:${#t}-1}

    name=polish.ostrich.racing.champion; o ${name#*.}; o ${name##*.}; o ${name%%.*}; o ${name%.*}
    u=.git.git.git; o ${u%.git}

##### script's name
    DIR=$(dirname "${BASH_SOURCE[0]}")  # get the directory name
    DIR=$(realpath "${DIR}")  # resolve its full path if need be

## flow control
- `ctrl+q` continue
- `ctrl+s` stop

# sort
    sort -or <file> <file>  # reverse sort in place
    sort -t, -k2,2 -k3.2,3.3 -k4  # sort csv on 2nd column, then on 2nd & 3rd characters of 3rd column, then on text from 4th column on

- `-h` (`--human-numeric-sort`)
- `-n` (`--numeric-sort`)
- `-r` (`--reverse`)
- `-o` (`--output=FILE`)
- `-u` (`--unique`)
- `-V` (`--version-sort`) natural sort of (version) numbers within text
- `--help`
- ignores `!#%*.`
- `--version`

# system
    cat /etc/hostname
    clamscan -r  # shows Loading & Compiling
    clamscan -r 2>&1 | tee clamscan.log
    gtk-launch --version
    halt -p
    i hier  # detailed description of the filesystem hierarchy
    locale
    openbox --reconfigure
    passwd jo  # then re-login
    ps $(pgrep Xorg)  # shows which tty X is on
    shutdown now
    swapon --show
    w  # list users and load on system
    whereis <executable>
    xdg-open -h
    xrdb -query -all  # shows loaded X resources
    xset q  # shows a variety of IO settings

- `awesomewm`: floating window: `winkey+left_mouse_drag`
- lsmod(8) show what kernel modules are currently loaded
- maximum 255 bytes per filename & 4096 per path

## awesome wm
- maximized (horizontally or vertically) are indicated by (horizontal or vertical) double arrow, and break tiling
-`modkey+left_mouse_drag` move
-`modkey+right_mouse_drag` resize
-`modkey+s` = `awful.hotkeys_popup`
- on top clients are indicated by a caret

## boot
    bootctl -h  # --help
    find /dev/disk/by-designator -type l -ls  # recursively list all symlinks with their references

## conky
    conky -C  # --print-config
    killall -SIGUSR1 conky  # brings it back up

## CPU-X
    cpu-x -h
    cpu-x -N
    Openbox Menu > System > CPU-X

## directory sizes as root
    du -shx
    ncdu -x  # --one-file-system

## etckeeper
    /etc/.gitignore
    /etc/etckeeper/etckeeper.conf
    sudo ls /etc/.git

## groups
    /etc/group  # all of them
    gpasswd [-a <user> <group_to_add_to>]
    groups jo
    sudo groupadd <group_to_create>
    sudo groupdel <group_to_delete>

## GRUB
    grub-install --version

(GRand Unified Bootloader)

## kernel parameters
    sysctl -a  # display all kernel parameters
    systeroid -A  # list all parameters
    systeroid -T  # list parameters in a tree

## lnav
    journalctl -f | lnav
    journalctl -f -o json --output-fields=MESSAGE,PRIORITY,_PID,SYSLOG_IDENTIFIER,_SYSTEMD_UNIT | lnav
    journalctl -f -o json | lnav
    journalctl -f -o short-iso | lnav  # handling year changes

- hit `Esc` to get out of weird edit mode
- The Logfile Navigator

## monitoring
    atop
    free -h
    glances
    gtop
    htop
    iostat -dm -p sda2 3
    last reboot
    saidar -c

### dool
    dool --help
    dool -dD sda  # --disk
    dool -n  # --net
    dool -s  # --swap
    i dool

## notification
    zenity --calendar

### Dunst
    dunstctl history-pop  # repeat for previous messages
    dunstify --help
    dunstify -u critical "Read this now!"
    dunstify "First test message."; dunstify "Second test message, which is longer."

`dunstrc` allows tweaks that aren't available with `Xfce Notify Daemon`

#### dunst
    dunst &
    pgrep dunst
    pkill dunst

- (if `xfce4-notifyd` hasn't taken over `org.freedesktop.Notifications`) any notification reloads `dunst`
- takes over `org.freedesktop.Notifications` thus incapacitating `xfce4-notifyd`
- only keeps `history_length` of notifications in memory, nothing persistent

##### close notifications
    dunstctl close  # the last one
    dunstctl close-all

if no luck, can also kill the `Xfce Notify Daemon`

### notify-send
    notify-send 'test of notify-send'
    notify-send --help
    notify-send -u critical "test of critical notification"
    notify-send -t 5000 -u low "low urgency 5s notification"

## Plasma
    Ctrl+Alt+Shift+Del -> exit KDE without saving
    Ctrl+Alt+Del       -> logout screen
    Ctrl+Alt+T         -> Konsole
    Win+PageUp/Down    -> maximises or returns to normal a window

## Qt
    qmake -query QT_VERSION

`qmake -v` also reports `Qt` version

## systemd
    systemctl halt
    systemctl reboot
    systemctl suspend
    systemd-analyze --system unit-paths
    systemd-analyze --user unit-paths
    systemd-analyze calendar "*-*-* *:00:00"

### info
    systemctl --failed
    systemctl --user --no-pager  # list running Systemd units
    systemctl --version
    systemctl is-enabled <service>
    systemctl list-timers
    systemctl list-unit-files --no-pager
    systemd-analyze blame  # time taken for boot processes

### journalctl
    :Man journalctl
    journalctl --disk-usage
    journalctl --list-boots
    journalctl --verify

- `-f`, `--follow`
- `-n`, `--lines=` (default 10) most recent events
- `-u` (`--unit=UNIT|PATTERN`)
- `-r` (= `--reverse`) output
- journalctl(1)

#### latest
- `journalctl -f | lazyjournal` I don't get...
- with `lnav`

#### messages, paged
    journalctl -b  # for this boot
    journalctl -b | tl  # (toolong) a little slow, but easier to read
    journalctl -b -1  # for previous boot
    journalctl -b -1 -e  # shows end of  -n1000
    journalctl -b -1 -r  # newest first
    journalctl -b -g 'EFI v'  # shows EFI version

## uname
`uname -a` (= `--all`) handy line of system info

### --kernel-release
    [[ $(uname -r) =~ 'arch' ]] && echo 'Arch Linux'
    [[ $(uname -r) =~ 'microsoft' ]] && echo 'WSL2'

## users
    [[ $EUID > 0 ]] && echo "not root"
    id -u
    su -
    sudo -u caddy ls /var/log/caddy
    usermod -aG <group_to_be_added_to> <user> # needs a reboot
    who  # lists users active on terminals
    whoami

## Xfce
    xfce4-display-settings &
    xfce4-panel -r  # reloads
    xfce4-settings-manager &

- `GTK`
- `Terminal` (`xfce4-terminal`)
    - `ctrl+shift+c` = copy
    - `ctrl+shift+v` = paste
- `xfwm4-tweaks-settings &` = `Windows Manager Tweaks`

### Clipman
- `~/.cache/xfce4/clipman/textsrc` semicolon-separated list
- clickable `Panel` icon

### keyboard shortcuts
- `Alt+F3` = `Application Finder`
- `Alt+scrollwheel` = `zoom_desktop`
- `Ctrl+Alt+D` = minimize all
- `Ctrl+Alt+Del` = `xfce4-session-logout`
- `Ctrl+Alt+Escape` = `xkill` (right-click abandons)
- `Ctrl+Alt+L` = `xflock4`
- `HomePage` = `XF86HomePage` = `exo-open --launch WebBrowser`
- `Shift+Ctrl+Esc` = `xfce4-taskmanager`
- `Super+e` = `thunar`
- `Applications > Settings > Keyboard > Application Shortcuts` can take a bash script path

#### windows
- `Applications > Settings > Window Manager`
    - `Alt+F9` = minimise
    - `Alt+F10` = toggle maximise
    - `F11` = full screen
    - `super+1` = move to left monitor
    - `super+2` = move to right monitor

#### workspaces
- `Ctrl+Alt+Home/End` = move window to left/right workspace
- `Ctrl+Alt+left/right arrow` = left/right workspace
- `Ctrl+Fn` = goto workspace n

### Thunar
    ~/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml

Custom Actions: `~/.config/Thunar/uca.xml`

#### keyboard accelerators
- `~/.config/Thunar/accels.scm` accelerator map dump
- `Ctrl+Shift+n` = `create-folder`

### Xfce Notify Daemon
    systemctl --user status xfce4-notifyd
    systemctl --user start xfce4-notifyd
    systemctl --user stop xfce4-notifyd
    xfce4-notifyd-config &

no indication of priority - only distinguishing feature of `critical` notifications is their persistence

# SystemRescue
    setkmap fr
    startx

# term
    [ $TERM_PROGRAM == 'WezTerm' ] && o "you're in WezTerm"
    bash $cGRs/d-unix-like/r-hackerb9/fonttable/fonttable
    sudo fgconsole  # reports tty number

- `^\` = `SIGQUIT`
- `^c` = `SIGINT`
- `^q` resume output to screen
- `^s` pause output to screen
- w(1) logged on info

## Alacritty
    alacritty -h  # --help
    alacritty -V  # --version

- `Ctrl+Shift+b` = `SearchBackward`, then `Esc`
- `Ctrl+Shift+space` = `ToggleViMode`

### font
- `Ctrl+-` = `DecreaseFontSize`
- `Ctrl+0` = `ResetFontSize`
- `Ctrl+=` = `IncreaseFontSize`

### scroll
- `Shift+PageDown/Up` = `ScrollPageDown/Up`
- `Shift+End/Home` = `ScrollToBottom/Top`

## size
    echo $COLUMNS $LINES
    stty size  # lines columns
    tput cols lines

### set (not in tmux)
    printf '\033[8;40;100t'
    resize -s 90 150

## terminal line settings
    stty -a

### flow control
    [-]ixon = the setting
    ctrl-q = XON
    ctrl-s = XOFF

## Termux
    if ! [ $TERMUX_VERSION ]; then echo 'not in Termux'; fi
    termux-info

## tmux
    if [ $TERM == 'screen-256color' ]; then echo "you're in tmux"; fi
    pgrep tmux -l

### $ tmux ...
    tmux a               # attach
    tmux a -t myname     # attach to session myname
    tmux detach
    tmux kill-server     # good for resetting
    tmux kill-session -a # kills all but current session
    tmux list-keys | grep '~'
    tmux list-keys | mo
    tmux ls              # list sessions
    tmux lsk -Na         # includes my rebinds
    tmux send ls enter  # (send-keys) ls  in the currently active pane
    tmux show -g prefix  # (show-options)
    tmux show -s   # server

### internal commands
    :bind  # alias for  bind-key
    :choose-tree  # put a pane into tree mode, can kill and select
    :set synchronize-panes  # (set-option)

#### join-pane
    :j-s 2.1 [-t 1.0 ]  # src-pane W2P2 [to dst-pane W1P0]

- `:joinp` is the only abbreviation I can find in the manual
- from another pane, `:j-hs 2.1` pulls in src-pane W2P2 alongside

## tput
    (x=`tput op` y=`printf %76s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done) # 256 lines of colour
    tput bold; tput setaf 3; tput setab 4; echo 'bold yellow on blue'
    tput colors
    tput cuu 2; tput el  # move back a line and clear it

## urxvt
    urxvt --help

- `$TERM` is set to `rxvt-unicode-256color`
- `rxvt-unicode`
- `URxvt.url-launcher`

# tr
    tr '\n' '~' < <in> | sed 's/~/  /g' [> <out>]  # replace newlines with double spaces

tr (Unix)

# Ubuntu
    lsb_release -a
    ods2tsv list.ods > list.tsv
    sensible-browser https://manpages.ubuntu.com/manpages/jammy/man1/sensible-browser.1.html
    sudo updatedb

`sed -i` will change `fileformat` to `dos`

## packages
    apt-cache search .

https://packages.ubuntu.com/

### manage
    apt-cache -h
    apt-cache show <package>  # info
    apt-cache showpkg <package>  # report includes dependencies and reverse dependencies
    apt-get download <package>  # to current directory
    dpkg -l
    dpkg-deb -x <package> <directory>  # --extract
    sudo apt install <package1> <package2> ...
    sudo apt remove <package1> <package2> ...

- `sudo apt update` [the package index]
- `sudo ls /etc/apt/sources.list.d/` repositories

### upgrade packages
    sudo apt autoremove
    sudo apt upgrade
    sudo apt-get clean
    sudo apt-get dist-upgrade  # better, riskier

## Pro
    pro security-status
    pro status
    sudo pro attach <FPT>

# vim
    $HOME/.viminfo
    e -la /usr/bin/vim
    find . -type f -name tags
    file "$(command -v vim)"
    gvim &
    neovide &

# WAN
    dig harriott.github.io
    fping -h
    gping google.com
    if wget -q --spider google.com; then echo online; fi
    ping -c 3 1.1.1.1  # CloudFlare's DNS
    pkill radio; radio -K  # quit & kill instances of  radio-active

avoid Dropbox flexible file names: `fd -u '"|\*|:|<|>|\?|\\|\|'`

## Carburetor
    flatpak info io.frama.tractor.carburetor

### commands
- `Ctrl+,` = `Preferences`
- `Ctrl+?` = `Shortcuts`
- `Main Menu > Set Proxy` then https://check.torproject.org/

## Chawan
    cha -V
    cha https://en.wikipedia.org
    mancha cha

### key bindings
- `alt+i` toggle images
- `q` quits
- `v` toggles select
- `y` yank to clipboard
- vim-like

## email - clm
    $OSL/nodes/bashrc-clm
    mbsync -v

### msmtp
    msmtp --version

"an SMTP client"

### neomutt
    neomutt -D  # dump settings
    neomutt -h  # help
    neomutt -v  # version
    rm -r ~/.cache/mutt/*
    sidebar_format

### notmuch
    notmuch config get database.path

#### search
    nmse ...
    notmuch --help
    notmuch --version
    notmuch search '"the Pennines"' # finds exactly that
    notmuch search tag:attachment | wc -l
    notmuch search tag:fm | wc -l
    notmuch search tag:zou | wc -l
    notmuch search tag:zou and tag:inbox | wc -l
    notmuch tag -cz -- tag:zou  # removes all cz tags

- case-insensitive
- `date:DD-MM[-[YY]YY]`
- `date:D[D].M[M][.[YY]YY]`
- `date:YYYY-MM[-DD]`
- `from:`
- NOTMUCH-SEARCH-TERMS(7)
- seems to not find emails that're included in subsequent ones
- `subject:(pizza free)` (= `subject:pizza and subject:free`) matching "Free Delicious Pizza" (while `subject:"pizza free"` won't)
- `to:`

## email - Thunderbird
    thunderbird -addressbook
    thunderbird -h  ## --help

### version
    thunderbird --full-version
    thunderbird -v  ## --version

## firewall
    sudo iptables -L

### Firewalld
    sudo firewall-config
    sudo systemctl start firewalld
    sudo systemctl stop firewalld
    sudo systemctl status firewalld
    sudo systemctl restart firewalld

#### firewall-cmd
    sudo firewall-cmd --info-zone=home
    sudo firewall-cmd --info-zone=public
    sudo firewall-cmd --panic-on
    sudo firewall-cmd --state

### iptables
    sudo iptables -nvL
    sudo systemctl status iptables.service

## GNU Wget
    :Man wget
    wget -kr -A.zip https://url-to-webpage-with-pdfs/  # works from that page
    wget -r -A.pdf http://url-to-webpage-with-pdfs/  # works recursively from root page

- `-E` (`--adjust-extension`)
- `-O file` (`--output-document=file`)

## MTR
- `h`/`?` help
- `q` quits

## rdrview
    i rdrview
    rdrview http://harriott.github.io -M

## transmission-cli
    http://localhost:9091/transmission/web/
    transmission-daemon --dump-settings
    transmission-remote -a some.iso.torrent
    transmission-remote -l

## w3m
    w3m http://harriott.github.io  # showing images
    w3m https://man.archlinux.org/man/w3m.1.en

### keymaps
- `H` Current keymap file
- `M` (= `EXTERN`) opens page in default browser
- `o` (= `OPTIONS`) Option Setting Panel
    1. `[shift-]tab` to option then `Enter`
    1. `tab` to `[OK]` then `Enter` to end
- `Q` (= `EXIT`)
- `r` (= `VERSION`)
- `R` (= `RELOAD`)

#### movements
- `+` ` ` (= `NEXT_PAGE`)
- `-` `b` (= `PREV_PAGE`)
- `[`, `]` (= `LINK_BEGIN`, `LINK_END`) start, end of page
- `g` (= `BEGIN`) start of page
- `w` (= `NEXT_WORD`)
- `W` (= `PREV_WORD`)
- `z` (= `CENTER_V`) centres on current line
- vim-like

#### navigation
`B` (= `BACK`)

##### URLs
- `c` (= `PEEK`) reveals the url
- `e` (= `PEEK_IMG`) reveals the url
- `U` (= `GOTO`) presents dialogue on current url (`ctrl-u` clears that url)
- `u` (= `PEEK_LINK`)
- `v` (= `VIEW`) toggles HTML view

#### page contents
- `I` (= `VIEW_IMAGE`)
- `S` (= `SAVE_SCREEN`) requests name for file to save to (line breaks are kept)
- `/` (= `SEARCH`) centres on found
- `tab`, `shift+tab` jump to next, previous link

#### tabs
- `ctrl+q` (= `CLOSE_TAB`)
- `s` (= `SELECT_MENU`) to move tabs
- `T` (= `NEW_TAB`) re-opens current tab, new
- `{` (= `PREV_TAB`)
- `}` (= `NEXT_TAB`)

