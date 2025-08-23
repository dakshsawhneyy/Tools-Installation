#  Install & Configure Filebeat (Client Machine) 

# Install Filebeat 
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - 
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list 
sudo apt update 
sudo apt install filebeat -y

# Configure Filebeat to Send Logs to Logstash 
sudo vi /etc/filebeat/filebeat.yml
# Modify ------- IF USING DOCKER -------------
filebeat.inputs:
  - type: docker
    enabled: true
    containers.ids:
      - "*"
    processors:
      - add_docker_metadata: ~

output.logstash:
  hosts: ["<elasticsearch-instance-ip>:5044"]
# -------- IF USING LOG FILE -------------
filebeat.inputs: 
  - type: log 
  enabled: true 
  paths: - /home/ubuntu/Boardgame/target/app.log 
output.logstash: 
hosts: ["<ELK_Server_Private_IP>:5044"] 
# ------------------------------------------

# Start & Enable Filebeat 
sudo systemctl start filebeat 
sudo systemctl enable filebeat 
sudo systemctl status filebeat 

# Verify Filebeat is Sending Logs 
sudo filebeat test output 

