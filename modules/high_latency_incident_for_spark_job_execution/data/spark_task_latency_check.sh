

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