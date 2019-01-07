ArrayList<Circle> circles;
float minCircRadius = 55;
float maxCircRadius = 310;
float minDistance = 68;

int CIRCSIDES = 3;

void createCircles() {
  circles = new ArrayList<Circle>();
  nextCircle();
}

void nextCircle() {
  while (createCircles(0)) {
  }
}

boolean createCircles(int num) {
  if (num >= 700) {
    return false;
  }

  float x = random(width); 
  float y = random(height);
  float r = random(minCircRadius, maxCircRadius);
  Circle newCirc = new Circle(x, y, r);

  for (Circle circle : circles) {
    if (circlesOverlap(newCirc, circle)) {
      return createCircles(num + 1);
    }
  }

  circles.add(newCirc);
  return true;
}

boolean circlesOverlap(Circle circ1, Circle circ2) {
  return distance(circ1, circ2) <= circ1.r + circ2.r + minDistance;
}

float distance(Circle circ1, Circle circ2) {
  float dx = abs(circ1.x - circ2.x);
  float dy = abs(circ1.y - circ2.y);
  return sqrt((dx * dx) + (dy * dy));
}

public class Circle {
  float x, y, r;
  public Circle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
  }
  
  void specialForceCircle(){
    specialForceGon(x, y, r, CIRCSIDES, random(TWO_PI));
  }

  void display() {
    fill(0);
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }
}
