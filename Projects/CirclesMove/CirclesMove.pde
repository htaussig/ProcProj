ArrayList<Circle> circles;
float minCircRadius = 5;
float maxCircRadius = 80;
float minDistance = 9;
float colDeviation = 10;
float colDeviationThird = 5;
float colDeviationBack = 7;

float hue;
float sat;
float bri;

color backgroundCol;

float SPEED = .5;

void setup() {
  size(800, 800);
  colorMode(HSB, 100);
  hue = random(100);
  sat = random(25, 100);
  bri = random(50, 100);
  circles = new ArrayList<Circle>();
  nextCircle();


  backgroundCol = getBackgroundCol();
}

void draw() {
  background(backgroundCol);
  moveAllCircles();
  for (Circle circle : circles) {
    circle.display();
  }
  //System.out.println(frameCount);
}

void moveAllCircles() {
  ArrayList<Circle> beforeCircles = new ArrayList<Circle>();
  for (Circle circle : circles) {
    beforeCircles.add(new Circle(circle.pos, circle.r, circle.lastA));
  }
  for (int i = 0; i < circles.size(); i++) {
    Circle circle = beforeCircles.get(i);
    for (float a = circle.lastA; a < TWO_PI + circle.lastA; a += PI / 180) {
      PVector tempPos = PVector.add(circle.pos, new PVector(SPEED * cos(a), SPEED * sin(a)));
      //System.out.println(tempPos);
      if(isValidMove(tempPos, circle.r, beforeCircles)){
        //System.out.println("true");
        Circle realCirc = circles.get(i);
        realCirc.pos = tempPos;
        realCirc.lastA = a;
        break;
      }
    }
  }
}

boolean isValidMove(PVector pos, float r, ArrayList<Circle> circles){
 for(Circle circ2 : circles){
   float dist = PVector.dist(pos, circ2.pos);
   if(dist >= SPEED && dist <= r + circ2.r + minDistance){
     //System.out.println("false");
     return false;
   }  
 }
 //System.out.println("not false");
 return true;
}

void nextCircle() {
  while (createCircles(0)) {
  }
}

boolean createCircles(int num) {
  if (num >= 1000) {
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
    saveFrame("Circles-######.png");
    System.out.println("saved");
  } else {
    setup();
  }
}
