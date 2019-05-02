FROM maven:3-jdk-8

EXPOSE 8085
WORKDIR /opt/oidc/
RUN mkdir -p /opt/oidc
#ADD . /opt/oidc/
COPY target/springboot1-oidc-sample-0.0.1-SNAPSHOT.jar /opt/oidc/springboot1-oidc-sample-0.0.1-SNAPSHOT.jar
RUN adduser oidc --disabled-password --gecos "OIDC Service Account"
#RUN chmod 777 /opt/oidc/entrypoint.sh
RUN chown -R 1000:1000 /opt/oidc
#RUN su -c "/usr/share/maven/bin/mvn -Dmaven.test.skip=true install" oidc
#RUN su -c "/usr/share/maven/bin/mvn dependency:resolve-plugins" oidc
#ENTRYPOINT ["/bin/bash", "/opt/oidc/entrypoint.sh"]
ENTRYPOINT ["java","-jar","springboot1-oidc-sample-0.0.1-SNAPSHOT.jar"]