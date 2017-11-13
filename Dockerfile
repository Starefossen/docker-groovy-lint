FROM groovy:2.4.12-jre8-alpine

USER root:root

ENV CODENARC_VERSION 1.0
ENV GROOVY_VERSION 2.4.12
ENV SLF4J_VERSION 1.7.25

ENV CODENARC_JAR /home/groovy/CodeNarc-${CODENARC_VERSION}.jar
ENV GROOVY_JAR ${GROOVY_HOME}/embeddable/groovy-all-${GROOVY_VERSION}.jar
ENV SLF4J_JAR /home/groovy/slf4j-${SLF4J_VERSION}/slf4j-api-${SLF4J_VERSION}.jar

COPY entrypoint.sh /home/groovy/entrypoint.sh

RUN apk add --no-cache --virtual .build-deps curl \

 # Download CodeNarc
 && curl -vOL "https://netix.dl.sourceforge.net/project/codenarc/codenarc/CodeNarc%20${CODENARC_VERSION}/CodeNarc-${CODENARC_VERSION}.jar" \

 # Download slf4j
 && curl -vOL https://www.slf4j.org/dist/slf4j-${SLF4J_VERSION}.tar.gz \
 && tar -xzf slf4j-${SLF4J_VERSION}.tar.gz \
 && rm slf4j-${SLF4J_VERSION}.tar.gz \

 # Remove build dependencies
 && apk del .build-deps \
 && chown -R groovy:groovy .

USER groovy:groovy

ENTRYPOINT ["/home/groovy/entrypoint.sh"]
