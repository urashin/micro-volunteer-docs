#!/bin/bash
    echo "`date '+%Y-%m-%d %H:%M:%S'` START: Certificate renewal )"

    cd /home/ec2-user/micro_volunteer_install/micro-volunteer-docs/300_Environment/docker-webserver || exit 1

    nyan=$(docker-compose -f docker-compose-nginx.yml run certbot certonly --force-renewal --webroot -w /var/www/html -d micro-volunteer-supporter.com --post-hook="echo nyan" 2>&1)

    if echo "${nyan}" | grep -q "nyan"; then
        docker-compose -f docker-compose-nginx.yml exec -T nginx nginx -s reload
    fi
    echo "`date '+%Y-%m-%d %H:%M:%S'` END  :  Certificate renewal )"
