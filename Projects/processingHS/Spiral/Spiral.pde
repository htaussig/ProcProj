float distance = 0;
float rotation = 0;
float col = 0;

void setup() {
  colorMode(HSB, 100, 100, 100, 100);
  size(600, 600);
  background(0);
  //frameRate(100000);
  strokeWeight(2);
}

void draw() {
  translate(width / 2, height / 2);
  for (int i = 0; i < 200; i++) {
    pushMatrix();
    col += .002;
    if(col > 100){
     col = 0; 
    }
    stroke(col, 255, 255);
    rotate(radians(rotation++));
    distance += .01;
    point(0, distance);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 'S') {
    saveFrame("Spiral-######.png");
    System.out.println("Frame saved");
  }
}
