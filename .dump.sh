#!/bin/sh

# usage: dumps via rsync a set of files in this tree to a set of trees
# (plays nicely with '.sync.sh')
#
# examples:
# $ ./.dump.sh
# $ ./.dump.sh -f "app/*"
# $ ./.dump.sh -t /path/to/desk/
# $ ./.dump.sh -f "app/*" -t /path/to/desk/
# $ ./.dump.sh -f "app/*" -f "mar/*" -t /path/to/desk/1/ -t /path/to/desk/2/

shopt -s extglob

## Argument Handling ##

while : ; do case ${1} in
	-h | --help)
		printf "extra arguments for custom use:\\n"
		printf "  -f/--from: the names of the source files/paths to dump\\n"
		printf "  -t/--to: the bases of the trees (dirs) to dump to\\n"
		printf "  -h/--help: show this message\\n"
		exit 1 ;;
	-f | --from) from_list="$from_list;$2" && shift 2 ;;
	-t | --to) to_list="$to_list;$2" && shift 2 ;;
	-* | --*) printf "invalid option: %s\\n" "$1" && exit 1 ;;
	*) break ;;
esac done

BASE_PATH=$(dirname $0)
DESK_PATH=$(readlink -f "$BASE_PATH/cur")
META_PATH=$(readlink -f "$DESK_PATH/../../")
IGNORE_FILE=$(readlink -f "$BASE_PATH/.syncignore")

[ -z "$from_list" ] && from_list=";$BASE_PATH/*"
[ -z "$to_list" ] && to_list=";$META_PATH/*/*"

from_list=$(echo $from_list | sed '1s/^.//')
to_list=$(echo $to_list | sed '1s/^.//')

## Script Processing ##

# TODO: This solution doesn't work if any arguments contain file names
# with spaces.
for from_glob in $(echo $from_list | sed "s/;/ /g") ; do
    for from_file in $from_glob ; do
        git check-ignore -q "$from_file" || \
        grep -xq "$from_file" "$IGNORE_FILE" || \
        for to_glob in $(echo $to_list | sed "s/;/ /g") ; do
            for to_file in $to_glob ; do
                [ -d "$to_file" ] && \
                [ -f "$to_file/sys.kelvin" ] && \
                echo "$from_file->$to_file" && \
                rsync -rcuL --relative "$from_file" "$to_file" >/dev/null 2>&1
            done
        done
    done
done
