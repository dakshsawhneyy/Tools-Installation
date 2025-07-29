docker run -p 9092:9092 \
  -e KAFKA_ZOOKEEPER_CONNECT=<your-wifi-ip>:2181 \
  -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://<your-wifi-ip>:9092 \
  -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
  -e KAFKA_PROCESS_ROLES=broker \
  -e CLUSTER_ID=q1w2e3r4-t5y6-7u8i-9o0p-a1s2d3f4g5h6 \
  confluentinc/cp-kafka


# Kafka Install Using Yarn
yarn init
yarn add kafkajs

