FROM tomcat
MAINTAINER Luke Wiltshire <luke@automationlogic.com>

ADD target/jpetstore.war /usr/local/tomcat/webapps/pet-store.war
ADD tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

EXPOSE 8080
