const express = require('express');
const bodyParser = require('body-parser');

const robots = require('./mocks/robots.json');
const locations = require('./mocks/locations.json');

const queue = require('./queue');

const app = express();
app.use(bodyParser.json());

// Function to check if there is any Idle robot
function getAvailableRobot() {
  return robots.robots.find(robot => robot.status === "Idle");
}

// Updates the robot's status to "Running" and simulates sending it
function sendRobotToLocation(robot, location) {
  console.log(`${robot.name} is being sent to ${location}`);
  
  robot.status = "Running";
  robot.battery -= 10;

  setTimeout(() => {
    console.log(`${robot.name} has arrived at ${location}`);

    robot.status = "Idle";

    if (robot.battery <= 20) {
      robot.status = "Charging";
      
      setTimeout(() => {
        robot.battery = 100;
        robot.status = "Idle";

        console.log(`${robot.name} is fully charged and Idle`);
      }, 3600000); // 1 hour to fully charge
    }

    processQueue();
  }, 60000); // 1 minute for the robot to arrive at the destination
}

// Process the action queue
function processQueue() {
  if (!queue.isEmpty()) {
    const { robot, location } = queue.dequeue();

    if (robot.status === "Idle") {
      sendRobotToLocation(robot, location);
    }
  }
}

// Wait until a robot is Idle
function waitForIdleRobot(location) {
  let availableRobot = getAvailableRobot();
  
  if (availableRobot) {
    sendRobotToLocation(availableRobot, location);
  } else {
    console.log(`No robots are Idle. Waiting for one to become available.`);

    setTimeout(() => waitForIdleRobot(location), 5000); // Check every 5 seconds
  }
}

// Endpoint to get locations
app.get('/api/locations', (req, res) => {
  res.json(locations);
});

// Endpoint to send a robot to a location
app.post('/api/sendRobot', (req, res) => {
  const { location } = req.body;
  const availableRobot = getAvailableRobot();
  
  if (availableRobot) {
    sendRobotToLocation(availableRobot, location);

    res.status(200).send(`${availableRobot.name} is being sent to ${location}.`);
  } else {
    queue.enqueue({ robot: availableRobot, location });

    res.status(200).send(`All robots are busy. ${availableRobot.name} has been queued to go to ${location}.`);

    waitForIdleRobot(location);
  }
});

// Start the server
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
