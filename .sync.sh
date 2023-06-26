#!/bin/sh

# usage: synchronizes the contents of a file or directory in this desk with the
# Urbit desks referenced by the symlinks in the './cur' directory, pushing a
# `|commit` (and `|nuke` for app and sur files) to all Urbit tmux sessions
# (i.e. those named `urbit*`).
#
# examples:
#
# $ ./.sync.sh upload gen file.hoon
# > uploads ./gen/file.hoon to ./cur/*/gen/file.hoon
#
# $ ./.sync.sh download lib modlib.hoon
# > downloads ./lib/modlib.hoon from ./cur/*/lib/modlib.hoon
#
# note: this file is used by the 'VimSync' plugin to automatically manage
# file synchronize on file read/write (see: https://github.com/eshion/vim-sync)

## Argument Handling ##

BASE_PATH=$(dirname $0)
APP_NAMES=$(find $BASE_PATH/app -type f -name "*.hoon" -exec basename {} .hoon \;)
DESK_PATHS=$(find "$BASE_PATH/cur/" -type l -exec readlink -f {} \;)

sync_type="$1"
file_path="$2/$3"

## Script Processing ##

cd $BASE_PATH >/dev/null 2>&1

[ $sync_type == "upload" ] &&
	#for session in "$(tmux ls | grep -o $TMUX_WILDCARD)"; do
	for desk_path in $DESK_PATHS; do
		desk_name=$(basename $desk_path)
		ship_name=$(basename $(dirname $desk_path))
		sesh_name="urbit-${ship_name}"

		# FIXME: Would prefer ":,-n /.gitignore" to use all gitignores in recursive
		# subdirectories, but I can't get it to work.
		# (see: https://unix.stackexchange.com/a/168602)
		echo "syncing $file_path into /~$ship_name/%$desk_name..."
		rsync -rcuL -f ". $BASE_PATH/.rsync-filter" -f ".,-n $BASE_PATH/.gitignore" \
			--relative "$file_path" "$desk_path"

		tmux has-session -t $sesh_name 2>/dev/null && {
			tmux select-window -t "$desk_sesh:0"
			echo "$2" | grep -q -e "^app" -e "^sur" &&
				for app in $APP_NAMES; do
					tmux send-keys "|nuke %$app" C-m
				done
			tmux send-keys "|commit %$desk_name" C-m
			echo "$2" | grep -q -e "^app" -e "^sur" &&
				for app in $APP_NAMES; do
					tmux send-keys "|revive %$app" C-m
				done
		}
	done
[ $sync_type == "download" ] && {
	desk_path="${DESK_PATHS}"
	rsync -rcuL -f ". $BASE_PATH/.rsync-filter" -f ".,-n $BASE_PATH/.gitignore" \
		"$desk_path/$file_path" "$file_path"
}

cd - >/dev/null 2>&1
