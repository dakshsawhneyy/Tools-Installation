docker run -d \
  --name zookeeper \
  --network kafka-net \
  -p 2181:2181 \
  zookeeper
