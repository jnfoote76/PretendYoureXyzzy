FROM maven:3.6.3-jdk-8 as build
COPY app /src
WORKDIR /src
RUN mvn clean package war:war

FROM tomcat:7.0.103-jdk8-openjdk
COPY tomcat/server.xml /usr/local/tomcat/conf/
COPY tomcat/tomcat-users.xml /usr/local/tomcat/conf/
RUN mkdir /usr/local/tomcat/webapps/ROOT
COPY tomcat/index.jsp /usr/local/tomcat/webapps/ROOT/
COPY --from=build /src/target/ZY.war /usr/local/tomcat/webapps/ZY.war
COPY entrypoint.sh /entrypoint.sh

CMD ["/bin/sh"]