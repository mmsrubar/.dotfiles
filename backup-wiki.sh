#!/bin/bash
#
# Create backup of my personal wiki, downloaded it and all that from an external
# server using SSH. A password less access to the server over SSH is expected.

SERVER=192.168.0.42
USER=msrubar

DIR=/var/www/personal_wiki/   # dir to backup
DATE=`date +%F`               # get current date
NAME=personal-wiki            # basic name of the backup file
FILE=$NAME-$DATE.tar.bz2      # backup file

ssh $USER@$SERVER sudo tar cvjf $FILE $DIR
scp $USER@$SERVER:~/$FILE .
ssh $USER@$SERVER rm $FILE
