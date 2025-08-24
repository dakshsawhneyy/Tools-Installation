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
