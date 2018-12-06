//Franciszek Mirecki 2018
//I'm aware it's a 'bit' spaghetti code ;> feel free to refactor this!

//edited by Harry Taussig 2018
//@GenerateSerendipity
//turned object oriented for easier modification

import peasy.*;

PeasyCam cam;
int distance = 450;

Vertex[] p;
float x0, y0, a, h, H;

ArrayList<Vertex> points;

PVector drawer;

final int n = 4;


final float sphereD = 2;

//for the vertices
//final float vertexSize = 12;

final int numIterations = 120;

final boolean canBeSame = true;

float prev = -1;

void setup() {
  size(1200, 800, P3D);  

  sphereDetail(2);
  noStroke();

  cam = new PeasyCam(this, distance);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(4 * distance);


  color c1 = color(139, 3, 252);
  color c4 = color(#03F6FC);
  color c2 = color(#03FC47);
  color c3 = color(#FC03E4);

  points = new ArrayList<Vertex>();

  drawer = new PVector(random(width), random(height), random(-height, 0));

  p = new Vertex[n];

  a = 400;

  h = a * sqrt(3) / 2;
  H = a * sqrt(6) / 3;

  p[0] = new Vertex(-a/2, h/3, H/4, c1);
  p[1] = new Vertex(a/2, h/3, H/4, c2);
  p[2] = new Vertex(0, -2*h/3, H/4, c3);
  p[3] = new Vertex(0, 0, -3*H/4, c4);

  //for (int i = 0; i < n - 1; i++) {
  //  if (i < n - 2) p[i] = new PVector(random(width), random(height), 0);
  //  else p[n-2] = new PVector(random(width/2), random(height/2), depth);
  //  point(p[i].x, p[i].y, p[i].z);
  //}
}

float getLerpPercent() {
  return .5;
}

void draw() {
  background(51);

  lights();

  if (frameCount < 500) {
    for (int k = 0; k < numIterations; k++) {
      int r = floor(random(4));
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
        drawer = PVector.lerp(drawer, p[r].getPos(), getLerpPercent());
        points.add(new Vertex(drawer, getColor(r)));
        prev = r;
      }
    }
  } else if (frameCount == 500) {
    //frameCount = -1;
    print("Adding points have ended");
  }

  //strokeWeight(12);
  drawVertices();

  for(Vertex v : points){
    v.display();
  }
}

color getColor(int num){
  return p[num].getColor();
}

void drawVertices() {
  for(Vertex v : p){
    v.display();
  }
}

void drawPoints(ArrayList<PVector> points, color c) {
  for (PVector p : points) {
    fill(c);
    pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(sphereD);
    popMatrix();
  }
}
