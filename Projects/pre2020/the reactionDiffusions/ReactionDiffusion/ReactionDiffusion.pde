
// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for this video: https://youtu.be/BV9ny785UNc

// Written entirely based on
// http://www.karlsims.com/rd.html

// Also, for reference
// http://hg.postspectacular.com/toxiclibs/src/44d9932dbc9f9c69a170643e2d459f449562b750/src.sim/toxi/sim/grayscott/GrayScott.java?at=default



Cell[][] grid;
Cell[][] prev;

int NUMTHINGS = 225;
float hueAdd = 100;
float hueAddChange = .5;

//about a third of 255 for tirtiary colors
float HUEAMP = 85;

void setup() {

  
  frameRate(1000);
  size(500, 500, JAVA2D);
  grid = new Cell[width][height];
  prev = new Cell[width][height];

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j ++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b);
      prev[i][j] = new Cell(a, b);
    }
  }

  for (int n = 0; n < NUMTHINGS; n++) {
    int startx = int(random(20, width-20));
    int starty = int(random(20, height-20));

    for (int i = startx; i < startx+10; i++) {
      for (int j = starty; j < starty+10; j ++) {
        float a = 1;
        float b = 1;
        grid[i][j] = new Cell(a, b);
        prev[i][j] = new Cell(a, b);
      }
    }
  }
}

float dA = 1.0;
float dB = 0.5;
float feed = .062;
//originally 0.62
float k = 0.062;

class Cell {
  float a;
  float b;

  Cell(float a_, float b_) {
    a = a_;
    b = b_;
  }
}


void update() {
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {

      Cell spot = prev[i][j];
      Cell newspot = grid[i][j];

      float a = spot.a;
      float b = spot.b;

      float laplaceA = 0;
      laplaceA += a*-1;
      laplaceA += prev[i+1][j].a*0.2;
      laplaceA += prev[i-1][j].a*0.2;
      laplaceA += prev[i][j+1].a*0.2;
      laplaceA += prev[i][j-1].a*0.2;
      laplaceA += prev[i-1][j-1].a*0.05;
      laplaceA += prev[i+1][j-1].a*0.05;
      laplaceA += prev[i-1][j+1].a*0.05;
      laplaceA += prev[i+1][j+1].a*0.05;

      float laplaceB = 0;
      laplaceB += b*-1;
      laplaceB += prev[i+1][j].b*0.2;
      laplaceB += prev[i-1][j].b*0.2;
      laplaceB += prev[i][j+1].b*0.2;
      laplaceB += prev[i][j-1].b*0.2;
      laplaceB += prev[i-1][j-1].b*0.05;
      laplaceB += prev[i+1][j-1].b*0.05;
      laplaceB += prev[i-1][j+1].b*0.05;
      laplaceB += prev[i+1][j+1].b*0.05;

      //good values .03 to .082
      float feedHere = map(i, width - 1, 1, .013, .123);
      //float val = map(j, height - 1, 1, .025, .08);
      float val = map(j, height - 1, 1, .013, .123);
      
      feedHere = (feedHere + val) / 2;
      //vary k with y??
  
      newspot.a = a + (dA*laplaceA - a*b*b + feedHere*(1-a))*1;
      newspot.b = b + (dB*laplaceB + a*b*b - (k+feedHere)*b)*1;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
    }
  }
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void draw() {
  //println(frameRate);
  background(0);

  for (int i = 0; i < 100; i++) {
    update();
    swap();
  }

  loadPixels();
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {
      Cell spot = grid[i][j];
      float a = spot.a;
      float b = spot.b;
      int pos = i + j * width;

      float val = (a-b) * HUEAMP + hueAdd;
      /**if(val < 123){
       val = 0;
       }
       else{
       val = 255; 
       }**/

      colorMode(HSB);

      color col = color(val % 255, 255, 255);
      val = (a-b) * 255;
      
      val = map(val, 0, 255, 0, 2);
      val *= val;
      
      val = map(val, 0, 2, 0, 255);
      
      col = color(val);

      pixels[pos] = col;
    }
  }
  updatePixels();
  hueAdd += hueAddChange;
  
}

void borders() {

  float w = 7;
  noStroke();
  //fill(pal.getLightestColor());
  fill(0);
  rect(0, 0, width, w);
  rect(0, height - w, width, height);

  rect(0, 0, w, height);
  rect(width - w, 0, width, height);

  noFill();
  strokeWeight(15);
  stroke(0);
  //rect(w, w, width - w * 2, height - w * 2);
}

void keyPressed() {
  if (key == 's') {
    borders();
    saveFrame("ReactionDiffusion-######.png");
    System.out.println("Frame saved");
  }
  if(key == 'x'){
    feed -= .001;
    System.out.println(feed);
  }
  if(key == 'y'){
    feed += .001;
    System.out.println(feed);
  }
  if(key == 'a'){
    k -= .001;
    System.out.println(k);
  }
  if(key == 'b'){
    k += .001;
    System.out.println(k);
  }
}
