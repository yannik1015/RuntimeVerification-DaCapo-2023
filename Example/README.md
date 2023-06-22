This directory contains an easy example from javamop. It's purpose is to verify that the toolchain is working.

# Option 1 -AspectJ
Run `weave-aspectj.sh` to generate the modified `weaved-hasNext.jar`

Can then be executed using the following command
```
java -cp weaved-hasNext.jar:$(pwd)/../rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar:/usr/share/java/aspectjrt.jar HasNext_1
```

# Option 2 - Java Agent
Run `weave-agent.sh` to generate the Java agent.

Can then be executed using the following command
```
java -cp hasNext.jar:/usr/share/java/aspectjweaver.jar:$(pwd)/../rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar -javaagent:JavaMopAgent.jar HasNext_1
```