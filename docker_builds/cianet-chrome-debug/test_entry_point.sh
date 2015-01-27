#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
if [ "$IPTV_DISABLE_CACHE" == "true" ]; then
    export IPTV_NO_CACHE="--disk-cache-size=1 --media-cache-size=1  --disable-simple-cache --disable-cache"
fi
function shutdown {
    kill -s SIGTERM $NODE_PID
    wait $NODE_PID
}

DISPLAY=$DISPLAY \
echo xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" \
google-chrome --start-fullscreen \
--disable-default-apps --no-first-run \
$IPTV_NO_CACHE $IPTV_ARGS \
--user-agent="serial=$IPTV_SERIAL;mac=$IPTV_MAC;" "http://$IPTV_HOST/$IPTV_PATH" &

trap shutdown SIGTERM SIGINT
