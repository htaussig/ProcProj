ArrayList<Circle> circles;
float minCircRadius = 5;
float maxCircRadius = 200;
float minDistance = 1;
float colDeviation = 10;
float colDeviationThird = 5;
float colDeviationBack = 7;

float hue;
float sat;
float bri;

void setup() {
  size(800, 800);
  colorMode(HSB, 99);
  hue = random(99);
  bri = random(35, 99);
  ;
  sat = random(min(119 - bri, 99), 99);
  circles = new ArrayList<Circle>();
  nextCircle();

  color backgroundCol = getBackgroundCol(); 
  background(backgroundCol);

  float numCircles = circles.size();
  //System.out.println(numCircles);
  int i = 0;
  for (Circle circle : circles) {
    circle.display();
    i++;
    //System.out.println(i / numCircles);
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
  float[] col = getCircColor();
  Circle newCirc = new Circle(x, y, r, col);

  for (Circle circle : circles) {
    if (circlesOverlap(newCirc, circle)) {
      return createCircles(num + 1);
    }
  }

  circles.add(newCirc);
  return true;
}

float[] getCircColor() {
  float rNum = random(1);
  if (rNum <= 1) {
    float tempHue = hue + random(-colDeviation, colDeviation);
    tempHue = correctColor(tempHue);
    float[] col = {tempHue, sat, bri};
    return col;
  } else {
    rNum = random(1);
    if (rNum <= .5) {
      float tempHue = hue + 33 + random(-colDeviationThird, colDeviationThird);
      tempHue = correctColor(tempHue);
      float[] col = {tempHue, sat, bri};
      return col;
    } else {
      float tempHue = hue - 33 + random(-colDeviationThird, colDeviationThird);
      tempHue = correctColor(tempHue);
      float[] col = {tempHue, sat, bri};
      return col;
    }
  }
}

color getBackgroundCol() {
  if (random(1) < .5) {
    if (random(1) < .5) {
      return #FFFFFF;
    }
    return #000000;
  }
  float bHue = hue + random(-colDeviationBack, colDeviationBack);
  /**float rNum = random(1);
   if (rNum <= .66) {
   if (random(1) <= .5) {
   bHue += 33;
   } else {
   bHue -= 33;
   }
   }**/
  bHue = correctColor(bHue);
  float bBri = map(pow(random(-10, 10), 5), -10000, 10000, 0, 1) * 99;
  float bSat = random((sat / 2.0) * (bri / 99), sat / 2.0);
  return color(bHue, bSat, bBri);
  /**if(random(1) < .5){
   return #000000;
   }
   return #FFFFFF;**/
}

float correctColor(float num) {
  return abs(num) % 99;
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
    saveFrame("CirclesV2a-######.png");
    System.out.println("saved");
  } else {
    setup();
  }
}
