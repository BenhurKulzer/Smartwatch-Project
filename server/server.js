const express = require('express');
const bodyParser = require('body-parser');

const robots = require('./robots.js'); // Importa a classe Robots
const locations = require('./mocks/locations.json'); // Importa as localizações
const queue = require('./queue.js'); // Importa a fila

const app = express();
app.use(bodyParser.json());

// Função para registrar na fila
function logQueueItem(robotId, locationId, status) {
    const queueItem = { robotId, locationId, status };
    queue.enqueue(queueItem);
}

// Envia o robô para a localização
function sendRobotToLocation(robot, locationId) {
    const location = locations.find(loc => loc.id === locationId);

    if (!location) {
        console.error(`Location with ID ${locationId} not found.`);
        return;
    }

    console.log(`${robot.name} is being sent to ${location.name}`);

    // Atualiza o status do robô para "Running" e diminui 10% da bateria
    robots.updateRobotStatus(robot.id, "Running", -10);

    // Registra o envio do robô na fila
    logQueueItem(robot.id, locationId, "Running");

    setTimeout(() => {
        console.log(`${robot.name} has arrived at ${location.name}`);

        // Atualiza o status para "Idle" após chegar à localização
        robots.updateRobotStatus(robot.id, "Idle");

        // Se a bateria estiver baixa, coloca o robô para carregar
        if (robot.battery <= 20) {
            robots.updateRobotStatus(robot.id, "Charging");

            setTimeout(() => {
                robots.updateRobotStatus(robot.id, "Idle", 100); // Recarga a bateria completamente
                console.log(`${robot.name} is fully charged and Idle`);
            }, 3600000); // 1 hora para recarregar totalmente
        }

        // Processa a próxima tarefa na fila
        waitForIdleRobot();
    }, 60000); // 1 minuto para o robô chegar ao destino
}

// Aguarda robôs disponíveis
function waitForIdleRobot() {
    if (queue.isEmpty()) {
        console.log('Queue is empty, no robots to assign.');
        return;
    }

    const availableRobot = robots.getAvailableRobot(); // Verifica se há robô disponível

    if (availableRobot) {
        const nextInQueue = queue.dequeue(); // Remove o próximo item da fila
        if (nextInQueue) {
            sendRobotToLocation(availableRobot, nextInQueue.locationId);
        }
    } else {
        console.log('No robots available, still waiting.');
        setTimeout(waitForIdleRobot, 5000); // Verifica novamente em 5 segundos
    }
}

// Endpoint para obter localizações
app.get('/api/locations', (req, res) => {
    res.json(locations); // Retorna a lista de localizações
});

// Endpoint para obter robôs
app.get('/api/robots', (req, res) => {
    res.json(robots.readRobots()); 
});

// Endpoint para enviar um robô para uma localização
app.post('/api/robots/call', (req, res) => {
    const { locationId } = req.body;
    const availableRobot = robots.getAvailableRobot(); // Verifica se há robôs disponíveis

    if (availableRobot) {
        // Se houver robô disponível, envia-o para a localização
        sendRobotToLocation(availableRobot, locationId);
        res.status(200).send(`${availableRobot.name} is being sent to location ID ${locationId}.`);
    } else {
        // Se não houver robô disponível, adiciona à fila
        const queueItem = { locationId };
        queue.enqueue(queueItem); // Adiciona à fila
        res.status(200).send(`All robots are busy. Request for location ID ${locationId} has been enqueued.`);
        waitForIdleRobot(); // Função para aguardar robô ficar disponível
    }
});

// Endpoint para verificar a fila atual
app.get('/api/queue', (req, res) => {
    const currentQueue = queue.getQueue();
    res.json(currentQueue);
});

// Inicia o servidor
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
