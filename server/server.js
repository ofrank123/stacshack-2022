var ws = require('ws')
var uuid = require('uuid').v4;

var server = new ws.Server({ port: 9060 })

var gameState = {
    players: [],
}

server.on('connection', server => {
    server.on('message', message => {
        let data = JSON.parse(message);
        handleMessage(server, data);
    });

    server.on('close', (code, reason) => {
        console.log(code, reason);
    });

});

function sendMessage(con, msg) {
    con.send(JSON.stringify(msg));
}

function handleMessage(con, msg) {
    switch (msg.type) {
        case "connect": { 
            handleConnect(con, msg); 
            break;
        }
        case "poll": {
            handlePoll(con, msg);
            break;
        }
        case "move": { 
            handleMove(con, msg);
            break;
        }
        case "disconnect": { 
            handleDisconnect(con, msg) 
            break;
        }
        default: {
            sendMessage(con, {type: "error", msg: "could not connect"});
        }
    }
}

function handleMove(con, msg) {
    player = gameState.players.find(player => player.id === msg.id)
    gameState.players = gameState.players.filter(player => player.id !== msg.id)
    gameState.players = [...gameState.players, {id: msg.id, pos: msg.pos}]
}

function handlePoll(con, msg) {
    sendMessage(con, {
        type: "game-state",
        gameState,
    })
}

function handleConnect(con, msg) {
    let id = uuid();
    gameState.players = [...gameState.players, {id, pos: {x: 0, y: 0}}]

    sendMessage(con, {
        type: "connected",
        id,
    });
    sendMessage(con, {
        type: "game-state",
        gameState,
    })
}
