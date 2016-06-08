sharedData = []
socket = io('http://localhost:3000')

bDebug = true

checkServer = ()->
  socket.emit('hello', 'ping!')
  console.log("pinging server...")


setup = ()->
  createCanvas(window.innerWidth,window.innerHeight)

draw = ()->
  background(0)
  fill(255,0,0)
  ellipse(mouseX,mouseY,40,40)

  #debug
  if(bDebug)
    fill(255)
    text("Current Scene "+ sharedData.currentScene,0,10)


mousePressed =()->
  socket.emit("hello", "HI HI HI")

socket.on('pingback',(data)->
  console.log(data.testString)
  sharedData = data
  )


# Go. #
setInterval(checkServer,1000)