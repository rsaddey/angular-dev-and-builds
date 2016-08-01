#!/bin/sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT TERM

# start service in background here
service xvfb start

# echo Running $@
$@

## echo "[hit enter key to exit] or run 'docker stop <container>'"
## read

# stop service and clean up here
service xvfb stop

echo "exited $0"
