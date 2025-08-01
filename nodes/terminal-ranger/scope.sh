#!/usr/bin/env bash

# $OSL/nodes/terminal-ranger/scope.sh
# JH - marks my tweaks

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

## If the option `use_preview_script` is set to `true`,
## then this script will be called and its output will be displayed in ranger.
## ANSI color codes are supported.
## STDIN is disabled, so interactive scripts won't work properly

## This script is considered a configuration file and must be updated manually.
## It will be left untouched if you upgrade ranger.

## Because of some automated testing we do on the script #'s for comments need
## to be doubled up. Code that is commented out, because it's an alternative for
## example, gets only one #.

## Meanings of exit codes:
## code | meaning    | action of ranger
## -----+------------+-------------------------------------------
## 0    | success    | Display stdout as preview
## 1    | no preview | Display no preview at all
## 2    | plain text | Display the plain content of the file
## 3    | fix width  | Don't reload when width changes
## 4    | fix height | Don't reload when height changes
## 5    | fix both   | Don't ever reload
## 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
## 7    | image      | Display the file directly as an image

## Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
## shellcheck disable=SC2034 # PV_HEIGHT is provided for convenience and unused
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

## Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH="${HIGHLIGHT_TABWIDTH:-8}"
HIGHLIGHT_STYLE="${HIGHLIGHT_STYLE:-pablo}"
HIGHLIGHT_OPTIONS="--replace-tabs=${HIGHLIGHT_TABWIDTH} --style=${HIGHLIGHT_STYLE} ${HIGHLIGHT_OPTIONS:-}"
PYGMENTIZE_STYLE="${PYGMENTIZE_STYLE:-autumn}"
BAT_STYLE="${BAT_STYLE:-plain}"
OPENSCAD_IMGSIZE="${RNGR_OPENSCAD_IMGSIZE:-1000,1000}"
OPENSCAD_COLORSCHEME="${RNGR_OPENSCAD_COLORSCHEME:-Tomorrow Night}"
SQLITE_TABLE_LIMIT=20  # Display only the top <limit> tables in database, set to 0 for no exhaustive preview (only the sqlite_master table is displayed).
SQLITE_ROW_LIMIT=5     # Display only the first and the last (<limit> - 1) records in each table, set to 0 for no limits.

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        ## Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;
        rar)
            ## Avoid password prompt by providing empty password
            unrar lt -p- -- "${FILE_PATH}" && exit 5
            exit 1;;
        7z)
            ## Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}" && exit 5  # JH not  7zz
            exit 1;;

        ## PDF
        pdf)
            ## Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
              fmt -w "${PV_WIDTH}" && exit 5
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | \
              fmt -w "${PV_WIDTH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        ## BitTorrent
        torrent)
            transmission-show -- "${FILE_PATH}" && exit 5
            exit 1;;

        ## OpenDocument
        odt|sxw)
            ## Preview as text conversion
            odt2txt "${FILE_PATH}" && exit 5
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            exit 1;;
        ods|odp)
            ## Preview as text conversion (unsupported by pandoc for markdown)
            odt2txt "${FILE_PATH}" && exit 5
            exit 1;;

        ## PowerShell - JH
        ps1)
            pygmentize "${FILE_PATH}" && exit 5
            exit 1;;

        ## XLSX
        xlsx)
            ## Preview as csv conversion
            ## Uses: https://github.com/dilshod/xlsx2csv
            xlsx2csv -- "${FILE_PATH}" && exit 5
            exit 1;;

        ## HTML
        htm|html|xhtml)
            ## Preview as text conversion
            w3m -dump "${FILE_PATH}" && exit 5
            lynx -dump -- "${FILE_PATH}" && exit 5
            elinks -dump "${FILE_PATH}" && exit 5
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            ;;

        ## JSON
        json)
            jq --color-output . "${FILE_PATH}" && exit 5
            python -m json.tool -- "${FILE_PATH}" && exit 5
            ;;

        ## Jupyter Notebooks
        ipynb)
            jupyter nbconvert --to markdown "${FILE_PATH}" --stdout | env COLORTERM=8bit bat --color=always --style=plain --language=markdown && exit 5
            jupyter nbconvert --to markdown "${FILE_PATH}" --stdout && exit 5
            jq --color-output . "${FILE_PATH}" && exit 5
            python -m json.tool -- "${FILE_PATH}" && exit 5
            ;;

        ## Direct Stream Digital/Transfer (DSDIFF) and wavpack aren't detected
        ## by file(1).
        dff|dsf|wv|wvc)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            ;; # Continue with next handler on failure
    esac
}

