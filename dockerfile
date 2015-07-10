FROM tomcat
MAINTAINER Luke Wiltshire <luke@automationlogic.com>


RUN curl http://10.41.0.146:8887/job/pet-store/ws/target/jpetstore.war -o "/usr/local/tomcat/webapps/pet-store.war"
RUN curl http://10.41.0.146:8887/job/pet-store/ws/tomcat-users.xml -o "/usr/local/tomcat/conf/tomcat-users.xml"


EXPOSE 8080
