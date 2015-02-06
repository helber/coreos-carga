#!/bin/bash

export HOME=/root

fluxbox -display $DISPLAY &

x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &
