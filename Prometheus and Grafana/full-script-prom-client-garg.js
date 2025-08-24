// Install PROM Client
npm i prom-client

// This collects default metrics like ram, cpu etc
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ register: client.register })

// Usage -- Creating a /metrics for sending logs to it
app.get('/metrics', async (req,res) => {
  res.setHeader('Content-Type', client.register.contentType);
  const metrics = await client.register.metrics();
  res.send(metrics);
})


// Create prom-config.yml
global:
  scrape_interval: 4s

scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets: ["<NDOEJS_SERVER_ADDRESS>"]  // If on AWS, instance id:port and on local, ifconfig pick up inet private ip and paste

