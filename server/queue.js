const fs = require('fs');
const path = require('path');
const queueFilePath = path.join(__dirname, './mocks/queue.json');

// Função para ler a fila do arquivo JSON
function readQueue() {
    if (fs.existsSync(queueFilePath)) {
        const data = fs.readFileSync(queueFilePath, 'utf8');
        return JSON.parse(data);
    }
    return [];
}

// Função para gravar a fila no arquivo JSON
function writeQueue(queue) {
    fs.writeFileSync(queueFilePath, JSON.stringify(queue, null, 2), 'utf8');
}

// Função para adicionar um item à fila
function enqueue(item) {
    const queue = readQueue();
    queue.push(item);
    writeQueue(queue); // Salva a fila no arquivo
    console.log(`Enqueued: ${JSON.stringify(item)}`);
}

// Função para remover o primeiro item da fila
function dequeue() {
    const queue = readQueue();
    const item = queue.shift();
    writeQueue(queue); // Salva a fila no arquivo
    console.log(`Dequeued: ${JSON.stringify(item)}`);
    return item;
}

// Função para obter o estado atual da fila
function getQueue() {
    return readQueue();
}

// Função para verificar se a fila está vazia
function isEmpty() {
    const queue = readQueue();
    return queue.length === 0;
}

module.exports = {
    enqueue,
    dequeue,
    getQueue,
    isEmpty
};
