#!/bin/bash

# Compilation of hasNext example file
javac HasNext_1.java
jar cfm hasNext.jar manifest.txt HasNext_1.class 

# Generate .aj and .rmv files
mkdir aj-files 2>/dev/null
rm aj-files/* 2>/dev/null
javamop -v -d aj-files/ mop-files/*

# Generate monitor classes from the .rvm files
rv-monitor aj-files/*.rvm -d aj-files

# Compile monitor classes
export CLASSPATH=$(pwd)/../rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar
cd aj-files
javac *.java
cd ..

# Weave .aj files into benchmark
ajc -1.6 -injars hasNext.jar -sourceroots aj-files/ -outjar weaved-hasNext.jar

