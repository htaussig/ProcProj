int rows, cols;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowField;
PVector[] wallField;
PVector[] specialField;
ArrayList<Integer> colors = new ArrayList<Integer>();
float colIndex = 0;

//put a seed here, otherwise a seed will be generated randomly (if set to 0)
long seed = 0;

//private static int NUMCOLS = 2;
private static float COLINC = .0015;

float forceMag = .0125;
float maxSpeed = 1;

float inc = 0.055;
float zoff = 0;
float zInc = 0.00023;
float scl = 9;

float opacity = 2;
color backCol = color(0);

float WALLFORCE = .000000010 / forceMag;
float SPECIALFORCE = .07 * 3.2;
float numParticles = 11000;

float angleMult;

//0 is regular
int REG = 0;
//1 is particle movement
int PAR = 1;
//2 is showing the lines
int LIN = 2;

int mode = REG;

//for highResolution output
PGraphics hires;
int scaleFactor = 2;
boolean recording = false;

void setup() { 
  size(1920, 1080, P2D);
  if (recording == true) {
    startRecord();
  }
  colorMode(HSB, 359, 99, 99);
  background(backCol);

  seedStuff();

  angleMult = random(1.2, 1.9);
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1);
  flowField = new PVector[cols * rows];
  wallField = new PVector[cols * rows];
  specialField = new PVector[cols * rows];
  for (int i = 0; i < numParticles; i++) {
    Particle p = new Particle();   
    particles.add(p);
  }
  /*for(int i = 0; i < NUMCOLS; i++){
   //colors.add(color(random(255), random(255), random(255), 2));
   colors.add(color(random(255), 125, 255, 2));
   }*/

  //change the colors here in order to change the flowfield gradient
  pushStyle();
  colorMode(HSB, 359, 99, 99);
  popStyle();

  colors.add(color(112, 99, 99, opacity));
  colors.add(color(181, 99, 99, opacity));
  



  /**purple blue white
   colors.add(color(117, 2, 242, opacity));
   colors.add(color(176, 98, 94, opacity));**/

  /** red white red   
   colors.add(color(0, 99, 99, opacity));
   colors.add(color(0, 69, 89, opacity));
   colors.add(color(0, 99, 99, opacity));
   colors.add(color(0, 99, 19, opacity));   
   **/

  createCircles();

  genWallForce();
  genSpecialForce();

  smooth(3);
}


void genSpecialForce() {
  for (int i = 0; i < specialField.length; i++) {
    specialField[i] = new PVector(0, 0);
  }

  //specialForceLine(100, 100, 900, 200);
  for (Circle circle : circles) {
    circle.specialForceCircle();
  }  
  //diluteField();
}

void draw() {
  if (recording) {
    hires.scale(scaleFactor);
  }


  colorMode(HSB, 359, 99, 99);

  if (opacity == 255 || mode > 0) {
    background(backCol);
  }
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      float angle = noise(xoff, yoff, zoff) * TWO_PI * angleMult;
      PVector v = PVector.fromAngle(angle);    
      //PVector v = new PVector(0, 0);
      int index = (int) (x + (y * cols));
      addWallForce(index, v);
      v.setMag(forceMag);
      addSpecialForce(index, v);
      flowField[index] = v;
      xoff += inc;
      if (mode == LIN) {
        pushMatrix();
        translate(x * scl, y * scl);
        rotate(v.heading());
        strokeWeight(1);
        stroke(122);
        line(0, 0, scl, 0);
        popMatrix();
      }
    }
    yoff += inc;
  }
  zoff += zInc;

  for (Particle particle : particles) {
    particle.follow(flowField);
    particle.update();
    particle.display(); 
    particle.edges();
  }
  colIndex += COLINC;
}

void addSpecialForce(int index, PVector v) {
  v.add(specialField[index]);
}

