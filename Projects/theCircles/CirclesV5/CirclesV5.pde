import java.util.*;

int NUMSIDES = 2;

ArrayList<Circle> circles;
float minCircRadius = 85;
float maxCircRadius = 120;
float minDistance = 0;
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
  bri = random(35, 99);;
  sat = random(min(119 - bri, 99), 99);
  
  
  
  circles = new ArrayList<Circle>();
  nextCircle();


  color backgroundCol = getBackgroundCol(); 
  background(backgroundCol);
  for (Circle circle : circles) {
    circle.display(getNearestCircles(circle, NUMSIDES));
  }
}

void draw() {
}

Circle[] getNearestCircles(Circle mainCirc, int num) {
  ArrayList<Circle> closeCircs = new ArrayList<Circle>();
  closeCircs.clear();

  for (int i = 0; i < num; i++) { 
    closeCircs.add(circles.get(i));
    circles.get(i).lastDistance = 10000000;
  }

  for (Circle circ : circles) {
    if (circ != mainCirc) {
      float dist = distance(mainCirc, circ);
      if (dist < closeCircs.get(num - 1).lastDistance) {
        circ.lastDistance = dist;
        insert(circ, closeCircs, num - 1);
      }
    }
  }

  Circle[] closestCircs = new Circle[num];
  for (int i = 0; i < num; i++) {
    closestCircs[i] = closeCircs.get(i);
  }

  return closestCircs;
}

void insert(Circle circ, ArrayList<Circle> closeCircs, int index) {
  if (index == 0) {
    closeCircs.add(0, circ);
  } else if (circ.lastDistance < closeCircs.get(index - 1).lastDistance) {
    insert(circ, closeCircs, index - 1);
  } else {
    closeCircs.add(index, circ);
  }
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
  if (rNum <= .75) {
    float tempHue = hue + random(-colDeviation, colDeviation);
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
  float bHue = hue + random(-colDeviationBack, colDeviationBack);
  float rNum = random(1);
  if (rNum <= .66) {
    if (random(1) <= .5) {
      bHue += 33;
    } else {
      bHue -= 33;
    }
  }
  bHue = correctColor(bHue);
  float bBri = random(0, 99);
  float bSat = random((sat / 2.0) * (bri / 99), sat / 2.0);
  return color(bHue, bSat, bBri);
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
    saveFrame("CirclesV5-######.png");
    System.out.println("saved");
  } else {
    setup();
  }
}
