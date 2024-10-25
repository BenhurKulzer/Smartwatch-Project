const fs = require('fs');
const path = require('path');
const robotsFilePath = path.join(__dirname, './mocks/robots.json');

function readRobots() {
    const data = fs.readFileSync(robotsFilePath, 'utf8');
    return JSON.parse(data);
}

function writeRobots(robots) {
    fs.writeFileSync(robotsFilePath, JSON.stringify(robots, null, 2), 'utf8');
}

function getAvailableRobot() {
    const robots = readRobots();
    return robots.find(robot => robot.status === 'Idle');
}

function updateRobotStatus(robotId, newStatus, batteryChange = 0) {
    const robots = readRobots();
    const robotIndex = robots.findIndex(robot => robot.id === robotId);

    if (robotIndex !== -1) {
        const robot = robots[robotIndex];
        robot.status = newStatus;

        if (batteryChange !== 0) {
            robot.battery = Math.max(0, robot.battery + batteryChange);
        }

        robots[robotIndex] = robot;
        writeRobots(robots);
    } else {
        console.error(`Robot with ID ${robotId} not found.`);
    }
}

module.exports = {
    getAvailableRobot,
    updateRobotStatus,
    readRobots
};
