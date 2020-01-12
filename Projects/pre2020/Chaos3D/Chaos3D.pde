//Franciszek Mirecki 2018

//edited by Harry Taussig 2018
//@GenerateSerendipity
//turned object oriented for easier modification

import peasy.*;

PeasyCam cam;
int distance = 450;

ArrayList<Vertex> p;

ArrayList<Vertex> points;

PVector drawer;

//final int n = 4;

float myFrameCount = 0;

float diam = 20.3;
float opacity = 255;

//for the vertices
//final float vertexSize = 12;

//number of shapes per iteration
int speed = 1700;
int numIterations = 3;

final boolean canBeSame = true;

float prev = -1;
float rA = 0;

//can use my PalletteBook Sketch, click on the pallettes, and copy them in here
Palette pal = new Palette("37#7A08FA26#A82FFC17#C264FE17#F8ECFD");

//float a = 0;

//the 5 platonic solids
//dodecahedron is hard
final int TETRA = 4;
final int CUBE = 1;
final int OCTA = 2;
final int ICOS = 3;

int MODE = TETRA;

final int drawSPHERE = 0;
final int drawCUBE = 1;
int DRAWMODE = drawSPHERE;

boolean orthoView = false;

float lerpPercent;
float a = 0;

float spinMult = 1 / 6.0;

boolean breath = true;
float breathSpeed = .0135;
float breathMag = 5;

boolean RECORDING = false;

void setup() {
  size(1200, 800, P3D);  
  frameRate(60);
  smooth(8);

  cam = new PeasyCam(this, distance);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(4 * distance);

  p = new ArrayList<Vertex>();
  points = new ArrayList<Vertex>();

  refresh();

  //for (int i = 0; i < n - 1; i++) {
  //  if (i < n - 2) p[i] = new PVector(random(width), random(height), 0);
  //  else p[n-2] = new PVector(random(width/2), random(height/2), depth);
  //  point(p[i].x, p[i].y, p[i].z);
  //}
}



void draw() {
  background(35);

  lights();

  //spotLight(255,255,255, 1000, 1000, 1000, -1, -1, -1, radians(1), 600);

  directionalLight(128, 128, 128, 1000, 1000, 1000);
  //directionalLight(100, 100, 100, -1000, -1000, 1000);
  directionalLight(25, 25, 25, -1000, -1000, 0);

  rotateY(a * spinMult);

  if (myFrameCount++ < speed) {
    for (int k = 0; k < numIterations; k++) {
      int r = floor(random(p.size()));
      if (canBeSame || r != prev) {
        /**if (r == 0) {
         drawer = PVector.lerp(drawer, p[0], getLerpPercent());
         c1Points.add(drawer);
         } else if (r == 1) {
         drawer = PVector.lerp(drawer, p[1], getLerpPercent());
         c2Points.add(drawer);
         } else if (r == 2) {
         drawer = PVector.lerp(drawer, p[2], getLerpPercent());
         c3Points.add(drawer);
         } else if (r == 3) {
         drawer = PVector.lerp(drawer, p[3], getLerpPercent());
         c4Points.add(drawer);
         }**/
        drawer = PVector.lerp(drawer, p.get(r).getPos(), getLerpPercent());
        points.add(new Vertex(drawer, getColor(r)));
        prev = r;
      }
    }
  } else if (myFrameCount == 500) {
    //frameCount = -1;
    print("Adding points have ended");
  }

  //strokeWeight(12);
  drawVertices();

  float oldDiam = 0;
  if (breath) {
    oldDiam = diam;
    diam = diam + cos(a) * breathMag;
    a += breathSpeed;
  }

  for (Vertex v : points) {
    v.display();
  }

  if (breath) {
    diam = oldDiam;
  }

  recordVid();
  //recordGif();
}

void refresh() {
  myFrameCount = 0;

  if (orthoView) {
    ortho();
  }

  sphereDetail(10);
  noStroke();

  p.clear();
  points.clear();

  addPoints();
  
    drawer = p.get((int) random(p.size())).pos;
}

