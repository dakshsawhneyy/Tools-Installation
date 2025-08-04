app.use('/metrics', async(req,res) => {
    try {
        // this is the format that prometheus understands
        res.set('Content-Type', register.contentType);   // thats how prometheus expects data to recieve data
        res.end(await register.contentType);   // sends that data as a final response to Prometheus
    } catch (error) {
        console.error('Error fetching metrics:', error);
        res.status(500).json({message: 'Failed to fetch metrics'});
    }
})
