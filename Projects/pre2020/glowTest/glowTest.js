
function preload(){
  myFont = loadFont("assets/typewriter.ttf");
}

function setup() {
  createCanvas(675, 675, WEBGL);
  textFont(myFont);
  colorMode(HSB);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  noStroke();
  textSize(25);
}

function draw() {
  background(0);
  strokeWeight(13);
  fill(115, 35, 99);
  stroke(115, 99, 99);
  //translate(width / 2, height / 2, 0);
  text("hiadf", 0, 0);
  ellipse(200, 200, 10, 10);
}
