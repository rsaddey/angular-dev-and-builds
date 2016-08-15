#!/bin/sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
# trap "echo TRAPed signal" HUP INT QUIT TERM


# start something
# TODO experimentally hacked

rm -f /tmp/.X99-lock && /usr/bin/Xvfb :99 -screen 0 1280x780x24 -ac &
x11vnc -q -shared -display WAIT:99 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &
cd /root/noVNC && ./utils/launch.sh --vnc localhost:5900 &

echo Running "$@"
eval "$@"

## echo "[hit enter key to exit] or run 'docker stop <container>'"
## read

# stop something and cleanup

echo "exited $0"
