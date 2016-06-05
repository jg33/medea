// Generated by CoffeeScript 1.10.0
var currentScene, io, server;

server = require('http').createServer();

io = require('socket.io')(server);

currentScene = 0;

io.on('connection', function(socket) {
  console.log("connected!");
  socket.on('event', function(data) {});
  return socket.on('disconnect', function() {});
});

server.listen(3000);

console.log("running...");

//# sourceMappingURL=medeaServer.js.map
