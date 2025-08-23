# Install Java (Required for Elasticsearch & Logstash) 
sudo apt update && sudo apt install openjdk-17-jre-headless -y

# Install Elasticsearch 
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install elasticsearch -y 

# Configure Elasticsearch 
sudo vi /etc/elasticsearch/elasticsearch.yml 
# Modify: 
network.host: 0.0.0.0 
cluster.name: my-cluster      # Name of your elastic-search cluster
node.name: node-1 
discovery.type: single-node

# Start & Enable Elasticsearch 
sudo systemctl start elasticsearch 
sudo systemctl enable elasticsearch 
sudo systemctl status elasticsearch 

# Verify Elasticsearch 
curl -X GET "http://<ec2-ip>:9200"

# Install & Configure Logstash (ELK Server)

#  Install Logstash 
sudo apt install logstash -y

# Configure Logstash to Accept Logs 
sudo vi /etc/logstash/conf.d/logstash.conf 
#  Add: 
input { 
  beats { 
    port => 5044 
  } 
} 
filter { 
  grok { 
    match => { "message" => "%{TIMESTAMP_ISO8601:log_timestamp} %{LOGLEVEL:log_level} 
    %{GREEDYDATA:log_message}" } 
  } 
} 
output { 
  elasticsearch { 
    hosts => ["http://localhost:9200"] 
    index => "logs-%{+YYYY.MM.dd}" 
  } 
  stdout { codec => rubydebug } 
}

# Start & Enable Logstash 
sudo systemctl start logstash 
sudo systemctl enable logstash 
sudo systemctl status logstash

# Allow Traffic on Port 5044 
sudo ufw allow 5044/tcp 

# Install & Configure Kibana (ELK Server) 

# Install Kibana 
sudo apt install kibana -y 

# Configure Kibana 
sudo vi /etc/kibana/kibana.yml 
# Modify: 
server.host: "0.0.0.0" 
elasticsearch.hosts: ["http://localhost:9200"] 

# Start & Enable Kibana 
sudo systemctl start kibana 
sudo systemctl enable kibana 
sudo systemctl status kibana 

# Allow Traffic on Port 5601 
sudo ufw allow 5601/tcp

# Access Kibana Dashboard 
# Open a browser and go to: 
http://<ELK_Server_Public_IP>:5601
