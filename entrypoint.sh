#!/bin/sh
mkdir -p /data/processed
chmod 777 /data /data/processed
cd /data
while true; do
    SLEEPCHECK=`ls /data | grep .URL`
    while [ -z "$SLEEPCHECK" ]; do
        echo Waiting 60 seconds before checking for new URLs...
        sleep 60
        SLEEPCHECK=`ls /data | grep .URL`
    done
    
    for URLFILE in /data/*.URL; do
        URL=`grep -i "URL=" "$URLFILE" | sed 's/URL=//g'`
        echo "Attempting to download $URL"
        youtube-dl --no-progress --write-thumbnail --exec "ffmpeg -i {} -vn -acodec copy {}.opus" "$URL"
        mv "$URLFILE" processed/
        chmod -R +rw /data
    done
done
