resource "shoreline_notebook" "high_itcp_connections_on_kafka_cluster" {
  name       = "high_itcp_connections_on_kafka_cluster"
  data       = file("${path.module}/data/high_itcp_connections_on_kafka_cluster.json")
  depends_on = [shoreline_action.invoke_kafka_broker_update]
}

resource "shoreline_file" "kafka_broker_update" {
  name             = "kafka_broker_update"
  input_file       = "${path.module}/data/kafka_broker_update.sh"
  md5              = filemd5("${path.module}/data/kafka_broker_update.sh")
  description      = "Increase the number of Kafka brokers to distribute load across the cluster."
  destination_path = "/agent/scripts/kafka_broker_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_kafka_broker_update" {
  name        = "invoke_kafka_broker_update"
  description = "Increase the number of Kafka brokers to distribute load across the cluster."
  command     = "`chmod +x /agent/scripts/kafka_broker_update.sh && /agent/scripts/kafka_broker_update.sh`"
  params      = ["_NEW_BROKER_COUNT_I_DO_ECHO_BROKER_ID_I_","NEW_BROKER_COUNT"]
  file_deps   = ["kafka_broker_update"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_broker_update]
}

