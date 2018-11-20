import nervoussystem.obj.*;
boolean record = true;


float sHeight = 600;
float camDepth = 400;

float rotY = 0;

float aInc = .048;
float cylR = 40;
float zInc = 1;
int numSides = 60;

void setup() {
  size(800, 800, P3D);
  smooth();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0) + camDepth, width/2.0, height/2.0, 0, 0, 1, 0);

  
}

void draw() {
  if(record){
    beginRecord("nervoussystem.obj.OBJExport", "curveSphere.obj");
  }
  else{
    background(0);
  }
  //stroke(0);
  noStroke();
  //noFill();
  fill(255);
  translate(width / 2, height / 2);
  //lights();

  //sphere(10);

  rotateY(((float) mouseX / width) * TWO_PI);
  //rotY += .005;

  //PVector last = new PVector(0, 0);
  float cylW = 6 * PI / zInc;
  float a = 0;
  for (float z = - sHeight / 2; z < sHeight / 2; z += zInc) {
    float r = sqrt(((sHeight / 2) * (sHeight / 2)) - (z * z));
    pushMatrix();
    translate(0, 0, z);
    //ellipse(0, 0, r * 2, r* 2);
    
    //strokeWeight(50);
    float x = cos(a) * r;
    float y = sin(a) * r;
    translate(x, y);
    a += aInc;
    //point(0, 0);
    //PVector next = new PVector(cos(a) * r, sin(a) * r);
    //rotateZ(a);
    //rotateX(PI / 2);
    cylinder(cylR, cylR, cylW, numSides);
    //sphere(10);
    //last = next;
    
    popMatrix();
  }

  
  if (record) {
    endRecord();
    record = false;
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("curveSphere-######.png");
    System.out.println("saved");
  }
  if (key == 'r') {
    record = true;
  }
}
