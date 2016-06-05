currentScene = 0
socket = io('http://localhost:3000')


checkServer = ()->
  console.log("checking server...")


setup = ()->
  createCanvas(window.innerWidth,window.innerHeight)

draw = ()->
  background(0)
  fill(255,0,0)
  ellipse(mouseX,mouseY,40,40)


setInterval(checkServer,1000)