

#!/bin/bash



# Define variables

KAFKA_HOME=${PATH_TO_KAFKA_HOME}

NEW_NODE_COUNT=${NUMBER_OF_NEW_NODES_TO_ADD}



# Stop Kafka services

sudo systemctl stop kafka



# Add new Kafka nodes

for i in $(seq 1 $NEW_NODE_COUNT);

do

    # Create new Kafka node

    sudo mkdir -p $KAFKA_HOME/kafka-node-$i

    sudo chown -R kafka:kafka $KAFKA_HOME/kafka-node-$i



    # Copy Kafka configuration files

    sudo cp -r $KAFKA_HOME/config $KAFKA_HOME/kafka-node-$i/

    sudo cp -r $KAFKA_HOME/logs $KAFKA_HOME/kafka-node-$i/



    # Update Kafka configuration files

    sudo sed -i "s/broker.id=${CURRENT_NODE_ID}/broker.id=$i/" $KAFKA_HOME/kafka-node-$i/config/server.properties

    sudo sed -i "s/#listeners/listeners/" $KAFKA_HOME/kafka-node-$i/config/server.properties

    sudo sed -i "s/#advertised.listeners/advertised.listeners/" $KAFKA_HOME/kafka-node-$i/config/server.properties

    sudo sed -i "s/${CURRENT_NODE_HOSTNAME}/$HOSTNAME/" $KAFKA_HOME/kafka-node-$i/config/server.properties

done



# Start Kafka services

sudo systemctl start kafka