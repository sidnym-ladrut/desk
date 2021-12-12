#!/bin/sh

# usage: starts up a TMUX session for an Urbit coding session for
# the desk referenced by './cur' (plays nicely with '.sync.sh')
#
# examples:
# $ ./.tmux.sh
# > starts session at 'urbit', leaving any existing sessions
# $ ./.tmux.sh -s backup -r
# > starts session at 'backup', forcefully restarting any existing session

## Argument Handling ##

while : ; do case ${1} in
	-h | --help)
		printf "extra arguments for custom use:\\n"
		printf "  -s/--session: the name of the tmux session to be started\\n"
		printf "  -r/--restart: flag to restart existing sessions (default: keep session)\\n"
		printf "  -h/--help: show this message\\n"
		exit 1 ;;
	-s | --session) session_name="${2}" && shift 2 ;;
	-r | --restart) do_restart="true" && shift 1 ;;
	-* | --*) printf "invalid option: %s\\n" "${1}" && exit 1 ;;
	*) break ;;
esac done

[ -z "$session_name" ] && session_name="urbit"
[ -z "$do_restart" ] && do_restart="false"

BASE_PATH=$(dirname $0)
DESK_PATH=$(readlink -f "$BASE_PATH/cur")
START_STR="tmux attach -t $session_name"

## Script Processing ##

[ $do_restart == 'true' ] && tmux has-session -t $session_name 2>/dev/null && \
    tmux kill-session -t $session_name
[ $do_restart == 'false' ] && tmux has-session -t $session_name 2>/dev/null && \
    echo "session exists; start with '$START_STR'" && exit 0

stty_size="$(stty size)"
stty_x=$(echo $stty_size | awk '{ print $2; }')
stty_y=$(echo $stty_size | awk '{ print $1; }')
tmux new-session -d -s $session_name -x "$stty_x" -y "$(($stty_y - 1))"
tmux select-window -t $session_name:0
tmux split-window -v -l 20
tmux select-pane -t 1
tmux send-keys "cd $(readlink -f ./cur); cd ..; ../bin/v1.8/urbit ./" C-m
tmux select-pane -t 0
tmux send-keys "vim ./" C-m

echo "session started; start with '$START_STR'" && exit 0
