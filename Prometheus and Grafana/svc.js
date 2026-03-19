const client = require('prom-client');

const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();

const httpRequestCounter = new client.Counter({
  name: 'http_requests_total',
  help: 'Total number of requests'
});

app.get('/orders', async (req, res) => {
  httpRequestCounter.inc();
  // your existing logic
});
