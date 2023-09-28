
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High ITCP Connections on Kafka Cluster
---

In this incident type, the software engineer needs to monitor the ITCP (Internet Protocol Control Protocol) connections on the Kafka cluster. If the number of ITCP connections becomes too high, it can cause a CPU spike, which can lead to performance issues or even system failure. Therefore, it's important to regularly check for high ITCP connections on the Kafka cluster and take preventive measures to avoid any potential problems.

### Parameters
```shell
export BROKER_NODE="PLACEHOLDER"

export BROKER_NODES_LIST="PLACEHOLDER"

export NEW_BROKER_COUNT="PLACEHOLDER"

export _NEW_BROKER_COUNT_I_DO_ECHO_BROKER_ID_I_="PLACEHOLDER"
```

## Debug

### Check the number of established connections on the Kafka broker
```shell
ss -s | grep kafka_broker | awk '{print $1 " " $2}'
```

### Check the number of ITCP connections on the Kafka broker
```shell
ss -s | grep kafka_broker | grep "tcp.*itcp" | awk '{print $1 " " $2}'
```

### Check the number of ITCP connections on each Kafka broker node
```shell
for ${BROKER_NODE} in ${BROKER_NODES_LIST}; do echo "ITCP connections on $BROKER_NODE:"; ssh $BROKER_NODE "ss -s | grep kafka_broker | grep 'tcp.*itcp' | awk '{print \$1 \" \" \$2}'"; done
```

### Check the current CPU usage on each Kafka broker node
```shell
for ${BROKER_NODE} in ${BROKER_NODES_LIST}; do echo "CPU usage on $BROKER_NODE:"; ssh $BROKER_NODE "ps -eo pcpu,pid,user,args | grep kafka_broker | grep -v grep"; done
```

## Repair

### Increase the number of Kafka brokers to distribute load across the cluster.
```shell


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


```