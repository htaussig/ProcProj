float aMain = 0;
float aSub = 0;

float mainMag = 150;
float subMag = 65;

float x;
float y;
void setup() {
  size(600, 600, P3D);
  x = 0;
  y = 0;
}

void draw() {
  lights();


  //translate(0, 0, frameCount);

  background(0);
  noStroke();
  //stroke(0, 0, 255);
  translate(width / 2, height / 2);
  otherDraw();

  rotateZ(aMain);

  x = cos(aMain) * mainMag;
  y = sin(aSub) * mainMag;
  stroke(255);
  line(0, 0, mainMag, 0);
  //line(0, 0, 0, x, y, 0);
  noStroke();

  translate(mainMag, 0, 0);
  fill(0, 0, 255);
  sphere(15);

  rotateY(aSub);
  stroke(0, 255, 0);
  line(0, 0, subMag, 0);
  translate(subMag, 0);

  fill(255, 0, 255);
  noStroke();
  sphere(10);

  aMain += .025;

  aSub += .025;
}

void otherDraw() {
  //(sqrt(x^2 + y ^ 2) - 2)^2 + z ^ 2 = 1
  pushMatrix();

  float xoff = 0;
  float yoff = 0;
  float zoff = 0;
  
  float axVal = cos(aMain);
  float ayVal = sin(aMain);
  
  xoff = mainMag * axVal;
  yoff = mainMag * ayVal;
  //translate(xoff, yoff, zoff);
  
  noStroke();
  fill(255, 0, 0);
  //sphere(15);
  
  float axyVal = cos(aSub);
  xoff += (axVal)  * subMag * axyVal;
  yoff += (ayVal)  * subMag * axyVal;
  zoff += -sin(aSub) * subMag;
  
  translate(xoff, yoff, zoff);
  sphere(20);
  

  popMatrix();
}
