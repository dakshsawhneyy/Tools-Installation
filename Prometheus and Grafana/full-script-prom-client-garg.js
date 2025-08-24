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

// Custom Metrics -- inside index.js
npm i response-time

// Start writing
const responseTime = require('response-time')

// Creating Histogram of this route
const reqResTime = new client.Histogram({
    name: 'http_req_res_time',
    help: 'Request Response Time',
    labelNames: ['method', 'route', 'code'],
    buckets: [1,50,100,200,500,800,1000,2000]  // buckets are used to categorize the time taken
})

// Custom Metrics Route
// This will tell the requests take how much time
app.use(responseTime((req, res, time) => {
    reqResTime.labels({ method: req.method, route: req.url, code: req.statusCode }).observe(time)
}))

// Creating metric for counter
const totalReqCounter = new client.Counter({
    name: 'total_req',
    help: 'Total number of requests',
})
// Just increment counter in every request -> totalReqCounter.inc()

// ! Fetching Logs into LOKI 
npm i winston winston-loki

// Inside index.js -- copy this from documentation of winston-loki
const { createLogger, transports } = require("winston");
const LokiTransport = require("winston-loki");

// Sending data to LOKI
const options = {
  transports: [
    new LokiTransport({
      host: "http://3.111.23.106:3100"
    })
  ]
};
const logger = createLogger(options);   // we can add logs inside this logger

// Open Loki Server on browser to test
http://<your-ip>:3100/metrics

