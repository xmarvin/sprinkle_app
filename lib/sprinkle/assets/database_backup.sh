#!/bin/sh
MYSQL_USER=deploy
MYSQL_PASSWORD=zE3esWUd
MYSQL_DATABASE=surepod
BACKUPPATH=/data/backups/
S3_BUCKET=test_backups


IP=""
OS=`uname`
case $OS in
  Linux) IP=`ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{ print $2} ' | cut -d/ -f1`;;
  FreeBSD|OpenBSD) IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;;
  SunOS) IP=`ifconfig -a | grep inet | grep -v '127.0.0.1' | awk '{ print $2} '` ;;
  *) IP="Unknown";;
esac

mkdir -p /data/backups/db
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE | gzip -9 > $BACKUPPATH/db/$MYSQL_DATABASE-$(date -I).sql.gz

mkdir -p /data/backups/application

cd /data/surepod

tar -zcf "/data/backups/application/current-$(date -I).tar.gz" current/*
tar --exclude=log --exclude=bundle --exclude=cached-copy --exclude=pids -zcf "/data/backups/application/shared-$(date -I).tar.gz" shared/*

find $BACKUPPATH -type f -mtime +30 -delete

s3sync -r -p --make-dirs $BACKUPPATH $S3_BUCKET:/$IP
