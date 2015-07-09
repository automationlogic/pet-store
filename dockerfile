FROM tomcat
MAINTAINER Luke Wiltshire <luke@automationlogic.com>

COPY target/jpetstore.war /usr/local/tomcat/webapps/pet-store.war
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

EXPOSE 8080
