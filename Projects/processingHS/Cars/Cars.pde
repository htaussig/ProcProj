Road road;

void setup() {
  size(500, 500);
  road = new Road(height / 2, 200, 10, 2);
}

void draw() {
  background(255);
  road.update();
  road.display();
}

void mousePressed(){
  road.traffic();
}