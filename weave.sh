#!/bin/bash

# ToDo Check existence of dacapo.jar and download it if needed

# Generate .aj and .rmv files
mkdir aj-files 2>/dev/null
rm aj-files/* 2>/dev/null
javamop -v -d aj-files/ mop-files/*

# Generate monitor classes from the .rvm files
rv-monitor aj-files/*.rvm -d aj-files

# Compile monitor classes
export CLASSPATH=$(pwd)/rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar
cd aj-files
javac *.java
cd ..

# Weave .aj files into benchmark
ajc -1.6 -injars dacapo-9.12-MR1-bach.jar -sourceroots aj-files/ -outjar weaved-dacapo-9.12-MR1-bach.jar

