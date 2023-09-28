resource "shoreline_notebook" "high_itcp_connections_on_kafka_cluster" {
  name       = "high_itcp_connections_on_kafka_cluster"
  data       = file("${path.module}/data/high_itcp_connections_on_kafka_cluster.json")
  depends_on = [shoreline_action.invoke_increase_broker_count]
}

resource "shoreline_file" "increase_broker_count" {
  name             = "increase_broker_count"
  input_file       = "${path.module}/data/increase_broker_count.sh"
  md5              = filemd5("${path.module}/data/increase_broker_count.sh")
  description      = "Increase the number of Kafka brokers to distribute load across the cluster."
  destination_path = "/agent/scripts/increase_broker_count.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_increase_broker_count" {
  name        = "invoke_increase_broker_count"
  description = "Increase the number of Kafka brokers to distribute load across the cluster."
  command     = "`chmod +x /agent/scripts/increase_broker_count.sh && /agent/scripts/increase_broker_count.sh`"
  params      = ["NEW_BROKER_COUNT","_NEW_BROKER_COUNT_I_DO_ECHO_BROKER_ID_I_"]
  file_deps   = ["increase_broker_count"]
  enabled     = true
  depends_on  = [shoreline_file.increase_broker_count]
}

