#!/usr/bin/env bash

set -e

env=${APP_ENV:=production}
role=${CONTAINER_ROLE:=app}
phpXdebug=${PHP_XDEBUG:=false}

if [ "$env" != "local" ]; then
    echo "Caching configuration..."
    (cd /var/www/html && php artisan config:cache && php artisan route:cache)
fi

if [ "$phpXdebug" != true ]; then
    echo "Removing Xdebug..."
    rm -rf /usr/local/etc/php/conf.d/{docker-php-ext-xdebug,xdebug}.ini
fi

# if [ "$env" == "local" ] && [ ! -z "$DEV_UID" ]; then
#     echo "Changing www-data UID to $DEV_UID"
#     echo "The UID should only be changed in development environments."
#     usermod -u $DEV_UID www-data
# fi

if [ "$role" == "app" ]; then
    ln -sf /etc/supervisor/conf.d-available/app.conf /etc/supervisor/conf.d/app.conf
elif [ "$role" == "queue" ]; then
    ln -sf /etc/supervisor/conf.d-available/queue.conf /etc/supervisor/conf.d/queue.conf
elif [ "$role" == "scheduler" ]; then
    ln -sf /etc/supervisor/conf.d-available/scheduler.conf /etc/supervisor/conf.d/scheduler.conf
else
    echo "Could not match the container role \"$role\""
    exit 1
fi

exec supervisord -c /etc/supervisor/supervisord.conf
