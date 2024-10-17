class Queue {
    constructor() {
      this.items = [];
    }
  
    // Adds a new item to the queue
    enqueue(item) {
      this.items.push(item);
    }
  
    // Removes the first item from the queue
    dequeue() {
      if (this.isEmpty()) return null;
      return this.items.shift();
    }
  
    // Checks if the queue is empty
    isEmpty() {
      return this.items.length === 0;
    }
  
    // Returns the first item in the queue without removing it
    peek() {
      if (this.isEmpty()) return null;
      return this.items[0];
    }
  
    // Returns the entire queue
    getQueue() {
      return this.items;
    }
  
    // Clears the queue
    clear() {
      this.items = [];
    }
}
  
module.exports = new Queue();
