server = require('http').createServer()
io = require('socket.io')(server)

currentScene = 0


io.on('connection', (socket)->
  console.log("connected!")
  socket.on('event', (data)->)
  socket.on('disconnect', ()->)
)


server.listen(3000)
console.log("running...")