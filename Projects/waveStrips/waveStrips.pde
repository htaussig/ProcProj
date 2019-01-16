
ArrayList<WaveStrip> arr;

float NUMWAVES = 40;

//number of triangles per row
int NUMTRIS = 6;

float PERIOD = 3.5;

boolean RECORDING = false;

//var capture;
//var c;
//var gif;

void setup() {
  size(400, 400);

  arr = new ArrayList<WaveStrip>();

  //frameRate(10);

  for (int i = 0; i <= NUMWAVES; i++) {
    colorMode(HSB);
    color col = color((i / NUMWAVES) * 255, 255, 255);
    arr.add(new WaveStrip((i + 1) * height / NUMWAVES, width, 15, (i / NUMWAVES) * TWO_PI * PERIOD, col));
  }

  //c = createCanvas(400, 400);
  /**capture = createCapture(VIDEO);
   capture.size(320, 240);
   capture.hide();**/
}

void drawBackground(){
  strokeWeight(1);
  for(int y = 0; y < height; y++){
    noFill();
    colorMode(HSB);
    stroke((frameCount / 3.5 + (y / (float) height) * 255 / 2) % 255, 255, 255);
    line(0, y, width, y);
  }
}

void draw() {
  background(255);
  
  //drawBackground();
  
  strokeWeight(2);
  stroke(0);

  //stroke(255);
  noFill();
  //noStroke();
  //fill(0);
  //noFill();

  for (int i = (int) NUMWAVES - 1; i >= 0; i--) {
    WaveStrip ws = arr.get(i);

    ws.display();
  }
  if (RECORDING) {
    if (3.5 * 256 > frameCount) {
      println("yee");
      saveFrame("movie/f###-waveStrips.png");
    }
  }
}
