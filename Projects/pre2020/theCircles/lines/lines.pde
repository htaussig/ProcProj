import processing.svg.*;

ArrayList<Circle> circles;
float minCircRadius = .9;
float maxCircRadius = 80;
float minDistance = 5;


void setup() {
  size(800, 800);
  noLoop();
  beginRecord(SVG, "filename.svg");
  

}

void draw() {
  // Draw something good here
   circles = new ArrayList<Circle>();
  nextCircle();

  for (Circle circle : circles) {
    circle.display();
  }

  endRecord();
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

void keyPressed() {
  if (key == 's') {
    saveFrame("Circles-######.png");
    System.out.println("saved");
  }
  else{
    setup();
  }
}
