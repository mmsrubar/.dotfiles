#!/bin/bash
#
# Create backup of my personal wiki, downloaded it and all that from an external
# server using SSH. A password less access to the server over SSH is expected.
#

SERVER=dokuwiki               # defined in /etc/hosts and ssh config

DIR=/var/www/personal_wiki/   # dir to backup
DATE=`date +%F`               # get current date
NAME=personal-wiki            # basic name of the backup file
FILE=$NAME-$DATE.tar.bz2      # backup file

OPTIONS="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

ssh $OPTIONS $SERVER sudo tar cvjf $FILE $DIR
scp $OPTIONS $SERVER:~/$FILE .
ssh $OPTIONS $SERVER rm $FILE