handle_image() {
    ## Size of the preview if there are multiple options or it has to be
    ## rendered from vector graphics. If the conversion program allows
    ## specifying only one dimension while keeping the aspect ratio, the width
    ## will be used.
    local DEFAULT_SIZE="1920x1080"

    local mimetype="${1}"
    case "${mimetype}" in
        ## SVG
        image/svg+xml|image/svg)
            rsvg-convert --keep-aspect-ratio --width "${DEFAULT_SIZE%x*}" "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}.png" \
                && mv "${IMAGE_CACHE_PATH}.png" "${IMAGE_CACHE_PATH}" \
                && exit 6
            exit 1;;

        ## DjVu
        image/vnd.djvu)
            ddjvu -format=tiff -quality=90 -page=1 -size="${DEFAULT_SIZE}" \
                  - "${IMAGE_CACHE_PATH}" < "${FILE_PATH}" \
                  && exit 6 || exit 1;;

        ## Image
        image/*)
            local orientation
            orientation="$( identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}" )"
            ## If orientation data is present and the image actually
            ## needs rotating ("1" means no rotation)...
            if [[ -n "$orientation" && "$orientation" != 1 ]]; then
                ## ...auto-rotate the image according to the EXIF data.
                convert -- "${FILE_PATH}" -auto-orient "${IMAGE_CACHE_PATH}" && exit 6
            fi

            ## `w3mimgdisplay` will be called for all images (unless overridden
            ## as above), but might fail for unsupported types.
            exit 7;;

        ## Video
        # video/*)
        #     # Get embedded thumbnail
        #     ffmpeg -i "${FILE_PATH}" -map 0:v -map -0:V -c copy "${IMAGE_CACHE_PATH}" && exit 6
        #     # Get frame 10% into video
        #     ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
        #     exit 1;;

        ## Audio
        # audio/*)
        #     # Get embedded thumbnail
        #     ffmpeg -i "${FILE_PATH}" -map 0:v -map -0:V -c copy \
        #       "${IMAGE_CACHE_PATH}" && exit 6;;

        ## PDF
        # application/pdf)
        #     pdftoppm -f 1 -l 1 \
        #              -scale-to-x "${DEFAULT_SIZE%x*}" \
        #              -scale-to-y -1 \
        #              -singlefile \
        #              -jpeg -tiffcompression jpeg \
        #              -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
        #         && exit 6 || exit 1;;


        ## ePub, MOBI, FB2 (using Calibre)
        # application/epub+zip|application/x-mobipocket-ebook|\
        # application/x-fictionbook+xml)
        #     # ePub (using https://github.com/marianosimone/epub-thumbnailer)
        #     epub-thumbnailer "${FILE_PATH}" "${IMAGE_CACHE_PATH}" \
        #         "${DEFAULT_SIZE%x*}" && exit 6
        #     ebook-meta --get-cover="${IMAGE_CACHE_PATH}" -- "${FILE_PATH}" \
        #         >/dev/null && exit 6
        #     exit 1;;

        ## Font
        application/font*|application/*opentype)
            preview_png="/tmp/$(basename "${IMAGE_CACHE_PATH%.*}").png"
            if fontimage -o "${preview_png}" \
                         --pixelsize "120" \
                         --fontname \
                         --pixelsize "80" \
                         --text "  ABCDEFGHIJKLMNOPQRSTUVWXYZ  " \
                         --text "  abcdefghijklmnopqrstuvwxyz  " \
                         --text "  0123456789.:,;(*!?') ff fl fi ffi ffl  " \
                         --text "  The quick brown fox jumps over the lazy dog.  " \
                         "${FILE_PATH}";
            then
                convert -- "${preview_png}" "${IMAGE_CACHE_PATH}" \
                    && rm "${preview_png}" \
                    && exit 6
            else
                exit 1
            fi
            ;;

        ## Preview archives using the first image inside.
        ## (Very useful for comic book collections for example.)
        # application/zip|application/x-rar|application/x-7z-compressed|\
        #     application/x-xz|application/x-bzip2|application/x-gzip|application/x-tar)
        #     local fn=""; local fe=""
        #     local zip=""; local rar=""; local tar=""; local bsd=""
        #     case "${mimetype}" in
        #         application/zip) zip=1 ;;
        #         application/x-rar) rar=1 ;;
        #         application/x-7z-compressed) ;;
        #         *) tar=1 ;;
        #     esac
        #     { [ "$tar" ] && fn=$(tar --list --file "${FILE_PATH}"); } || \
        #     { fn=$(bsdtar --list --file "${FILE_PATH}") && bsd=1 && tar=""; } || \
        #     { [ "$rar" ] && fn=$(unrar lb -p- -- "${FILE_PATH}"); } || \
        #     { [ "$zip" ] && fn=$(zipinfo -1 -- "${FILE_PATH}"); } || return
        #
        #     fn=$(echo "$fn" | python -c "from __future__ import print_function; \
        #             import sys; import mimetypes as m; \
        #             [ print(l, end='') for l in sys.stdin if \
        #               (m.guess_type(l[:-1])[0] or '').startswith('image/') ]" |\
        #         sort -V | head -n 1)
        #     [ "$fn" = "" ] && return
        #     [ "$bsd" ] && fn=$(printf '%b' "$fn")
        #
        #     [ "$tar" ] && tar --extract --to-stdout \
        #         --file "${FILE_PATH}" -- "$fn" > "${IMAGE_CACHE_PATH}" && exit 6
        #     fe=$(echo -n "$fn" | sed 's/[][*?\]/\\\0/g')
        #     [ "$bsd" ] && bsdtar --extract --to-stdout \
        #         --file "${FILE_PATH}" -- "$fe" > "${IMAGE_CACHE_PATH}" && exit 6
        #     [ "$bsd" ] || [ "$tar" ] && rm -- "${IMAGE_CACHE_PATH}"
        #     [ "$rar" ] && unrar p -p- -inul -- "${FILE_PATH}" "$fn" > \
        #         "${IMAGE_CACHE_PATH}" && exit 6
        #     [ "$zip" ] && unzip -pP "" -- "${FILE_PATH}" "$fe" > \
        #         "${IMAGE_CACHE_PATH}" && exit 6
        #     [ "$rar" ] || [ "$zip" ] && rm -- "${IMAGE_CACHE_PATH}"
        #     ;;
    esac

    # openscad_image() {
    #     TMPPNG="$(mktemp -t XXXXXX.png)"
    #     openscad --colorscheme="${OPENSCAD_COLORSCHEME}" \
    #         --imgsize="${OPENSCAD_IMGSIZE/x/,}" \
    #         -o "${TMPPNG}" "${1}"
    #     mv "${TMPPNG}" "${IMAGE_CACHE_PATH}"
    # }

    case "${FILE_EXTENSION_LOWER}" in
       ## 3D models
       ## OpenSCAD only supports png image output, and ${IMAGE_CACHE_PATH}
       ## is hardcoded as jpeg. So we make a tempfile.png and just
       ## move/rename it to jpg. This works because image libraries are
       ## smart enough to handle it.
       # csg|scad)
       #     openscad_image "${FILE_PATH}" && exit 6
       #     ;;
       # 3mf|amf|dxf|off|stl)
       #     openscad_image <(echo "import(\"${FILE_PATH}\");") && exit 6
       #     ;;
       drawio)
           draw.io -x "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" \
               --width "${DEFAULT_SIZE%x*}" && exit 6
           exit 1;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        ## RTF and DOC
        text/rtf|*msword)
            ## Preview as text conversion
            ## note: catdoc does not always work for .doc files
            ## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
            catdoc -- "${FILE_PATH}" && exit 5
            exit 1;;

        ## DOCX, ePub, FB2 (using markdown)
        ## You might want to remove "|epub" and/or "|fb2" below if you have
        ## uncommented other methods to preview those formats
        *wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml)
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            exit 1;;

        ## E-mails
        message/rfc822)
            ## Parsing performed by mu: https://github.com/djcb/mu
            mu view -- "${FILE_PATH}" && exit 5
            exit 1;;

        ## XLS
        *ms-excel)
            ## Preview as csv conversion
            ## xls2csv comes with catdoc:
            ##   http://www.wagner.pp.ru/~vitus/software/catdoc/
            xls2csv -- "${FILE_PATH}" && exit 5
            exit 1;;

        ## SQLite
        *sqlite3)
            ## Preview as text conversion
            sqlite_tables="$( sqlite3 "file:${FILE_PATH}?mode=ro" '.tables' )" \
                || exit 1
            [ -z "${sqlite_tables}" ] &&
                { echo "Empty SQLite database." && exit 5; }
            sqlite_show_query() {
                sqlite-utils query "${FILE_PATH}" "${1}" --table --fmt fancy_grid \
                || sqlite3 "file:${FILE_PATH}?mode=ro" "${1}" -header -column
            }
            ## Display basic table information
            sqlite_rowcount_query="$(
                sqlite3 "file:${FILE_PATH}?mode=ro" -noheader \
                    'SELECT group_concat(
                        "SELECT """ || name || """ AS tblname,
                                          count(*) AS rowcount
                         FROM " || name,
                        " UNION ALL "
                    )
                    FROM sqlite_master
                    WHERE type="table" AND name NOT LIKE "sqlite_%";'
            )"
            sqlite_show_query \
                "SELECT tblname AS 'table', rowcount AS 'count',
                (
                    SELECT '(' || group_concat(name, ', ') || ')'
                    FROM pragma_table_info(tblname)
                ) AS 'columns',
                (
                    SELECT '(' || group_concat(
                        upper(type) || (
                            CASE WHEN pk > 0 THEN ' PRIMARY KEY' ELSE '' END
                        ),
                        ', '
                    ) || ')'
                    FROM pragma_table_info(tblname)
                ) AS 'types'
                FROM (${sqlite_rowcount_query});"
            if [ "${SQLITE_TABLE_LIMIT}" -gt 0 ] &&
               [ "${SQLITE_ROW_LIMIT}" -ge 0 ]; then
                ## Do exhaustive preview
                echo && printf '>%.0s' $( seq "${PV_WIDTH}" ) && echo
                sqlite3 "file:${FILE_PATH}?mode=ro" -noheader \
                    "SELECT name FROM sqlite_master
                    WHERE type='table' AND name NOT LIKE 'sqlite_%'
                    LIMIT ${SQLITE_TABLE_LIMIT};" |
                    while read -r sqlite_table; do
                        sqlite_rowcount="$(
                            sqlite3 "file:${FILE_PATH}?mode=ro" -noheader \
                                "SELECT count(*) FROM ${sqlite_table}"
                        )"
                        echo
                        if [ "${SQLITE_ROW_LIMIT}" -gt 0 ] &&
                           [ "${SQLITE_ROW_LIMIT}" \
                             -lt "${sqlite_rowcount}" ]; then
                            echo "${sqlite_table} [${SQLITE_ROW_LIMIT} of ${sqlite_rowcount}]:"
                            sqlite_ellipsis_query="$(
                                sqlite3 "file:${FILE_PATH}?mode=ro" -noheader \
                                    "SELECT 'SELECT ' || group_concat(
                                        '''...''', ', '
                                    )
                                    FROM pragma_table_info(
                                        '${sqlite_table}'
                                    );"
                            )"
                            sqlite_show_query \
                                "SELECT * FROM (
                                    SELECT * FROM ${sqlite_table} LIMIT 1
                                )
                                UNION ALL ${sqlite_ellipsis_query} UNION ALL
                                SELECT * FROM (
                                    SELECT * FROM ${sqlite_table}
                                    LIMIT (${SQLITE_ROW_LIMIT} - 1)
                                    OFFSET (
                                        ${sqlite_rowcount}
                                        - (${SQLITE_ROW_LIMIT} - 1)
                                    )
                                );"
                        else
                            echo "${sqlite_table} [${sqlite_rowcount}]:"
                            sqlite_show_query "SELECT * FROM ${sqlite_table};"
                        fi
                    done
            fi
            exit 5;;

        ## Text
        text/* | */xml)
            ## Syntax highlight
            if [[ "$( stat --printf='%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
                exit 2
            fi
            if [[ "$( tput colors )" -ge 256 ]]; then
                local pygmentize_format='terminal256'
                local highlight_format='xterm256'
            else
                local pygmentize_format='terminal'
                local highlight_format='ansi'
            fi
            env HIGHLIGHT_OPTIONS="${HIGHLIGHT_OPTIONS}" highlight \
                --out-format="${highlight_format}" \
                --force -- "${FILE_PATH}" && exit 5
            env COLORTERM=8bit bat --color=always --style="${BAT_STYLE}" \
                -- "${FILE_PATH}" && exit 5
            pygmentize -f "${pygmentize_format}" -O "style=${PYGMENTIZE_STYLE}"\
                -- "${FILE_PATH}" && exit 5
            exit 2;;

        ## DjVu
        image/vnd.djvu)
            ## Preview as text conversion (requires djvulibre)
            djvutxt "${FILE_PATH}" | fmt -w "${PV_WIDTH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        ## Image
        image/*)
            ## Preview as text conversion
            # img2txt --gamma=0.6 --width="${PV_WIDTH}" -- "${FILE_PATH}" && exit 4
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        ## Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        ## ELF files (executables and shared objects)
        application/x-executable | application/x-pie-executable | application/x-sharedlib)
            readelf -WCa "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

handle_fallback() {
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
}


MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
    handle_image "${MIMETYPE}"
fi
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
