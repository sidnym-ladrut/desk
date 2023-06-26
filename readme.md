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

These commands will upload one or more files to the desk pointed to by the symbolic
link `cur`:

#### Entire Desk ####

```shell
./.sync.sh upload .
```

#### Single File ####

```shell
./.sync.sh upload path/to file.hoon
```
