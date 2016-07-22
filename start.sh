#!/bin/bash

# Source sysconfig file
. /etc/sysconfig/PlexMediaServer

PID_FILE=$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex\ Media\ Server/plexmediaserver.pid
[[ -f "$PID_FILE" ]] && rm -f "$PID_FILE"

if [ ! -f "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" ];
then
    su -s /bin/sh $PLEX_USER -c 'mkdir -p "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" > /dev/null 2>&1'
    if [ ! $? -eq 0 ]; then
        echo "WARNING COULDN'T CREATE $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR, MAKE SURE I HAVE PERMISSON TO DO THAT!"
        exit 1
    fi
fi
echo "Plex Media Server is started"
cd $PLEX_MEDIA_SERVER_HOME
./Plex\ Media\ Server &
tail -f $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex\ Media\ Server/Logs/PMS\ Plugin\ Logs/*
