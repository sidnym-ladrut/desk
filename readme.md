## Urbit Desk Repository ##

This repository contains files that can be trivially `rsync`'d to a live Urbit desk.

### Sync Instructions ###

- All Contents:
  ```
  rsync -uLrvP --filter="- .*" ./ /path/to/urbit/desk
  ```
- Single File/Pattern:
  ```
  rsync -uLrvPm --filter="+ file.hoon" --filter="+ */" --filter="- *" ./ /path/to/urbit/desk
  ```
