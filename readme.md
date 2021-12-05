## Urbit Desk Repository ##

This repository contains files that can be trivially `rsync`'d to a live Urbit desk.

### Automatic Sync Instructions ###

Using the `vim` plugin [`vim-sync`](https://github.com/eshion/vim-sync/), file
synchronization occurs automatically on file overwrite. The sync destination is
set to be the target of the `cur` symbolic link in the top-level directory, so
this link should point to the destination ship for Urbit files.

See the contents of the `.sync.sh` file for information on how file synchronization
is performed.

### Manual Sync Instructions ###

- All Contents:
  ```
  rsync -uLrvP --filter="- .*" ./ ./cur/
  ```
- Single File/Pattern:
  ```
  rsync -uLrvPm --filter="+ file.hoon" --filter="+ */" --filter="- *" ./ ./cur/
  ```
