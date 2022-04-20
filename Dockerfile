FROM tomcat:9.0

WORKDIR /usr/local/tomcat/webapps/

COPY /target/*.war ./

CMD ["catalina.sh", "run"]
