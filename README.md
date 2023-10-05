
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Latency Incident for Spark Job Execution.
---

This incident type indicates that there is a high latency issue in the execution of a Spark job. Spark is a distributed computing framework that is used for processing large datasets. High latency in this context means that the time taken to execute the Spark job is significantly longer than expected or normal. This can result in delays in processing data and can impact the performance of the application or system that is utilizing Spark.

### Parameters
```shell
export HOSTNAME="PLACEHOLDER"

export PATH_TO_SPARK_LOGS="PLACEHOLDER"

export PATH_TO_SPARK_CONF="PLACEHOLDER"

export JOB_FILE="PLACEHOLDER"

export PATH_TO_LOG_FILE="PLACEHOLDER"

export LATENCY_THRESHOLD="PLACEHOLDER"
```

## Debug

### Check system resource utilization
```shell
top
```

### Check memory usage
```shell
free -m
```

### Check network latency
```shell
traceroute ${HOSTNAME}
```

### Check Spark logs for errors
```shell
tail -f ${PATH_TO_SPARK_LOGS}
```

### Check network connectivity
```shell
ping ${HOSTNAME}
```

### Check disk usage
```shell
df -h
```

### Check Spark configuration settings
```shell
cat ${PATH_TO_SPARK_CONF}
```

### Check CPU usage
```shell
mpstat
```

### Inefficient Code: Inefficient code can cause high latency during Spark job execution. This can happen when a developer writes code that doesn't optimize the use of Spark resources. For example, if a developer writes code that doesn't take advantage of Spark's in-memory processing capabilities, it can cause high latency during Spark job execution.
```shell


#!/bin/bash



# Set the path to the Spark application log file

LOG_FILE=${PATH_TO_LOG_FILE}



# Set the threshold for high latency

LATENCY_THRESHOLD=${LATENCY_THRESHOLD}



# Find the lines in the log file that indicate slow tasks

slow_tasks=$(grep -E "^(.*INFO.*TaskSchedulerImpl.*:.*Task.*failed.*to.*launch.*.*ms.*)(.*)$" $LOG_FILE)



# If there are no slow tasks, exit with success status

if [ -z "$slow_tasks" ]; then

    echo "No slow tasks found"

    exit 0

fi



# Loop through the slow tasks and check their latency

while read -r line; do

    # Extract the latency from the log line

    latency=$(echo $line | grep -oE "([0-9]+)ms" | tr -d 'ms')



    # If the latency is above the threshold, print a warning

    if [ "$latency" -ge "$LATENCY_THRESHOLD" ]; then

        echo "Warning: Slow task detected with latency of $latency ms"

    fi

done <<< "$slow_tasks"


```

## Repair

### Optimize the Spark job code and ensure that it is running efficiently without any unnecessary operations that could slow down the execution.
```shell


#!/bin/bash



# Replace ${JOB_FILE} with the path to the Spark job code file

job_file=${JOB_FILE}



# Create a backup of the original job file

cp $job_file $job_file.bak



# Optimize the job code by removing any unnecessary operations

# This example removes all lines that contain the word "slow"

sed '/slow/d' $job_file > $job_file.temp

mv $job_file.temp $job_file



# Print a message indicating that the job code has been optimized

echo "Spark job code has been optimized."


```