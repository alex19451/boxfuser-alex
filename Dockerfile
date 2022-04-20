FROM tomcat:9.0

WORKDIR /usr/local/tomcat/webapps/

COPY java-tomcat-maven-example.war ./

CMD ["catalina.sh", "run"]
