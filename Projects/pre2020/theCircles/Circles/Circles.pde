ArrayList<Circle> circles;
float minCircRadius = 25;
float maxCircRadius = 140;
float minDistance = 9;
float colDeviation = 10;
float colDeviationThird = 5;
float colDeviationBack = 7;

float hue;
float sat;
float bri;

void setup() {
  size(800, 800);
  colorMode(HSB, 100);
  hue = random(100);
  sat = random(25, 100);
  bri = random(50, 100);
  circles = new ArrayList<Circle>();
  nextCircle();


  color backgroundCol = getBackgroundCol(); 
  background(backgroundCol);
  for (Circle circle : circles) {
    circle.display();
  }
}

void draw() {
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
  Circle newCirc = new Circle(x, y, r, col);

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
  if (rNum <= .8) {
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
  float dx = abs(circ1.x - circ2.x);
  float dy = abs(circ1.y - circ2.y);
  return sqrt((dx * dx) + (dy * dy));
}

void keyPressed() {
  if (key == 's') {
    saveFrame("Circles-######.png");
    System.out.println("saved");
  }
  else{
    setup();
  }
}
