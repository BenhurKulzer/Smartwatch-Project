const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');

const packageDef = protoLoader.loadSync('protos/service.proto');
const robotService = grpc.loadPackageDefinition(packageDef).robotservice;

const queue = require('./queue.js');
const robots = require('./robots.js');
const locations = require('./mocks/locations.json');

function getLocations(call, callback) {
    callback(null, { locations });
}

function getRobots(call, callback) {
    callback(null, { robots: robots.readRobots() });
}

function callRobot(call, callback) {
    const { locationId } = call.request;
    const availableRobot = robots.getAvailableRobot();

    if (availableRobot) {
        sendRobotToLocation(availableRobot, locationId);
        callback(null, { message: `${availableRobot.name} is being sent to location ID ${locationId}.` });
    } else {
        queue.enqueue({ locationId });
        callback(null, { message: `All robots are busy. Request for location ID ${locationId} has been enqueued.` });
        waitForIdleRobot();
    }
}

function cancelCall(call, callback) {
    const { locationId } = call.request;
    const currentQueue = queue.getQueue();

    const updatedQueue = currentQueue.filter(item => item.locationId !== locationId);
    queue.writeQueue(updatedQueue);

    callback(null, { message: `Request for location ID ${locationId} has been canceled.` });
}

function queueStream(call) {
    call.on('data', (queueRequest) => {
        queue.enqueue(queueRequest);
        call.write({ message: `Queued robot ${queueRequest.robotId} for location ${queueRequest.locationId}` });
        
        waitForIdleRobot();
    });

    call.on('end', () => {
        call.end();
    });
}

function main() {
    const server = new grpc.Server();

    server.addService(robotService.RobotService.service, {
        GetLocations: getLocations,
        GetRobots: getRobots,
        CallRobot: callRobot,
        CancelCall: cancelCall,
        QueueStream: queueStream
    });

    server.bindAsync('0.0.0.0:50051', grpc.ServerCredentials.createInsecure(), (err, port) => {
        console.log(`Server running at http://0.0.0.0:${port}`);

        server.start();
    });
}

main();
