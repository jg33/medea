server = require('http').createServer()
io = require('socket.io')(server)
keypress = require('keypress')

keypress(process.stdin)

clientIDs=[]

sharedData = {
  currentScene:0,
  testString:"testThing"}

connectedUsers = 0

handleHello = (data)->
  console.log("hello "+ data)
  console.log(@id)
  io.sockets.sockets[@id].emit('pingback',sharedData)

handleCheck = (data)->
  console.log("check in")
  io.sockets.sockets[@id].emit('pingback',sharedData)
  console.log(@id +" pinged.")



io.on('connection', (socket)->
  connectedUsers++
  clientIDs.push(socket.id)
  console.log("user connected! "+connectedUsers+" connected. ID= "+socket.id)

  socket.on('hello', handleHello)
  socket.on('disconnect', ()->
    connectedUsers--
    console.log("disconnected... "+connectedUsers+" left.")

  )
)

setScene = (newScene)->
  sharedData.currentScene = newScene
  console.log("set scene " + newScene)
  io.emit('pingback',sharedData)


process.stdin.on('keypress', (ch, key)->
  console.log('got keypress ', key)
  if (key && key.ctrl && key.name == 'c')
    process.stdin.pause()
  else if (key && key.name == 'q')
    setScene(1)
  else if (key && key.name == 'w')
    setScene(2)

)

process.stdin.setRawMode(true)
process.stdin.resume()

server.listen(3000)
console.log("running...")
