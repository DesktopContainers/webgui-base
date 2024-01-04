#!/bin/bash

cat <<EOF
################################################################################

Welcome to the desktopcontainers/base-debian

################################################################################

EOF

INITALIZED="/.initialized"

if [ ! -f "$INITALIZED" ]; then
  echo ">> CONTAINER: starting initialisation"
  
  echo ">> CONTAINER: added environment vars to /etc/environment"
  env | grep -v HOME | grep -v PWD | grep -v SHLVL  >> /etc/environment

  if [ "$ENABLE_SUDO" = "enable" ];
  then
    echo ">> CONTAINER: enable sudo for user app"
    echo 'app ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/app
  else
    echo ">> CONTAINER: remove sudo from container"
    find /usr /etc /lib -iname *sudo* -exec rm -rf {} \;
  fi

  [ "$ENABLE_KIOSK" = "enable" ] && echo ">> CONTAINER: enable Kiosk-Mode" && echo -e '#!/bin/sh\nexport DISPLAY=:0\nexec /usr/local/bin/app' > /container/config/runit/windowmanager/run

  # INIT PHASE

  touch "$INITALIZED"
else
  echo ">> CONTAINER: already initialized"
fi

# update app
cp /container/scripts/app /usr/local/bin/app

# PRE-RUN PHASE

##
# CMD
##
echo ">> CMD: exec docker CMD"
echo "$@"
exec "$@"
