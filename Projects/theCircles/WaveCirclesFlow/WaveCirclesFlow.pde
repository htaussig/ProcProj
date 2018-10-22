ArrayList<Circle> circles;
float minCircRadius = 7;
float maxCircRadius = 40;
float minDistance = 10;
float colDeviation = 10;
float colDeviationThird = 5;
float colDeviationBack = 7;

float hue;
float sat;
float bri;

color backgroundCol;

float SPEED = .5;
float WALLFORCE = .00000072;
float REPELMULT = 1.8;

//flowfield stuff
float zoff = 0;
float scl = 10;
int rows, cols;
PVector[] flowField;
float inc = 0.055;
float zInc = 0.00082;
float xin;
float yin;

int NOISEDET = 1;
boolean RECORDING = false;
int initialFrame = 0;

void setup() {
  noiseDetail(NOISEDET);

  size(800, 800);
  colorMode(HSB, 100);
  hue = random(100);
  sat = random(25, 100);
  bri = random(50, 100);
  circles = new ArrayList<Circle>();
  nextCircle();

  initFlowField();

  backgroundCol = getBackgroundCol();
}

void draw() {
  background(backgroundCol);
  drawFlowField();
  moveAllCircles();
  for (Circle circle : circles) {
    circle.follow(flowField);
    circle.edges();
    circle.display();
  }
  //System.out.println(frameRate);

  if (RECORDING) {
    saveFrame("movie/WaveCirclesFlow-######.png");
    fill(255, 0, 0);
    textSize(20);
    text("seconds: " + ((frameCount - initialFrame) / frameRate), 15, 15);
  }
}

void initFlowField() {
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1); 
  flowField = new PVector[cols * rows];
  xin = random(-100000, 100000);
  yin = random(-100000, 100000);
}

void drawFlowField() {
  float yoff = yin;
  for (int y = 0; y < rows; y++) {
    float xoff = xin;
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 1.7;
      PVector v = PVector.fromAngle(angle);
      v.setMag(.09);
      addWallForce(x * scl, y * scl, v);
      flowField[index] = v;
      xoff += inc;
      /**stroke(0, 50);
       pushMatrix();
       translate(x * scl, y * scl);
       rotate(v.heading());
       strokeWeight(1);
       line(0, 0, scl, 0);
       popMatrix();**/
    }
    yoff += inc;
  }
  zoff += zInc;
}

void addWallForce(float x, float y, PVector v) {
  float dx = (width / 2) - x;
  float dy = (height / 2) - y;
  float fx = WALLFORCE * abs(dx) * dx;
  float fy = WALLFORCE * abs(dy) * dy;

  v.add(new PVector(fx, fy));
}

void moveAllCircles() {
  for (int i = 0; i < circles.size(); i++) {
    Circle circ1 = circles.get(i);

    for (int j = i + 1; j < circles.size(); j++) {

      Circle circ2 = circles.get(j);

      float dist = distance(circ1, circ2);
      repelCheck(circ1, circ2, dist);
    }
  }
  for (Circle circle : circles) {
    circle.update();
  }
}

void repelCheck(Circle circ1, Circle circ2, float dist) {
  PVector lastPos1 = circ1.pos.copy();
  //checks for corner and edge repulsion
  for (int i = -1; i <= 1; i ++) {
    for (int j = -1; j <= 1; j++) {
      circ1.pos.add(new PVector(i * width, j * height));
      if (closeEnough(circ1, circ2, dist)) {
        repel(circ1, circ2, dist);
      }
      circ1.pos = lastPos1.copy();
    }
  }
}

void repel(Circle circ1, Circle circ2, float dist) {
  float force = REPELMULT * circ2.r * circ1.r / (dist * dist);
  float a = PVector.sub(circ1.pos, circ2.pos).heading();
  circ1.applyForce(new PVector(cos(a) * force, sin(a) * force));
  circ2.applyForce(new PVector(cos(a + PI) * force, sin(a + PI) * force));
}

boolean closeEnough(Circle circ1, Circle circ2, float dist) {
  return dist <= circ1.r + circ2.r + minDistance + 15;
}


/**boolean isValidMove(PVector pos, float r, ArrayList<Circle> circles){
 for(Circle circ2 : circles){
 float dist = PVector.dist(pos, circ2.pos);
 if(dist >= SPEED && dist <= r + circ2.r + minDistance){
 //System.out.println("false");
 return false;
 }  
 }
 //System.out.println("not false");
 return true;
 }**/

void nextCircle() {
  while (createCircles(0)) {
  }
}

boolean createCircles(int num) {
  if (num >= 100) {
    return false;
  }

  float x = random(width); 
  float y = random(height);
  float r = random(minCircRadius, maxCircRadius);
  color col = getCircColor();
  Circle newCirc = new Circle(new PVector(x, y), r, col);

  for (Circle circle : circles) {
    if (circlesOverlap(newCirc, circle)) {
      return createCircles(num + 1);
    }
  }

  circles.add(newCirc);
  return true;
}

color getCircColor() {
  float rNum = random(1);
  if (rNum <= .75) {
    float tempHue = hue + random(-colDeviation, colDeviation);
    return color(tempHue, sat, bri);
  } else {
    rNum = random(1);
    if (rNum <= .5) {
      float tempHue = hue + 33 + random(-colDeviationThird, colDeviationThird);
      tempHue = correctColor(tempHue);
      return color(tempHue, sat, bri);
    } else {
      float tempHue = hue - 33 + random(-colDeviationThird, colDeviationThird);
      tempHue = correctColor(tempHue);
      return color(tempHue, sat, bri);
    }
  }
}

color getBackgroundCol() {
  float bHue = hue + random(-colDeviationBack, colDeviationBack);
  float rNum = random(1);
  if (rNum <= .8) {
    if (random(1) <= .5) {
      bHue += 33;
    } else {
      bHue -= 33;
    }
  }
  bHue = correctColor(bHue);
  float bSat = random(0, sat / 3.0);
  float bBri = random(0, 100);
  return color(bHue, bSat, bBri);
}

float correctColor(float num) {
  return abs(num) % 100;
}

boolean circlesOverlap(Circle circ1, Circle circ2) {
  return distance(circ1, circ2) <= circ1.r + circ2.r + minDistance;
}

float distance(Circle circ1, Circle circ2) {
  return PVector.dist(circ1.pos, circ2.pos);
}

void keyPressed() {
  if (key == 's') {
    saveFrame("pictures/WaveCirclesFlow-######.png");
    System.out.println("saved");
  } else if (key == 'r') {
    RECORDING = !RECORDING;
    initialFrame = frameCount;
  } else {
    setup();
  }
}
