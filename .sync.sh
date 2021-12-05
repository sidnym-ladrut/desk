#!/bin/sh

base_path=$(dirname $0)
file_path="$2/$3"
desk_path=$(readlink -f "$base_path/cur")
ignore_path=$(readlink -f "$base_path/.syncignore")

git check-ignore -q "$file_path" && exit 0
grep -xq "$file_path" "$ignore_path" && exit 0

cd $base_path

[ 'upload' == $1 ] && rsync -cuL --relative "$file_path" "$desk_path"
[ 'download' == $1 ] && rsync -cuL "$desk_path/$file_path" "$file_path"

cd -
