# Install
sudo apt-get install stress-ng -y

# spawns 2 workers aggressively writing to disk to starve other processes.
stress-ng --io 2 --timeout 600s
