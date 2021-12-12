#!/bin/sh

# usage: synchronizes the contents of a file in this desk with the Urbit
# desk referenced by the './cur' directory.
#
# examples:
# $ ./.sync.sh upload gen file.hoon
# > uploads ./gen/file.hoon to ./cur/gen/file.hoon
# $ ./.sync.sh download lib modlib.hoon
# > downloads ./lib/modlib.hoon from ./cur/lib/modlib.hoon
#
# note: this file is used by the 'VimSync' plugin to automatically manage
# file synchronize on file read/write

## Argument Handling ##

BASE_PATH=$(dirname $0)
DESK_PATH=$(readlink -f "$BASE_PATH/cur")
IGNORE_PATH=$(readlink -f "$BASE_PATH/.syncignore")
SESSION_NAME="urbit"

sync_type="$1"
file_path="$2/$3"

## Script Processing ##

git check-ignore -q "$file_path" && exit 0
grep -xq "$file_path" "$IGNORE_PATH" && exit 0

cd $BASE_PATH

[ $sync_type == 'upload' ] && rsync -cuL --relative "$file_path" "$DESK_PATH" && \
    tmux has-session -t ${SESSION_NAME} 2>/dev/null && \
    tmux send-keys -t ${SESSION_NAME}.bottom "|commit %base" "ENTER";
[ $sync_type == 'download' ] && rsync -cuL "$DESK_PATH/$file_path" "$file_path"

cd -
