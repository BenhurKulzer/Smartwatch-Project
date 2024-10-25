const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const path = require('path');

const robots = require('./robots.js');
const locations = require('./mocks/locations.json');
const queue = require('./queue.js');

const PROTO_PATH = path.join(__dirname, './protos/service.proto');
const packageDefinition = protoLoader.loadSync(PROTO_PATH, {
    keepCase: true,
    longs: String,
    enums: String,
    defaults: true,
    oneofs: true,
});
const robotServiceProto = grpc.loadPackageDefinition(packageDefinition).robotservice;

// Função para retornar todas as localizações
function getLocations(call, callback) {
    callback(null, { locations });
}

// Função para retornar todos os robôs
function getRobots(call, callback) {
    callback(null, { robots: robots.readRobots() });
}

// Função para enviar um robô para uma localização
function callRobot(call, callback) {
    const { locationId } = call.request;
    const availableRobot = robots.getAvailableRobot();

    if (availableRobot) {
        sendRobotToLocation(availableRobot, locationId);
        callback(null, { message: `${availableRobot.name} is being sent to location ID ${locationId}.` });
    } else {
        const queueItem = { locationId };
        queue.enqueue(queueItem);
        queue.writeQueue(queue.getQueue());
        callback(null, { message: `All robots are busy. Request for location ID ${locationId} has been enqueued.` });
        waitForIdleRobot();
    }
}

// Função para cancelar uma solicitação e atualizar o status do robô
function cancelCall(call, callback) {
    const { locationId } = call.request;
    const currentQueue = queue.getQueue();

    const updatedQueue = currentQueue.filter(item => item.locationId !== locationId);
    queue.writeQueue(updatedQueue);

    const robotToUpdate = currentQueue.find(item => item.locationId === locationId);
    if (robotToUpdate) {
        robots.updateRobotStatus(robotToUpdate.robotId, 'Idle');
    }

    callback(null, { message: `Request for location ID ${locationId} has been canceled and robot status set to Idle.` });
}

function sendRobotToLocation(robot, locationId) {
    const location = locations.find((loc) => loc.id == locationId);

    if (!location) {
        console.error(`Location with ID ${locationId} not found.`);
        return;
    }

    console.log(`${robot.name} is being sent to ${location.name}`);

    // Atualiza o status do robô para "Running" e reduz a bateria
    robots.updateRobotStatus(robot.id, "Running", -10);

    // Adiciona o robô à fila com status "Running" e grava no arquivo
    queue.enqueue({ robotId: robot.id, locationId: locationId, status: "Running" });

    setTimeout(() => {
        console.log(`${robot.name} has arrived at ${location.name}`);
        robots.updateRobotStatus(robot.id, "Idle");

        // Remove o robô da fila e atualiza o arquivo
        queue.writeQueue(queue.getQueue().filter((item) => item.robotId !== robot.id));

        if (robot.battery <= 20) {
            robots.updateRobotStatus(robot.id, "Charging");
            setTimeout(() => {
                robots.updateRobotStatus(robot.id, "Idle", 100);
                console.log(`${robot.name} is fully charged and Idle`);
            }, 3600000); // 1 hora para carregar
        }

        waitForIdleRobot();
    }, 60000); // Simulação de 1 minuto de viagem
}


function waitForIdleRobot() {
    if (queue.isEmpty()) return;

    const availableRobot = robots.getAvailableRobot();
    if (availableRobot) {
        const nextInQueue = queue.dequeue();
        if (nextInQueue) {
            sendRobotToLocation(availableRobot, nextInQueue.locationId);
        }
    } else {
        setTimeout(waitForIdleRobot, 5000);
    }
}

// Implementação do streaming bidirecional para a fila
function queueStream(call) {
    call.on('data', (queueRequest) => {
        const { robotId, locationId, status } = queueRequest;
        queue.enqueue({ robotId, locationId, status });
        call.write({ message: `Queued robot ${robotId} for location ${locationId}` });
    });

    call.on('end', () => {
        call.end();
    });
}

// Iniciar o servidor gRPC
const server = new grpc.Server();
server.addService(robotServiceProto.RobotService.service, {
    GetLocations: getLocations,
    GetRobots: getRobots,
    CallRobot: callRobot,
    CancelCall: cancelCall,
    QueueStream: queueStream
});

server.bindAsync('0.0.0.0:50051', grpc.ServerCredentials.createInsecure(), () => {
    server.start();
    console.log('gRPC server running on port 50051');
});
