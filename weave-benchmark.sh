#!/bin/bash

# Generate .aj and .rmv files
javamop -v -d aj-files/ mop-files/*

# Weave .aj files into benchmark
ajc -1.6 -outjar weaved-dacapo-9.12-MR1-bach.jar -aspectpath aj-files/ -injars dacapo-9.12-MR1-bach.jar

