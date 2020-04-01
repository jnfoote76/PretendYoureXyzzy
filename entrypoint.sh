#!/bin/sh

sed -i "s/password=\"changeme\"/password=\"${APP_GUEST_PASSWORD}\"/g" /usr/local/tomcat/conf/tomcat-users.xml

HIBERNATE_PROPS="-Dhibernate.url=jdbc:postgresql://${POSTGRES_HOST}:5432/cah"
/usr/local/tomcat/bin/catalina.sh run "${HIBERNATE_PROPS}"