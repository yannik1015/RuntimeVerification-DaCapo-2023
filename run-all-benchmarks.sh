#!/bin/bash

# These benchmarks will not be run as we noticed them to not work
ignore_benchmarks=("tomcat" "tradebeans", "tradesoap")

command_pid=0
# Function to handle Ctrl+C (SIGINT)
function ctrl_c_handler() {
    echo "Script terminated by Ctrl+C"

    if [ $command_pid -ne 0 ]; then
        echo "Stopping the command... with PID $command_pid"
        kill -SIGTERM $command_pid
    fi

    exit 1
}

# Trap the SIGINT signal and call the handler function
trap ctrl_c_handler SIGINT

function is_in_ignore() {
    local benchmark_to_test=$1

    for element in "${ignore_benchmarks[@]}"; do
        if [ "$benchmark_to_test" = "$element" ]; then
            return 0
        fi
    done

    return 1
}


weave_type=$1
output_benchmark_list=$(java -cp dacapo-9.12-MR1-bach.jar Harness -l)

read -a benchmarks <<< "$output_benchmark_list"

for benchmark in "${benchmarks[@]}"; do
    if is_in_ignore "$benchmark"; then
        continue
    else
        if [ "$weave_type" = "aspectj" ]; then
            echo -e "\n\nNow running $benchmark instrumented using aspectj\n===================================\n"
            java -cp weaved-dacapo-9.12-MR1-bach.jar:$(pwd)/rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar:/usr/share/java/aspectjrt.jar Harness $benchmark &
            command_pid=$!
            wait $command_pid
        elif [ "$weave_type" = "agent" ]; then
            echo -e "\n\nNow running $benchmark instrumented using a Java agent\n===================================\n"
            java -cp dacapo-9.12-MR1-bach.jar:/usr/share/java/aspectjweaver.jar:$(pwd)/rv-monitor/target/release/rv-monitor/lib/rv-monitor-rt.jar -javaagent:JavaMopAgent.jar Harness $benchmark &
            command_pid=$!
            wait $command_pid
        else
            echo "Provide the type of weaving to be used [agent, aspectj]"
            echo -e "\n\nNow running $benchmark without instrumentation\n===================================\n"
            java -cp dacapo-9.12-MR1-bach.jar Harness $benchmark &
        fi
    fi
done

# ToDo: Add final summary weather or not any errors happend and if all benchmarks passed maybe in what time
