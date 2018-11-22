int rows, cols;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowField;
PVector[] wallField;
PVector[] specialField;
ArrayList<Integer> colors = new ArrayList<Integer>();
float colIndex = 0;

//put a seed here, otherwise a seed will be generated randomly
long seed = 0;

private static int NUMCOLS = 2;
private static float COLINC = .0015;

float forceMag = .0125;
float maxSpeed = 1;

float inc = 0.055;
float zoff = 0;
float zInc = 0.00023;
float scl = 10;

float opacity = 5;
color backCol = color(255);

float WALLFORCE = .000000014 / forceMag;
float SPECIALFORCE = .04;
float numParticles = 15000;

float angleMult;

//0 is regular
int REG = 0;
//1 is particle movement
int PAR = 1;
//2 is showing the lines
int LIN = 2;

int mode = REG;

void setup() { 
  size(1600, 900, P2D);
  colorMode(HSB, 255, 100, 100);
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
  colors.add(color(0, 0, 80, opacity));
  colors.add(color(0, 0, 8, opacity));
  //colors.add(color(189, 99, 99, opacity));
  //colors.add(color(300, 99, 99, opacity));
  popStyle();

  /**purple blue white
   colors.add(color(117, 2, 242, opacity));
   colors.add(color(176, 98, 94, opacity));**/

  genWallForce();
  genSpecialForce();
}

void draw() {
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
      //addSpecialForce(index, v);
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

void genSpecialForce() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      specialField[index] = getSpecialForce(x, y);
    }
  }
}

PVector getSpecialForce(float x, float y) {
  x *= scl;
  y *= scl;

  float dx = (width / 2) - x;
  float dy = (height / 2) - y;
  float d = sqrt(dx * dx + dy * dy);
  float a = new PVector(x - width / 2, y - height / 2).heading() - PI / 2;

  float dist = abs(d - 180);
  if (dist < 180) {
    dist = map(dist, 0, 180, 1, 0);
    dist *= dist;
    return PVector.fromAngle(a).mult(SPECIALFORCE * dist);
  }
  return new PVector(0, 0);
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
  System.out.println(seed);
  if (seed == 0) {
    seed = (long) random(-1000000, 1000000);
  }
  randomSeed(seed);
  noiseSeed(seed);
  //could there be a problem with using the same variable?
}

void diluteField() {
  PVector[] newField = new PVector[specialField.length];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      newField[index] = getAverageField(x, y);
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
      if(tempY >= rows){
        tempY %= rows;
      }
      if(tempX >= cols){
        tempX %= cols;
      }
      if(tempX < 0){
        tempX += cols;
      }
      if(tempY < 0){
        tempY += rows;
      }
      int index = (int) (tempX + (tempY * cols));
      v.add(specialField[index]);
    }
  }
  v.setMag(forceMag);
  return v;
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
  } else {
    background(backCol);
  }
}
