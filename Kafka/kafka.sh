docker run -p 9092:9092 \
  -e KAFKA_ZOOKEEPER_CONNECT=<your-wifi-ip>:2181 \    # Tell the ip where zookeeper is running on your laptop
  -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://<your-wifi-ip>:9092 \   # Tells kafka on which port it is running
  -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \    # How many replications - 1 means No Replication
  -e KAFKA_PROCESS_ROLES=broker \    # Explicitly tells Kafka to run as a broker, not controller-only 
  -e KAFKA_NODE_ID=1 \
  -e CLUSTER_ID=q1w2e3r4-t5y6-7u8i-9o0p-a1s2d3f4g5h6 \  
  confluentinc/cp-kafka


# Kafka Install Using Yarn
yarn init
yarn add kafkajs

