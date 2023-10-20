resource "shoreline_notebook" "high_itcp_connections_on_kafka_cluster" {
  name       = "high_itcp_connections_on_kafka_cluster"
  data       = file("${path.module}/data/high_itcp_connections_on_kafka_cluster.json")
  depends_on = [shoreline_action.invoke_add_kafka_nodes]
}

resource "shoreline_file" "add_kafka_nodes" {
  name             = "add_kafka_nodes"
  input_file       = "${path.module}/data/add_kafka_nodes.sh"
  md5              = filemd5("${path.module}/data/add_kafka_nodes.sh")
  description      = "Increase Kafka Cluster capacity: One of the possible reasons for high ITCP connections is that the Kafka cluster is reaching its capacity limit. In this case, we can consider increasing the capacity of the Kafka cluster to handle more connections."
  destination_path = "/tmp/add_kafka_nodes.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_add_kafka_nodes" {
  name        = "invoke_add_kafka_nodes"
  description = "Increase Kafka Cluster capacity: One of the possible reasons for high ITCP connections is that the Kafka cluster is reaching its capacity limit. In this case, we can consider increasing the capacity of the Kafka cluster to handle more connections."
  command     = "`chmod +x /tmp/add_kafka_nodes.sh && /tmp/add_kafka_nodes.sh`"
  params      = ["CURRENT_NODE_ID","NUMBER_OF_NEW_NODES_TO_ADD","CURRENT_NODE_HOSTNAME","PATH_TO_KAFKA_HOME"]
  file_deps   = ["add_kafka_nodes"]
  enabled     = true
  depends_on  = [shoreline_file.add_kafka_nodes]
}