void addPoints() {
  if (MODE == TETRA) {
    tetraSettings();
  } else if (MODE == CUBE) {
    cubeSettings();
  } else if (MODE == OCTA) {
    octaSettings();
  } else if (MODE == ICOS) {
    icosaSettings();
  }

  /**tetrahedron
   color c1 = color(139, 3, 252);
   color c4 = color(#03F6FC);
   color c2 = color(#03FC47);
   color c3 = color(#FC03E4);
   p.add(new Vertex(-a/2, h/3, H/4, c1));
   p.add(new Vertex(a/2, h/3, H/4, c2));
   p.add(new Vertex(0, -2*h/3, H/4, c3));
   p.add(new Vertex(0, 0, -3*H/4, c4));**/
}

void tetraSettings() {
  DRAWMODE = drawSPHERE;
  lerpPercent = .5;
  diam = 7.3;

  //float r = 200;

  float a = 400;

  float h = a * sqrt(3) / 2;
  float H = a * sqrt(6) / 3;

  p.add(new Vertex(-a/2, h/3, H/4));
  p.add(new Vertex(a/2, h/3, H/4));
  p.add(new Vertex(0, -2*h/3, H/4));
  p.add(new Vertex(0, 0, -3*H/4));
}

void cubeSettings() {
  DRAWMODE = drawCUBE;
  lerpPercent = .7;

  diam = 10.3;

  int numSides = 4;
  float r = 200;

  for (int i = 0; i < numSides; i++) {
    for (int y = -1; y <= 1; y += 2) {
      float a = (TWO_PI / numSides) * i;
      float z = y *  r / sqrt(2);
      p.add(new Vertex(cos(a) * r, sin(a) * r, z));
    }
  }
}

void octaSettings() {
  DRAWMODE = drawCUBE;
  lerpPercent = .7;
  diam = 17.3;

  int numSides = 4;
  float r = 200;

  for (int i = -1; i <= 1; i += 2) {
    float z = i * r;
    p.add(new Vertex(0, 0, z));
  }

  for (int i = 0; i < numSides; i++) {
    float a = (TWO_PI / numSides) * i;
    p.add(new Vertex(cos(a) * r, sin(a) * r, 0));
  }
}

void icosaSettings() {
  DRAWMODE = drawCUBE;
  diam = 5;
  lerpPercent = .7;
  float r = 170;

  //golden ratio baby
  float w = (1.618 / 2) * r;
  float h = 1 * r;

  float[] v = new float[3];
  v[0] = w;
  v[1] = h;
  v[2] = 0;

  //you can construct a regular icosahedrom from three orthogonal goldren rectangles
  for (int i = 0; i < 3; i++) {
    if (i == 1) {
      v[0] = 0;
      v[1] = w;
      v[2] = h;
    } else if (i == 2) {
      v[0] = h;
      v[1] = 0;
      v[2] = w;
    }

    p.add(new Vertex(v[0], v[1], v[2]));
    p.add(new Vertex(-v[0], v[1], -v[2]));
    p.add(new Vertex(v[0], -v[1], -v[2]));
    p.add(new Vertex(-v[0], -v[1], v[2]));
  }
}

float getLerpPercent() {
  //.7
  return lerpPercent;
}

color getColor(int num) {
  return pal.getColor();
}

void drawVertices() {
  for (Vertex v : p) {
    //v.display();
  }
}

void drawPoints(ArrayList<PVector> points, color c) {
  for (PVector p : points) {
    fill(c);
    pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(diam);
    popMatrix();
  }
}

void recordGif() {
  if (RECORDING) {
    print("saved");
    saveFrame("ff###.gif");
    if ((a - rA) * spinMult >= radians(360)) {
      exit();
    }
  }
}

void recordVid(){
  if (RECORDING) {
    saveFrame("movie/Chaos3D-######.png");
    //fill(255, 0, 0);
    //textSize(20);
    //text("seconds: " + ((frameCount - initialFrame) / frameRate), 15, 15);
  }
}

void keyPressed() {
  if (key - '0' >= CUBE && key - '0' <= TETRA) {
    MODE = key - '0';
    refresh();
  } else if (key == 's') {
    saveFrame("Chaos3Dasdf-######.png");
    System.out.println("Frame saved");
  } else if (key == 'r') {
    RECORDING = !RECORDING;
    rA = a;
  } else
  {
    refresh();
  }
}
