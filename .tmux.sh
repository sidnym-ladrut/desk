#!/bin/sh

# usage: starts up a tmux session for an Urbit ship at the desk referenced by
# a symlink in './cur' (plays nicely with '.sync.sh')
#
# examples:
#
# $ ./.tmux.sh
# > starts session at 'urbit-*' (entry in ./cur), leaving any existing sessions
#
# $ ./.tmux.sh -r zod
# > starts session at 'urbit-zod', forcefully restarting any existing session

## Argument Handling ##

while : ; do case ${1} in
	-h | --help)
		printf "positional arguments:\\n"
		printf "  ship: (optional) name for the user (default: any entry in ./cur)\\n"
		printf "extra arguments for custom use:\\n"
		printf "  -r/--restart: flag to restart existing sessions (default: keep session)\\n"
		printf "  -h/--help: show this message\\n"
		exit 1 ;;
	-r | --restart) do_restart="true" && shift 1 ;;
	-* | --*) printf "invalid option: %s\\n" "${1}" && exit 1 ;;
	*) break ;;
esac done

BASE_PATH=$(dirname $0)

[ -z "$do_restart" ] && do_restart="false"
[ -z "$1" ] \
	&& ship_name="$(find "$BASE_PATH/cur/" -type l)" \
	|| ship_name="$1"

desk_link="$BASE_PATH/cur/$ship_name"
desk_path=$(readlink -f "$desk_link")
[ ! -h "$desk_link" -o ! -d "$desk_path" ] \
	&& echo "desk path is invalid; check ship path and run 'ln -s /path/to/ship $BASE_PATH/cur/ship'" \
	&& exit 1
desk_sesh="urbit-$ship_name"
tmux_cmd="tmux attach -t $desk_sesh"

# TODO: Automate the process of creating a desk for a ship
# - if symlink points to a blank under a real ship, boot the ship and do:
#   ```
#   |new-desk %desk
#   |mount %desk
#   ```
# - if the symlink points to a bad ship, create a ship if no dir exists,
#   then do the above
# - add support for default ship directory (for me, ~/doc/urbit/ship)

## Script Processing ##

[ $do_restart == 'true' ] && tmux has-session -t $desk_sesh 2>/dev/null \
	&& tmux kill-session -t $desk_sesh
[ $do_restart == 'false' ] && tmux has-session -t $desk_sesh 2>/dev/null \
	&& echo "tmux session exists; start with:" \
	&& echo "$tmux_cmd" \
	&& exit 0

tmux set-option -g history-limit 1000000 \; new-session -d -s "$desk_sesh" \
	&& tmux select-window -t $desk_sesh:0 \
	&& tmux send-keys "urbit -L $(readlink -f "$desk_path/..")" C-m \
	&& echo "tmux session started; start with:" \
	&& echo "$tmux_cmd" \
	&& exit 0
