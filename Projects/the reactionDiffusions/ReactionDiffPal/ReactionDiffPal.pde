//DOES NOT WORK

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

int NUMCOLPOINTS = 12;

int NUMTHINGS = 17;
float hueAdd = 100;
float hueAddChange = .5;

//about a third of 255 for tirtiary colors
float HUEAMP = 85;

//int numPoints = 1;
//ArrayList<PVector> points = new ArrayList<PVector>();

int WAITFRAMES = 100;

//the minimum value needed for a color to spread to the value
float MINSPREAD = 30;

void setup() {
  frameRate(1000);
  size(300, 300);
  grid = new Cell[width][height];
  prev = new Cell[width][height];

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j ++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b, 0);
      prev[i][j] = new Cell(a, b, 0);
    }
  }

  for (int n = 0; n < NUMTHINGS; n++) {
    int startx = int(random(20, width-20));
    int starty = int(random(20, height-20));

    for (int i = startx; i < startx+10; i++) {
      for (int j = starty; j < starty+10; j ++) {
        float a = 1;
        float b = 1;
        grid[i][j] = new Cell(a, b, 0);
        prev[i][j] = new Cell(a, b, 0);
      }
    }
  }

  genColPoints();
}

void genColPoints() { 
  for (int n = 0; n < NUMCOLPOINTS; n++) {
    int startx = int(random(20, width-20));
    int starty = int(random(20, height-20));

    // a 10 by 10 set of pixels
    //for (int i = startx; i < startx+10; i++) {
    //for (int j = starty; j < starty+10; j ++) {
    //random(255), random(255), random(255)
    color col = color(255, 0, 0);
    grid[startx][starty] = new Cell(0, 0, 1, col);
    prev[startx][starty] = new Cell(0, 0, 1, col);
    //}
    // }
  }
}

float dA = 1.0;
float dB = 0.5;
float feed = 0.0545;
//originally 0.62
float k = 0.062;

float cFeed = .1;

class Cell {
  float a;
  float b;
  float c;
  color col;

  Cell(float a_, float b_, float c_) {
    a = a_;
    b = b_;
    c = c_;
  }

  Cell(float a_, float b_, float c_, color col_) {
    this(a_, b_, c_);
    col = col_;
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

      newspot.a = a + (dA*laplaceA - a*b*b + feed*(1-a))*1;
      newspot.b = b + (dB*laplaceB + a*b*b - (k+feed)*b)*1;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);

      //only do this was the board is pretty filled
      if (frameCount > WAITFRAMES) {
        cSpread(spot, newspot, i, j);
      }
    }
  }
}

void cSpread(Cell spot, Cell newspot, int i, int j) {
  float val = getVal(spot);

  if (val > MINSPREAD) {
    float c = spot.c;

    //color stuff    
    //c will have to be an object, but right now we can use just one color
    float laplaceC = 0;

    //not sure why we would subtract if we add it back later
    laplaceC += c*-1;

    for (int x = i - 1; x <= i + 1; x++) {
      for (int y = j - 1; y <= j + 1; y++) {

        Cell ce = prev[x][y];
        if (spot != ce) {
          //print(i, j);
          //the .2 is arbitrary
            laplaceC += ce.c * .2;
            newspot.col = ce.col;
        }
      }
    }


    //this could be problematic
    newspot.c = c + laplaceC;

    newspot.c = constrain(newspot.c, 0, 1);
  } else {
    newspot.c = 0;
    newspot.col = color(0, 0, 255);
  }
}

float getVal(Cell c) {
  return (c.a - c.b) * 255;
}


//pour in the color to the proper points
/**void updateC() {
 
 for (PVector p : points) {
 Cell newspot = grid[(int) p.x][(int) p.y];
 newspot.c += .5;
 newspot.c = constrain(newspot.c, 0, 1);
 }
 }**/

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void draw() {
  println(frameRate);

  for (int i = 0; i < 10; i++) {

    //right order?
    //updateC();

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

      /**float val = (a-b) * HUEAMP + hueAdd;
       if(val < 123){
       val = 0;
       }
       else{
       val = 255; 
       }**/

      //colorMode(HSB);
      //color col = color(val % 255, 255, 255);

      float val = (a-b) * 255;
      color col = color(val);

      if (spot.c > 0 && frameCount > WAITFRAMES) {
        colorMode(HSB);
        //col = color(210, 255, val);
        col = spot.col;
      }

      pixels[pos] = col;
    }
  }
  updatePixels();
  hueAdd += hueAddChange;
}
