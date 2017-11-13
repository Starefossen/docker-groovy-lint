#!/bin/sh

java -classpath "${GROOVY_JAR}:${CODENARC_JAR}:${SLF4J_JAR}" org.codenarc.CodeNarc $@
