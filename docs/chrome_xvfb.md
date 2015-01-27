#!/bin/bash

export SCREEN_WIDTH=1280
export SCREEN_HEIGHT=800
export CHROME_DEVEL_SANDBOX="/opt/google/chrome/chrome_sandbox"

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}
# google-chrome --fullscreen
sudo -E -i -u seluser \
  DISPLAY=$DISPLAY \
  xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" \
  google-chrome --kiosk \
  --disk-cache-size=1 --media-cache-size=1  --disable-simple-cache --disable-cache \
  --user-agent="serial=Eder;mac=FF:00:00:00:00:97;" "http://10.0.0.20/debug/?profile_test=guide_programmes#repg" &
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

fluxbox -display $DISPLAY &

x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &
wait $NODE_PID





# google-chrome --fullscreen
sudo -E -i -u seluser \
xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" \
/opt/google/chrome/chrome_sandbox --kiosk \
--disk-cache-size=1 --media-cache-size=1  --disable-simple-cache --disable-cache \
--user-agent="serial=Eder;mac=FF:00:00:00:00:97;" "http://10.0.0.20/debug/?profile_test=guide_programmes#repg" &
