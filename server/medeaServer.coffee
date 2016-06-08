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
  console.log("hello "+ @id)
  io.sockets.sockets[@id].emit('pingback',sharedData)

clickTest = (data)->
  console.log("clicked in: " + @id)
  io.sockets.sockets[@id].emit('showMsg',"HI, DUM DUM")



io.on('connection', (socket)->
  connectedUsers++
  clientIDs.push(socket.id)
  console.log("user connected! "+connectedUsers+" connected. ID= "+socket.id)

  socket.on('hello', handleHello)
  socket.on('clickTest', clickTest)
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
  if (key &&  key.name == 'x')
    process.exit()
  else if (key && key.name == 'q')
    setScene(1)
  else if (key && key.name == 'w')
    setScene(2)
  else if (key && key.name == 'e')
   setScene(3)
  else if (key && key.name == 'r')
    setScene(4)
  else if (key && key.name == 't')
    setScene(5)
  else if (key && key.name == 'y')
    setScene(6)
  else if (key && key.name == 'u')
    setScene(7)
  else if (key && key.name == 'i')
    setScene(8)
  else if (key && key.name == 'o')
    setScene(9)
  else if (key && key.name == 'p')
    setScene(10)




)

process.stdin.setRawMode(true)
process.stdin.resume()

server.listen(3000)
console.log("running...")
