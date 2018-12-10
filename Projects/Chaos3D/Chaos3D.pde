//Franciszek Mirecki 2018

//edited by Harry Taussig 2018
//@GenerateSerendipity
//turned object oriented for easier modification

import peasy.*;

PeasyCam cam;
int distance = 450;

ArrayList<Vertex> p;
float x0, y0, a, h, H;

ArrayList<Vertex> points;

PVector drawer;

//final int n = 4;

float myFrameCount = 0;

float diam = 17.3;
float opacity = 205;

//for the vertices
//final float vertexSize = 12;

final int numIterations = 100;

final boolean canBeSame = true;

float prev = -1;

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

void setup() {
  size(1200, 800, P3D);  

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

void refresh() {
  myFrameCount = 0;

  if (orthoView) {
    ortho();
  }

  sphereDetail(8);
  noStroke();

  p.clear();
  points.clear();

  drawer = new PVector(random(width), random(height), random(-height, 0));

  addPoints();
}

void addPoints() {
  if (MODE == TETRA) {
    tetraSettings();
  } else if (MODE == CUBE) {
    cubeSettings();
  } else if (MODE == OCTA) {
    octaSettings();
  } else if(MODE == ICOS){
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
  diam = 17.3;

  //float r = 200;

  a = 400;

  h = a * sqrt(3) / 2;
  H = a * sqrt(6) / 3;

  p.add(new Vertex(-a/2, h/3, H/4));
  p.add(new Vertex(a/2, h/3, H/4));
  p.add(new Vertex(0, -2*h/3, H/4));
  p.add(new Vertex(0, 0, -3*H/4));
}

void cubeSettings() {
  DRAWMODE = drawCUBE;
  lerpPercent = .7;

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
    }
    else if (i == 2){
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

void draw() {
  background(51);

  lights();

  //spotLight(255,255,255, 1000, 1000, 1000, -1, -1, -1, radians(1), 600);

  directionalLight(128, 128, 128, 1000, 1000, 1000);
  directionalLight(25, 25, 25, -1000, -1000, 0);

  if (myFrameCount++ < 500) {
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

  for (Vertex v : points) {
    v.display();
  }
}

color getColor(int num) {
  return p.get(num).getColor();
}

void drawVertices() {
  for (Vertex v : p) {
    v.display();
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

void keyPressed() {
  if (key - '0' >= CUBE && key - '0' <= TETRA) {
    MODE = key - '0';
  }
  refresh();
}
