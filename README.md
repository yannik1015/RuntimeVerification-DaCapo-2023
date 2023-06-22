# [WIP] Runtime Verification of DaCapo

Project repository for the runtime verification course 2023 at the Technical University of Vienna.

## Project Structure
ToDo

---
## Prerequisits
We aspect the `aspectjtools.jar`, `aspectjweaver.jar` and `aspectjrt.jar` to be present in the `/usr/share/java` directory.
ToDo: Add how to compile the needed tools

---
## Running
We have two options for running the runtime verification. The first option makes use of AspectJ to statically weave the code used for watching and verifying the code after build time into the jar file of the program to be verified. The second option uses a Java agent that will weave in our aspects during load time. The latter option using a Java agent might incur more runtime overhead.

### Option 1 - AspectJ
To generate the final jar file weaved in with all the monitoring code just run the `weave-aspectj.sh` script. The benchmarks can then either be all started with `run-all-benchmarks.sh aspectj` or started manually with the following command.
```
java -cp weaved-dacapo-9.12-MR1-bach.jar Harness <BENCHMARK-NAME>
```

### Option 2 - Java Agent
To generate the agent file used for monitoring just run the `weave-agent.sh` script. The benchmarks can then either be all started with `run-all-benchmarks.sh agent` or started manually with the following command.
```
java -cp dacapo-9.12-MR1-bach.jar:/usr/share/java/aspectjweaver.jar:$(pwd)/rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar -javaagent:JavaMopAgent.jar Harness <BENCHMARK-Name>
```

---
### Evaluation
ToDo: Reflect on the two options and what they made to the benchmarks => crashes etc.