void specialForceGon(float x, float y, float r, int numSides, float aIn) {
  float a = aIn;
  float da = TWO_PI / numSides;

  boolean clockwise = true;

  if (random(1) < .5) {
    clockwise = false;
  }

  for (int i = 0; i < numSides; i++) {
    //System.out.println(i);
    float nextA;
    if (clockwise) {
      nextA = a + da;
    } else {
      nextA = a - da;
    }
    specialForceLine(x + cos(a) * r, y + sin(a) * r, x + cos(nextA) * r, y + sin(nextA) * r);
    a = nextA;
  }
}

/**@ Override void line(float x1, float x2, float y1, float y2) {
 specialForceLine(x1, x2, y1, y2);
 }**/

void specialForceLine(float x1, float y1, float x2, float y2) {

  PVector v = new PVector(x2 - x1, y2 - y1).setMag(SPECIALFORCE);

  PVector d = new PVector(x2 - x1, y2 - y1).setMag(1);

  //int i = 0;
  while (true) {
    setSpecial(x1, y1, v);
    x1 += d.x;
    y1 += d.y;
    if (abs(x1 - x2) < 1 && abs(y1 - y2) < 1) {
      break;
    }
  }
}

void setSpecial(float x, float y, PVector v) {
  x = (int) (x / scl);
  y = (int) (y / scl);
  int index = (int) (x + (y * cols));
  if (!(index < 0 || index >= specialField.length)) {
    specialField[index] = v;
  }
}

void addWallForce(int index, PVector v) {
  v.add(wallField[index]);
}

void genWallForce() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      wallField[index] = getWallForce(x, y);
    }
  }
}

PVector getWallForce(float x, float y) {
  x *= scl;
  y *= scl;
  float dx = (width / 2) - x;
  float dy = (height / 2) - y;
  float fx = WALLFORCE * abs(dx) * dx;
  float fy = WALLFORCE * abs(dy) * dy;

  return new PVector(fx, fy);
}

void seedStuff() {
  if (seed == 0) {
    seed = (long) random(-1000000, 1000000);
  }
  randomSeed(seed);
  noiseSeed(seed);
  //could there be a problem with using the same variable?
  System.out.println("seed" + seed);
}

void diluteField() {
  PVector[] newField = new PVector[specialField.length];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      newField[index] = getAverageField(x, y).setMag(SPECIALFORCE);
    }
  }

  specialField = newField;
}

//gets the average vector of the 3x3 area including a vector in the field
PVector getAverageField(int x, int y) {
  PVector v = new PVector(0, 0);
  for (int yAdd = -1; yAdd < 2; yAdd++) {
    for (int xAdd = -1; xAdd < 2; xAdd++) {
      int tempX = x + xAdd;
      int tempY = y + yAdd;
      if (tempY >= rows) {
        tempY %= rows;
      }
      if (tempX >= cols) {
        tempX %= cols;
      }
      if (tempX < 0) {
        tempX += cols;
      }
      if (tempY < 0) {
        tempY += rows;
      }
      int index = (int) (tempX + (tempY * cols));
      v.add(specialField[index]);
    }
  }
  v.setMag(forceMag);
  return v;
}

void startRecord() {
  hires = createGraphics(
    width * scaleFactor, 
    height * scaleFactor, 
    JAVA2D);
  println("Generating high-resolution image...");

  beginRecord(hires);

  hires.scale(scaleFactor);
  background(backCol);

  recording = true;
}

void keyPressed() {
  if (key ==  's') {
    saveFrame("flowfeild3-######.png");
    System.out.println("Frame saved");
  } else if (key == 'd') {
    System.out.println(seed);
  } else if (key >= '0' && key <= '2') {
    mode = key - '0';
    background(backCol);
  } else if (key == 'l') {
    System.out.println("diluting");
    diluteField();
  } else if (key == 'r') {
    if (!recording) {
      startRecord();
    } else {
      recording = false;
      endRecord();

      hires.save("FlowField3s: " + seed + " f: " + frameCount + "highres.png");
      println("Finished");
    }
  } else {
    background(backCol);
  }
}
