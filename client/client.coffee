
sharedData = []
socket = io('http://cornea:3000')


bShowingMessage = false;
message = "didn't work."
messageOpacity = 0;

bDebug = true



setup = ()->
  createCanvas(window.innerWidth,window.innerHeight)
  if geoCheck()
    console.log("geo good!")
  else
    console.log("geo bad!")

draw = ()->
  background(0)
  fill(255,0,0)
  ellipse(mouseX,mouseY,40,40)

  switch sharedData.currentScene
    when 0
      background(0)
      if(bShowingMessage)
        fill(255, messageOpacity)
        text(message, width/2, height/2)
    when 1
      drawText()


  #debug
  if(bDebug)
    fill(255)
    text("Current Scene "+ sharedData.currentScene,0,10)

# Events #
mousePressed =()->
  socket.emit("clickTest", "HI HI HI")

keyPressed = ()->
  console.log("pressed " + key)
  if key is 'L'
    console.log("pressed l")
    getCurrentPosition((pos)->
      displayMessage("my position is: "+pos.latitude+" "+pos.longitude))
  return false

windowResized = ()->
  resizeCanvas(window.innerWidth,window.innerHeight)

# Communication #
checkServer = ()->
  socket.emit('hello', 'ping!')
  console.log("pinging server...")
  disableScroll.on()

socket.on('pingback',(data)->
  console.log(data.testString)
  sharedData = data
  )
socket.on('showMsg', (data)->
  displayMessage(data))


# Drawing Stuff #
drawText = ()->
  textAlign("center")
  text("hello friends", width/2, height/2,)


displayMessage = (msg)->
  console.log("showing message:" +msg)
  message = msg
  messageOpacity = 255
  bShowingMessage = true;
  setTimeout(()->
    messageOpacity=0
    bShowingMessage = false
  , 10000)



# Go. #
setInterval(checkServer,1000)

# Utility #


