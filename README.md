Pretend You're Xyzzy
===================

A Cards Against Humanity clone, server and web client. See app/WebContent/license.html for full details.

Note: This project is only known to work with Tomcat 7, all other versions are unsupported. 
Currently, the only way to build PYX is using Maven via ```mvn clean package war:war``` in the project's directory.


If you're doing ```mvn clean package war:exploded jetty:run```, you now need to add ```-Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false``` to make the buildnumber plugin allow you to run with uncommited changes.


For GeoIP functions to work, download http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz somewhere, gunzip it, and update the geoip.db value in build.properties to point to it.

## 3rd Party Usage

### With Docker

#### Building
```sh
# From the root of the repo
docker build -t jnfoote76/pretendyourexyzzy:<insert-version-here> .
```

#### Starting app
```sh
# From the root of the repo
docker run --rm -it -e APP_GUEST_PASSWORD=<some-password>
```

### With Maven (and Tomcat)
```sh
# From the root of the repo
cd app

# After you do this, probably consider editing
mvn clean package war:war
```