#!/bin/bash

PMS_BIN="Plex Media Server"

PROG="PlexMediaServer"
CONFIG="/etc/sysconfig/$PROG"

# Source config
. $CONFIG

if [ ! -f "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" ];
then
    su -s /bin/sh $PLEX_USER -c 'mkdir -p "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" > /dev/null 2>&1'
    if [ ! $? -eq 0 ]; then
        echo "WARNING COULDN'T CREATE $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR, MAKE SURE I HAVE PERMISSON TO DO THAT!"
        exit 1
    fi
fi
echo "$PMS_BIN is started"
cd $PLEX_MEDIA_SERVER_HOME && ./Plex\ Media\ Server && tail -f $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Library/Application Support/Plex Media Server/Logs/*
