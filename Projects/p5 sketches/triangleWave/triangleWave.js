var arr = [];

var NUMWAVES = 40;

var PERIOD = 3.5;

var RECORDING = false;

//var capture;
//var c;
//var gif;

function setup() {
  createCanvas(400, 400);

  //frameRate(10);

  for (var i = 0; i <= NUMWAVES; i++) {
    arr[i] = new WaveStrip((i + 1) * height / NUMWAVES, width, 15, (i / NUMWAVES) * TWO_PI * PERIOD);
  }

  //c = createCanvas(400, 400);
  /**capture = createCapture(VIDEO);
   capture.size(320, 240);
   capture.hide();**/
}

function draw() {
  background(0);

  //stroke(0);
  noStroke();
  fill(255);

  for (var i = 0; i < NUMWAVES; i++) {
    var ws = arr[i];

    ws.display();
  }
  if(RECORDING){
    save();
  } 
}
