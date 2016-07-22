#!/bin/sh

if [ "$DOCS_URL" ]; then
    echo "Setting DOCS_URL to $DOCS_URL"
    sed -ri "s~DOCS_URL~$DOCS_URL~" /usr/share/nginx/html/index.html    
fi

if [ "$APP_URL" ]; then
    echo "Setting APP_URL to $APP_URL"
    sed -ri "s~APP_URL~$APP_URL~" /usr/share/nginx/html/index.html  
fi

exec "$@"
