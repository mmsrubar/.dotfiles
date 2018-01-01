#!/bin/bash


BACKUP_DIR=/run/media/msrubar/ext_data/backup/laptop-incremental/

rsync -avz \
  --exclude $HOME/.mozilla \
  --exclude $HOME/.cache/google-chrome-beta \
  --exclude $HOME/.cache/mozilla \
  --exclude=*.vdi \
  $HOME/* $BACKUP_DIR
