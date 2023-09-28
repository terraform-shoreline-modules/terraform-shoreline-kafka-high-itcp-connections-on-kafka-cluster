

#!/bin/bash



# Set the Kafka broker count

${NEW_BROKER_COUNT}=3



# Get the current Kafka broker count

CURRENT_BROKER_COUNT=$(cat /path/to/kafka/config/server.properties | grep "^broker\.id=" | wc -l)



# Check if the new broker count is greater than the current count

if [ $NEW_BROKER_COUNT -gt $CURRENT_BROKER_COUNT ]; then

    # Generate new broker IDs starting from the current count

    for ((i=$CURRENT_BROKER_COUNT; i${_NEW_BROKER_COUNT_I_DO_ECHO_BROKER_ID_I_}> /path/to/kafka/config/server.properties

    done

    echo "Kafka broker count increased to $NEW_BROKER_COUNT"

else

    echo "New Kafka broker count is not greater than the current count"

fi