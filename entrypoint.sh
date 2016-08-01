#!/bin/sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
# trap "echo TRAPed signal" HUP INT QUIT TERM

# start service in background BEFORE running passed whatsoever
service xvfb start

# echo Running $@
$@

## echo "[hit enter key to exit] or run 'docker stop <container>'"
## read

# stop service and cleanup AFTER having run passed whatsoever
service xvfb stop

echo "exited $0"
