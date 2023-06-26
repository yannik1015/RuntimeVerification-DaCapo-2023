# Runtime Verification of DaCapo

Project repository for the runtime verification course 2023 at the Technical University of Vienna.

## Project Structure
`mop-files/` contains the mop files used for instrumentation.
`javamop` contains the javamop repo
`rv-monitor` contains the rv-monitor repo

---
## Prerequisites
Tested on to run and compile on `java version "1.8.0_202"`

### 1. Download the benchmark jar
You will need to download the benchmark file (`dacapo-9.12-MR1-bach.jar`) from https://www.dacapobench.org/ and place it in the project's root directory.

### 2. Compile javamop
```
cd javamop

mvn package
```
Add `javamop/target/release/javamop/javamop/bin` to your PATH.

### 3. Compile rv-monitor
```
cd rv-monitor

mvn package
```
Add `rv-monitor/target/release/rv-monitor/bin` to your PATH.

### 4. Miscellaneous

We expect the `aspectjtools.jar`, `aspectjweaver.jar` and `aspectjrt.jar` to be present in the `/usr/share/java` directory.

---
## Running
We have two options for running the runtime verification. The first option uses a Java agent that will weave in our aspects during load time. Using a Java agent might incur more runtime overhead as the weaving of the instrumentation takes place during load time of the classes. The second option makes use of AspectJ to statically weave the code used for watching and verifying the code after build time into the jar file of the program to be verified. 

Also, note that some benchmarks will present a failed verdict. This is however due to the output of our instrumentation to stdout and stderr altering its digest leading to a failed comparison with the expected output. Therefore, this does not necessarily conclude that the benchmark indeed failed.

### Option 1 - Java Agent
To generate the agent file used for monitoring just run the `weave-agent.sh` script. The benchmarks can then either be all started with `run-all-benchmarks.sh agent` or started manually with the following command.
```
java -cp dacapo-9.12-MR1-bach.jar:/usr/share/java/aspectjweaver.jar:$(pwd)/rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar -javaagent:JavaMopAgent.jar Harness <BENCHMARK-Name>
```

### Option 2 - AspectJ
**Warning** Instrumenting the precompiled jar files using AspectJ does not properly work when using multiple mop files. It seems as if the instrumentation does not get applied to the precompiled jar file. It is however running for the jar found in the `Example` directory. I suspect this is due to the size and complexity of the benchmark file.

To generate the final jar file weaved in with all the monitoring code just run the `weave-aspectj.sh` script. The benchmarks can then either be all started with `run-all-benchmarks.sh aspectj` or started manually with the following command.
```
java -cp weaved-dacapo-9.12-MR1-bach.jar Harness <BENCHMARK-NAME>
```