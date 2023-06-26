#!/bin/bash

# Compilation of hasNext example file
javac HasNext_1.java
jar cfm hasNext.jar manifest.txt HasNext_1.class 

# Generate .aj and .rmv files
mkdir aj-files 2>/dev/null
rm aj-files/* 2>/dev/null
javamop -v -merge -d aj-files/ mop-files/*
mv mop-files/*.rvm aj-files/   

# Generate monitor classes from the .rvm files
export CLASSPATH=$(pwd)/../rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar:/usr/share/java/aspectjrt.jar:/usr/share/java/aspectjtools.jar
mkdir -p aj-files/classes/mop
cd aj-files
rv-monitor -merge -d classes/mop *.rvm 

# Compile monitor classes
javac classes/mop/*.java
rm classes/mop/*.java

# Generate the Java agent
javamopagent *.aj classes -n JavaMopAgent -excludeJars
mv JavaMopAgent.jar ../
