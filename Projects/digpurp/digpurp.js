const TEXTSIZE = 20;
const SPACING = TEXTSIZE * 0.195;
const GRIDSIZE = TEXTSIZE + SPACING;
//const NUMCOLS = 10;

const RAINVEL = 0.01;

//const FPS = 24;

let d = new Date();
let lastTime = 0;
let lastTimeTick = 0;
let myFont;

var rains = [];

function preload(){
  myFont = loadFont("assets/migu.ttf");
}

function setup() {
  p5.disableFriendlyErrors = true;
  createCanvas(1000, 1000);
  frameRate(30);
  
  //textFont(myFont, TEXTSIZE);
  textSize(TEXTSIZE);

  for (var i = 0; i < 1; i += GRIDSIZE / width) {
    rains.push(new Rain(i, 0, RAINVEL, 15, GRIDSIZE / width, height));
  }
  
}

const displayAll = () => {
 
  var dt = frameCount - lastTime;
  //dt /= 1000;
  
  //console.log(time);
  //console.log(dt, numTicks * tickLength);
  //console.log(numTicks * tickLength > dt);

  rains.forEach(rain => {

   
    rain.updateState();
    
    rain.update();
    rain.display(width, height);
    //console.log(rain);
  });
}


function draw() {
    background(0);
    //textSize(TEXTSIZE);
    displayAll();
}
