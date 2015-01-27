opa
/opt/google/chrome/chrome --user-agent="serial=Eder;mac=FF:00:00:00:00:97;" http://10.5.0.97/d?test=true#tv/1
estou testando assim
mas abrem abas e o user-agent é um por instância

criei uma branch origin/feature/load_testing
pode testar assim http://10.5.0.97/d/?profile_test=guide_programmes#repg

## Cache
--disk-cache-size=1 --media-cache-size=1  --disable-simple-cache --disable-cache


/usr/bin/xvfb-run --server-args=":99.0 -screen 0 1280x800x24 -ac +extension RANDR" \
/opt/google/chrome/chrome --user-agent="serial=Eder;mac=FF:00:00:00:00:97;" "http://10.0.0.20/debug/?profile_test=guide_programmes#repg" &

fluxbox -display $DISPLAY &

x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &

"Env": [
"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
"DEBIAN_FRONTEND=noninteractive",
"DEBCONF_NONINTERACTIVE_SEEN=true",
"TZ=\"US/Pacific\"",
"SCREEN_WIDTH=1360",
"SCREEN_HEIGHT=1020",
"SCREEN_DEPTH=24",
"DISPLAY=:99.0",
"CHROME_DRIVER_VERSION=2.13"
],
