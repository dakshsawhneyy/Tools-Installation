# Try to ask for 110% of total memory
# For a duration of 60s and no of workers = 1
stress-ng --vm 1 --vm-bytes 110% --timeout 60s
