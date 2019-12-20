/*
 * @name Game of Life
 * @description A basic implementation of John Conway's Game of Life CA
 * (<a href="http://natureofcode.com">natureofcode.com</a>)
 */

const TEXTSIZE = 30;
const w = 15;
const NUMWORDS = 100;
const RANDOMSTART = false;

var seedNum = 0; //set this to 0 for random seed, non-zero for that specific seed

var columns;
var rows;
var board;
var next;

var symbolBoard;
var generating = true;


let myFont;


var words = [];
//just put these in lower case and then we randomize
words.push("merrychristmas!");
words.push("filthyanimal!");
words.push("happy");
words.push("holidays");
words.push("poop");
words.push("snow");
words.push("santawatches");
//words.push("nutsack");
//words.push(":(");
//words.push("XD");
//words.push("iamsocool");
//words.push("wordswords");
//words.push("fuck");
//words.push("idiot!");
//words.push("shit");
//words.push("smallpoop");
//words.push("damn");
//words.push("hell");
//words.push("crap");

function preload(){
  //myFont = loadFont('monospace');
}

function setup() {
  createCanvas(800, 800);
  frameRate(30);
  textFont('monospace');
  textSize(w);
  // Calculate columns and rows
  columns = floor(width/w);
  rows = floor(height/w);
  // Wacky way to make a 2D array is JS
  board = new Array(columns);
  symbolBoard = new Array(columns);
  for (var i = 0; i < columns; i++) {
    board[i] = new Array(rows);
    symbolBoard[i] = new Array(rows);
  } 
  // Going to use multiple 2D arrays and swap them
  next = new Array(columns);
  for (i = 0; i < columns; i++) {
    next[i] = new Array(rows);
  }
  strokeWeight(0);
  init();
}

function draw() {
  background(0);
  if(frameCount % 2 == 0){
    if(generating){
       generate();
    }
  }
  for ( var i = 0; i < columns;i++) {
    for ( var j = 0; j < rows;j++) {
      if ((board[i][j] == 1)){
        fill(0);
        symbolBoard[i][j].setOn();
      }
      else {
        fill(255); 
      }
      //symbolBoard[i][j].update();
      stroke(0);
      push();
      translate(i*w, j*w);
      symbolBoard[i][j].display();
      //rect(0, 0, w-1, w-1);
      pop();
    }
  }
  
}

// Fill board randomly
function init() {
  initSeeding();
  for (var i = 0; i < columns; i++) {
    for (var j = 0; j < rows; j++) {
      // Lining the edges with 0s
      if (i == 0 || j == 0 || i == columns-1 || j == rows-1) board[i][j] = 0;
      // Filling the rest randomly
      else board[i][j] = floor(random(2));
      if(!RANDOMSTART){
        board[i][j] = 0;
        generating = false;
      }
      next[i][j] = 0;
      symbolBoard[i][j] = new Symbol(0, 0);
    }
  }
  setWords();
}

//keep in mind the random seeding will only work perfectly on the first run?
function initSeeding(){  
  if(seedNum == 0){
    seedNum = random(-10000000, 10000000);
  }
  randomSeed(seedNum);
  print("the current seed is: " + seedNum);
}

function setWords(){
  for(var i = 0; i < NUMWORDS; i++){
    addWord(); 
  }
}

function addWord(){
  var i = Math.floor(random(0, columns));
  var j = Math.floor(random(0, rows));
  var indexAdd = 0; //add to v or h depending on the var below  
  var word = words[Math.floor(random(0, words.length))];
  var vOrH = 0; //vertical or horizontal
  if(random(0, 1) < 0.9){
    console.log("hey");
    vOrH = 1;
  }
  for(var n = 0; n < word.length; n++){
    if(vOrH == 0){
      j++;
    }
    else{
      i++;
    }
    var theChar = word.charAt(n);
    var charCode = theChar.charCodeAt(0);
    
    //randomize capitilization
    if(isLetter(theChar)){
      //if(isUpperCase(theChar)){
        if(random() < 0.5){
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
    
    symbolBoard[i % columns][j % rows].lockedChar = theChar;
  }
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

// The process of creating the new generation
function generate() {
  
  // Loop through every spot in our 2D array and check spots neighbors
  for (var x = 1; x < columns - 1; x++) {
    for (var y = 1; y < rows - 1; y++) {
      // Add up all the states in a 3x3 surrounding grid
      var neighbors = 0;
      for (var i = -1; i <= 1; i++) {
        for (var j = -1; j <= 1; j++) {
          neighbors += board[x+i][y+j];
        }
      }

      // A little trick to subtract the current cell's state since
      // we added it in the above loop
      neighbors -= board[x][y];
      // Rules of Life
      if      ((board[x][y] == 1) && (neighbors <  2)) next[x][y] = 0;           // Loneliness
      else if ((board[x][y] == 1) && (neighbors >  3)) next[x][y] = 0;           // Overpopulation
      else if ((board[x][y] == 0) && (neighbors == 3)) next[x][y] = 1;           // Reproduction
      else                                             next[x][y] = board[x][y]; // Stasis
    }
  }

  // Swap!
  var temp = board;
  board = next;
  next = temp;
}

function keyPressed(){
  if(key == 's'){
    print("saving video");
    //TODO: save video here
  }
  else if(key == 'g'){
    generating = !generating;
    print("toggling generation to: " + generating);
  }
  else{
    init();
  }
}

function mousePressed() {
  //w
  //translate(i*w, j*w);
  //columns, rows
  var i = floor(mouseX / w);
  var j = floor(mouseY / w);
  if(i >= 0 && i < columns && j >= 0 && j < columns){
    board[i][j] = 1;
    symbolBoard[i][j].setOn();
  }
}
