#!/bin/bash
set -e

# This entrypoint script is an adaption of the awesom script found here:
# https://github.com/BjoernLudwigPTB/dockerfiles/blob/master/etherpad-lite/entrypoint.sh
# to the application nginx.

# Indicate if the application shall be served solely over SSL or not.
# Mixed content will possibly not work correctly if set to `false`.
: ${SSL:=false}

# The full URL over which the application will be served including subfolders
: ${SERVER_NAME:=localhost}

# The application's ip or address in the network.
: ${UPSTREAM_HANDLE:=0.0.0.0}

# The applications port at its address in the network.
: ${UPSTREAM_PORT:=80}

if [ "$SSL" = 'true' ]; then
  sed -i \
      -e 's/#fastcgi_param HTTPS on;/fastcgi_param HTTPS on;/g' \
      /etc/nginx/conf.d/app.conf
fi
sed -i \
    -e 's/server UPSTREAM_HANDLE:UPSTREAM_PORT;/server "'$UPSTREAM_HANDLE'":"'$UPSTREAM_PORT'";/g' \
    -e 's/server_name SERVER_NAME;/server_name "'$SERVER_NAME'";/g' \
    /etc/nginx/conf.d/app.conf

nginx -g daemon off;
