#!/bin/sh

sed -i "s/password=\"changeme\"/password=\"${APP_GUEST_PASSWORD}\"/g" /usr/local/tomcat/conf/tomcat-users.xml
/usr/local/tomcat/bin/catalina.sh run