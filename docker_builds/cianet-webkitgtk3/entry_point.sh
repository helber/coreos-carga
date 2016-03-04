#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
function shutdown {
    kill -s SIGTERM $NODE_PID
    wait $NODE_PID
}
let "DELAY += 1"
let "DELAY -= 1"
if [[ ${DELAY-0} != 0 ]];then
    sleep ${DELAY}
fi
sudo -E -i -u seluser \
    DISPLAY=$DISPLAY \
    xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" \
    /usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/MiniBrowser --enable-fullscreen=true \
    $IPTV_ARGS \
    --user-agent="serial=$IPTV_SERIAL;mac=$IPTV_MAC;" "http://${IPTV_HOST}${IPTV_PATH}" &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
for i in $(seq 1 10)
do
    xdpyinfo -display $DISPLAY >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        break
    fi
    echo Waiting xvfb...
    sleep 0.5
done

wait $NODE_PID
