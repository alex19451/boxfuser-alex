FROM tomcat:9.0-jre8-alpine

WORKDIR /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
