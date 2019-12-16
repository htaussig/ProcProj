const TEXTSIZE = 17;
const SPACING = TEXTSIZE * 0.155;
const GRIDSIZE = TEXTSIZE + SPACING;
//const NUMCOLS = 10;

const freq = 6;
const NUMTICKSMIN = 2; //before update
const NUMTICKSMAX = 8; //exclusive

const RAINVEL = 0.01;

const MORPHCHANCE = 0.01;
const ONLIFE = 170;
const BRIGHTDIFFMAG = 20;

const MARGIN = 55;

//const FPS = 24;

let d = new Date();
let lastTime = 0;
let lastTimeTick = 0;
let myFont;

var rains = [];

const RECORDING = false;

// the frame rate (frames per second)
var fps = 30;

// the canvas capturer instance
var capturer = new CCapture({ format: 'png', framerate: fps });

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
 
  //var dt = frameCount - lastTime;
  //dt /= 1000;
  
  //console.log(time);
  //console.log(dt, numTicks * tickLength);
  //console.log(numTicks * tickLength > dt);

  rains.forEach(rain => {
    
    rain.update();
    rain.display(width, height);
    //console.log(rain);
  });
}


function draw() {
    background(0);
    //textSize(TEXTSIZE);
    displayAll();
    if(RECORDING){
      
    }
}
