const express = require('express');
const bodyParser = require('body-parser');

const robots = require('./robots.js');
const locations = require('./mocks/locations.json');
const queue = require('./queue.js');

const app = express();
app.use(bodyParser.json());

function logQueueItem(robotId, locationId, status) {
    const queueItem = { robotId, locationId, status };
    queue.enqueue(queueItem);
}

function sendRobotToLocation(robot, locationId) {
    const location = locations.find(loc => loc.id === locationId);

    if (!location) {
        console.error(`Location with ID ${locationId} not found.`);
        return;
    }

    console.log(`${robot.name} is being sent to ${location.name}`);

    robots.updateRobotStatus(robot.id, "Running", -10);

    logQueueItem(robot.id, locationId, "Running");

    setTimeout(() => {
        console.log(`${robot.name} has arrived at ${location.name}`);

        robots.updateRobotStatus(robot.id, "Idle");

        if (robot.battery <= 20) {
            robots.updateRobotStatus(robot.id, "Charging");

            setTimeout(() => {
                robots.updateRobotStatus(robot.id, "Idle", 100);
                console.log(`${robot.name} is fully charged and Idle`);
            }, 3600000);
        }

        waitForIdleRobot();
    }, 60000);
}

function waitForIdleRobot() {
    if (queue.isEmpty()) {
        console.log('Queue is empty, no robots to assign.');

        return;
    }

    const availableRobot = robots.getAvailableRobot();

    if (availableRobot) {
        const nextInQueue = queue.dequeue();
        
        if (nextInQueue) {
            sendRobotToLocation(availableRobot, nextInQueue.locationId);
        }
    } else {
        console.log('No robots available, still waiting.');
        setTimeout(waitForIdleRobot, 5000);
    }
}

app.get('/api/locations', (req, res) => {
    res.json(locations);
});

app.get('/api/robots', (req, res) => {
    res.json(robots.readRobots()); 
});

app.post('/api/robots/call', (req, res) => {
    const { locationId } = req.body;
    const availableRobot = robots.getAvailableRobot();

    if (availableRobot) {
        sendRobotToLocation(availableRobot, locationId);

        res.status(200).send(`${availableRobot.name} is being sent to location ID ${locationId}.`);
    } else {
        const queueItem = { locationId };
        queue.enqueue(queueItem);

        res.status(200).send(`All robots are busy. Request for location ID ${locationId} has been enqueued.`);

        waitForIdleRobot();
    }
});

app.get('/api/queue', (req, res) => {
    const currentQueue = queue.getQueue();

    res.json(currentQueue);
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
