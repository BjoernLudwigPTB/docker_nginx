# Nginx Docker image

This repository holds the configuration for a Docker image based on
*nginx*, which serves an application either solely over SSL including a rewrite
of all served URLs to `https://...` or just the way it is.

# Build process
The build process is comprised of few steps.

## Copy default config
Copy [`app.conf`](./app.conf) to `/etc/nginx/conf.d/app.conf` of the image to
set some default settings and allow for the change via `docker-entrypoint.sh`
which is copied during the next step.

## Copy script to enable application set up
Copy [`docker-entrypoint.sh`](./docker-entrypoint.sh) to the root directory of
the image to enable the setup process of the connection to the application on
container startup

# Environment variables
During container start there are several optional environment variables
available to connect to an existing app in the network and serve it at a specified address. The following list
mentions the default values if not explicitly specified differently during container start up.

## Available environment variables
`SSL = 'false'`: Indicate if the application shall be served solely over SSL or
  not. Mixed content will possibly not work correctly if set to `'false'`.

`SERVER_NAME = 'localhost'`: The full URL over which the application will be
  served including subfolders.

`UPSTREAM_HANDLE ='0.0.0.0'`: The application's ip or address in the network.

`UPSTREAM_PORT = '80'`: The applications port at its address in the network.
