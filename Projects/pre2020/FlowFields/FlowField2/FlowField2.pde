int rows, cols;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowField;
ArrayList<Integer> colors = new ArrayList<Integer>();
float colIndex = 0;
private static int NUMCOLS = 2;
private static float COLINC = .0015;

float forceMag = .023;
float maxSpeed = 2;

float inc = 0.065;
float zoff = 0;
float scl = 10;

float opacity = 5;

float WALLFORCE = .000000042 / forceMag;
float SPECIALFORCE = .1;

void setup() {
  size(1600, 900, P2D);
  colorMode(HSB, 255, 100, 100);
  background(0);
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1);
  flowField = new PVector[cols * rows];
  for (int i = 0; i < 15500; i++) {
    particles.add(new Particle());
  }
  /*for(int i = 0; i < NUMCOLS; i++){
   //colors.add(color(random(255), random(255), random(255), 2));
   colors.add(color(random(255), 125, 255, 2));
   }*/
  colors.add(color(117, 2, 242, opacity));
  colors.add(color(176, 98, 94, opacity));
  //smooth(8);
}

void draw() {
  if (opacity == 255) {
    background(0);
  }
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 1.7;
      PVector v = PVector.fromAngle(angle);
      addWallForce(x * scl, y * scl, v);
      v.setMag(forceMag);
      addSpecialForce(x * scl, y * scl, v);
      flowField[index] = v;
      xoff += inc;
      /**stroke(0, 50);
       pushMatrix();
       translate(x * scl, y * scl);
       rotate(v.heading());
       strokeWeight(1);
       stroke(255);
       line(0, 0, scl, 0);
       popMatrix();**/
    }
    yoff += inc;
  }
  zoff += 0.00022;

  for (Particle particle : particles) {
    particle.follow(flowField);
    particle.update();
    particle.display(); 
    particle.edges();
  }
  colIndex += COLINC;
}

void addSpecialForce(float x, float y, PVector v) {
  float dx = (width / 2) - x;
  float dy = (height / 2) - y;
  float d = sqrt(dx * dx + dy * dy);
  float a = new PVector(x - width / 2, y - height / 2).heading() - PI / 2;
  
  float dist = abs(d - 180);
  if(dist < 180){
    dist = map(dist, 0, 180, 1, 0);
    dist *= dist;
    v.add(PVector.fromAngle(a).mult(SPECIALFORCE * dist));
  }
}

void addWallForce(float x, float y, PVector v) {
  float dx = (width / 2) - x;
  float dy = (height / 2) - y;
  float fx = WALLFORCE * abs(dx) * dx;
  float fy = WALLFORCE * abs(dy) * dy;

  v.add(new PVector(fx, fy));
}


void keyPressed() {
  if (key ==  's') {
    saveFrame("flowfeild2-######.png");
    System.out.println("Frame saved");
  } else {
    background(0);
  }
}
