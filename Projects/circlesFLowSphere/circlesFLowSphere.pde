
boolean RECORDING = false;
//////////////////////////////////////////////////////////////
ArrayList<Circle> circs = new ArrayList<Circle>();
float RAD = 220;
int NUM = 16;
int NUM2 = 8;

int DIV = 18;
float DA = (PI / 180) / DIV;

void setup() {
  size(600, 600, P3D);

  float dh = 1;
  float dv = 1;
  for (int k = 0; k < NUM; k++) {
    float ax = map(k, 0, NUM, 0, TWO_PI);
    //ax = 0;
    //dv += 1;
    //dh += 1;
    for (int i = 0; i < NUM2; i++) {
      float ay = map(i, 0, NUM2, -PI / 1, PI / 1);
      circs.add(new Circle(ax, ay, dh, dv, 50));
    }
  }
  
  //circs.add(new Circle(0, 0, 50));
}

void draw() {
  //ortho();
  translate(width / 2, height / 2, -2000); 
  background(0);

  //sphere(50);

  strokeWeight(2.5);
  stroke(255);
  noFill();
  for (Circle circ : circs) {
    circ.display();
  }
  
  gif();
}

void gif(){
  if (RECORDING) {
    float thisA = circs.get(0).aVert;
    if (DIV * 180 / 3 > frameCount) {
      println(frameCount);
      println(thisA);
      saveFrame("movie/f####-spheri.png");
    }
  }
}
