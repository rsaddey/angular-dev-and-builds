#!/bin/sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
# trap "echo TRAPed signal" HUP INT QUIT TERM

# start service in background BEFORE running passed whatsoever
service xvfb start

# TODO experimentally hacked
x11vnc -shared -display WAIT:99 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &
cd /root/noVNC && ln -s vnc_auto.html index.html && ./utils/launch.sh --vnc localhost:5900 &

# echo Running $@
$@

## echo "[hit enter key to exit] or run 'docker stop <container>'"
## read

# stop service and cleanup AFTER having run passed whatsoever
service xvfb stop

echo "exited $0"
