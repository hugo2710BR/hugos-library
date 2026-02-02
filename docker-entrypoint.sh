#!/bin/sh

envsubst < /usr/share/nginx/html/env-config.js > /usr/share/nginx/html/env-config.tmp.js
mv /usr/share/nginx/html/env-config.tmp.js /usr/share/nginx/html/env-config.js

exec nginx -g "daemon off;"
