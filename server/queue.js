const fs = require('fs');
const path = require('path');
const queueFilePath = path.join(__dirname, './mocks/queue.json');

function readQueue() {
    if (fs.existsSync(queueFilePath)) {
        const data = fs.readFileSync(queueFilePath, 'utf8');
        return JSON.parse(data);
    }

    return [];
}

function writeQueue(queue) {
    fs.writeFileSync(queueFilePath, JSON.stringify(queue, null, 2), 'utf8');
}

function enqueue(item) {
    const queue = readQueue();
    queue.push(item);

    writeQueue(queue);
    
    console.log(`Enqueued: ${JSON.stringify(item)}`);
}

function dequeue() {
    const queue = readQueue();
    const item = queue.shift();

    writeQueue(queue);
    console.log(`Dequeued: ${JSON.stringify(item)}`);

    return item;
}

function getQueue() {
    return readQueue();
}

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
