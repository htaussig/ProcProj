var seedNum = 2641019.7747919336; //0 for random seeds 2641019.7747919336

var THEWORD = "merry christmas ";
var THEWORD2 = "ya filthy animal";

const TEXTSIZE = 17;
const SPACING = TEXTSIZE * 0.055;
const GRIDSIZE = TEXTSIZE + SPACING;
//const NUMCOLS = 10;

const freq = 6;
const NUMTICKSMIN = 3; //before update
const NUMTICKSMAX = 14; //exclusive

const RAINVEL = 0.01;

const MORPHCHANCE = 0.01;
const ONLIFE = 130;
const BRIGHTDIFFMAG = 20;

const MARGIN = 55;

const NUMFRAMES = 250;

const ZOOMMAG = 575; //650 for one

//const FPS = 24;

let haveSwappedWord = false;

let columns, rows;

let d = new Date();
let lastTime = 0;
let lastTimeTick = 0;
let myFont;

let boardZ = 0;

let time = 0;

var rains = [];

var ease = new p5.Ease(); //from p5.func library

const RECORDING = false;

// the frame rate (frames per second)
var fps = 60;

// the canvas capturer instance
var capturer = new CCapture( { 
format: 
'png', framerate: 
  fps
}
);

function preload() {
  //myFont = loadFont("assets/migu.ttf");
  myFont = loadFont("assets/typewriter.ttf");
}

function setup() {
  createCanvas(1000, 1000, WEBGL);
  frameRate(fps);
  initSeeding();
  //textMode(SHAPE);

  p5.disableFriendlyErrors = true;

  //textFont(myFont, TEXTSIZE);
  textFont(myFont);
  textSize(TEXTSIZE);

  for (var i = 0; i < 1; i += GRIDSIZE / width) {
    rains.push(new Rain(i, 0, RAINVEL, 15, GRIDSIZE / width, height));
  }

  columns = floor(width/GRIDSIZE);
  rows = floor(height/GRIDSIZE);  
  initLockWords();

  //print(ease.listAlgos());

  textAlign(CENTER, CENTER);

  if (RECORDING) {
    capturer.start();
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
  }
  );
}


function draw() {
  translate(-width / 2, -height / 2, -boardZ);

  var camZ = ease.cubicInOut(time) * ZOOMMAG;
  if (time < 1.75) {
    time += 1 / NUMFRAMES;
    
    if(time > 1.1 && !haveSwappedWord){
      haveSwappedWord = true;
      addWordCenter(THEWORD2, 0);
    }
    
  } else if (time >= 1.75) {
    time = 0;
    //if (boardZ == 0) {
    //  boardZ = ZOOMMAG;
    //} else {
    //  boardZ = 0;
    //}
    resetBoard();
  }
  //console.log(time, camZ);

  translate(0, 0, camZ);
  background(0);
  //textSize(TEXTSIZE);
  displayAll();
  //loadPixels();
  //filter(BLUR, 5);
  if (RECORDING) {
    capturer.capture(document.getElementById('defaultCanvas0'));
  }
}

function initSeeding() {  
  if (seedNum == 0) {
    seedNum = random(-10000000, 10000000);
  }
  randomSeed(seedNum);
  print("the current seed is: " + seedNum);
}

function displayWordFake() {
}

function initLockWords() {
  addWordCenter(THEWORD, 0);
  //addWordCenter(THEWORD2, 2);
}

function resetBoard() {

  for (var i = 0; i < columns; i++) {
    for (var j = 0; j < rows; j++) {
      rains[i % columns].symbols[j % rows].reset();
    }
  }
}

function addWordCenter(word_, dy) {
  var word = word_;
  //var word = THEWORD;
  var i = Math.floor(columns / 2.0) - Math.round((word.length / 2)) + 0;
  var j = Math.round(rows / 2.0) - 1 + dy;
  //var indexAdd = 0; //add to v or h depending on the var below  
  var vOrH = 1; //vertical or horizontal
  //if (random(0, 1) < 0.9) {
  //  //console.log("hey");
  //  vOrH = 1;
  //  //horizontal
  //}
  //if (isWordSafe(word.length, vOrH, i, j)) {
  for (var n = 0; n < word.length; n++) {
    if (vOrH == 0) {
      j++;
    } else {
      i++;
    }
    var theChar = word.charAt(n);
    var charCode = theChar.charCodeAt(0);

    //randomize capitilization
    if (isLetter(theChar)) {
      //if(isUpperCase(theChar)){
      if (random() < 0.5) {
        charCode -= 32;
      }
      //}
      //else if(isLowerCase(theChar)){
      //  if(random() < 0.5){
      //    charCode -= 32;
      //  }
      //}
      //else{
      //  print("error in is letter, not upper or lower case");
      //}
    }


    theChar = String.fromCharCode(charCode);
    //print("newChar: " + theChar + " charCode: " + charCode);

    //console.log(theChar);
    rains[i % columns].symbols[j % rows].lockedChar = theChar;
  }
  //}
  // else {
  //  addWord();
  //}
}

function isLetter(str) {
  return str.length === 1 && str.match(/[A-Z|a-z]/i);
}

function isUpperCase(str) {
  return str.length === 1 && str.match(/[A-Z]/i);
}

function isLowerCase(str) {
  return str.length === 1 && str.match(/[a-z]/i);
}

function keyPressed() {
  if (RECORDING) {
    console.log('finished recording.');
    capturer.stop();
    capturer.save();
  }
}
