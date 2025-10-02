# Step 1: Download the Latest Version
curl -O -L "https://releases.hashicorp.com/sentinel/0.25.0/sentinel_0.25.0_linux_amd64.zip"

# Unzip the File
unzip sentinel_0.25.0_linux_amd64.zip

# Move the Binary to Your PATH
sudo mv sentinel /usr/local/bin/
sudo chmod +x /usr/local/bin/sentinel

# Verify the Installation
sentinel version
