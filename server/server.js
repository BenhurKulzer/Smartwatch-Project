const express = require('express');
const { locations, robots, destinations } = require('./data');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to parse JSON requests
app.use(express.json());

// Endpoint to get locations
app.get('/api/locations', (req, res) => {
    res.json(locations);
});

// Endpoint to get robots
app.get('/api/robots', (req, res) => {
    res.json(robots);
});

// Endpoint to get destinations
app.get('/api/destinations', (req, res) => {
    res.json(destinations);
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
