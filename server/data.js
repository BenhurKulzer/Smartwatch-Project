const locations = [
    { id: 1, name: 'StandBy' },
    { id: 2, name: 'Kitchen' },
    { id: 3, name: 'T 1' },
    { id: 4, name: 'T 2' },
    { id: 5, name: 'T 3' },
    { id: 6, name: 'T 4' },
    { id: 7, name: 'T 5' },
    { id: 8, name: 'T 6' },
    { id: 9, name: 'T 7' },
    { id: 10, name: 'T 8' },
    { id: 11, name: 'T 9' },
    { id: 12, name: 'Warehouse' },
];

const robots = [
    { id: 1, name: 'Robot A', battery: 80, status: 'Running' },
    { id: 2, name: 'Robot B', battery: 60, status: 'Idle' },
    { id: 3, name: 'Robot C', battery: 40, status: 'Idle' },
    { id: 4, name: 'Robot D', battery: 13, status: 'Running' },
    { id: 5, name: 'Robot E', battery: 0, status: 'Offline' },
    { id: 6, name: 'Robot F', battery: 90, status: 'Running' },
    { id: 7, name: 'Robot G', battery: 100, status: 'Charging' },
    { id: 8, name: 'Robot H', battery: 89, status: 'Idle' },
    { id: 9, name: 'Robot I', battery: 32, status: 'Running' },
];

const destinations = [
    { id: 1, location: 3, robot: 1 },
    { id: 2, location: 6, robot: 4 },
    { id: 3, location: 2, robot: 6 },
    { id: 4, location: 2, robot: 9 },
    { id: 5, location: 1, robot: 2 },
    { id: 6, location: 1, robot: 3 },
    { id: 7, location: 1, robot: 8 }
];

module.exports = { locations, robots, destinations };
