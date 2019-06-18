float r = 300;

//color values
float white = 245;
float dark = 40;

//angle around the hex that the triangle is
float a = 0;

Triangle tri;

float triR = r / sqrt(3);

float rotX = 0;
float rotY = 0;
float rotZ = 0;

void setup() {
  size(800, 800, P3D);
  tri = new Triangle(0, 0, triR, radians(0));
}


//ease functions taken from bees and bombs
//so they expect values between 0 and 1 and also return such values
float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}


void draw() {  
  ortho(); 
  translate(height / 2, width / 2);

  background(white);

  if (tri.turns < 5) {
    drawHex();
    tri.display();
  } else {
    drawCube();
  }
}

void drawHex() {
  pushMatrix();
  translate(0, 0, -500);

  noStroke();
  //fill(255,0, 0, 150);
  fill(dark);
  beginShape();
  for (float i = .5; i < 6.5; i++) {
    float thisA = i * TWO_PI / 6;
    vertex(r * cos(thisA), r * sin(thisA));
  }
  endShape(CLOSE);

  popMatrix();
}

void drawCube() {
  pushMatrix();
  //translate(0, 0, -500);

  //hardcoded value, couldn't figure out the math
  rotateX(-radians(35.3));
  rotateY(radians(45));

  cubeRotations();

  //fill(0, 0, 255, 50);
  fill(dark);
  noStroke();
  //stroke(white);

  //hardcoded
  float s = 366.66666;
  drawCubedTriangle(s);
  popMatrix();
}

void cubeRotations() {
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);

  if(rotZ > -radians(90)){
    rotZ += -radians(1);
  }
  else if (rotY < radians(90)){
    rotZ = radians(-90);
    rotY += radians(1);
  }
  else{
    resetHex();
  }
  
  //rotY += radians(1);
}

void resetHex(){
  rotX = 0;
  rotY = 0; 
  rotZ = 0;
  
  tri = new Triangle(0, 0, triR, radians(0));
}

void drawCubedTriangle(float s) {
  float v = s / 2;
  //stroke(white);
  noStroke();
  beginShape(QUADS);

  fill(dark);
  vertex(-v, v, v);
  vertex(-v, -v, v);
  vertex(-v, -v, -v);
  vertex(-v, v, -v);

  
  fill(dark);
  vertex(v, v, v);
  vertex(v, -v, v);
  vertex(v, -v, -v);
  vertex(v, v, -v);

  fill(dark);
  vertex(v, v, v);
  vertex(v, -v, v);
  vertex(-v, -v, v);
  vertex(-v, v, v);

  fill(dark);
  vertex(v, v, -v);
  vertex(v, -v, -v);
  vertex(-v, -v, -v);
  vertex(-v, v, -v);

  fill(dark);
  vertex(v, v, v);
  vertex(v, v, -v);
  vertex(-v, v, -v);
  vertex(-v, v, v);
  
  //strokeWeight(12);
  //a triangle
  fill(white);
  vertex(v, -v, v);
  //stroke(255, 0, 0);
  //point(v, -v, v); 
  vertex(v, -v, -v);
  //stroke(255, 0, 255);
  //point(v, -v, -v);  
  vertex(-v, -v, v);
  //stroke(0, 255, 0);
  //point(-v, -v, v);
  vertex(v, -v, v);

  endShape();
}
