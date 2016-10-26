#!/bin/bash


# Test out picard's help message
/opt/ccdg/jdk-8u111/bin/java -jar /opt/ccdg/picard-2.4.1/picard.jar

# Test out cowsay
name=$(whoami)
cowsay "Howdy Pardner ${name}!"
