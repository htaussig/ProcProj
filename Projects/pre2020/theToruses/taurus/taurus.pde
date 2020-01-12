float aMain = 0;
float aSub = 0;

void setup(){
  size(600, 600, P3D);
}

void draw(){
  lights();
  
  //translate(0, 0, frameCount);
  
  background(0);
  noStroke();
  //stroke(0, 0, 255);
  translate(width / 2, height / 2);
  
  rotateZ(aMain);
  stroke(255);
  line(0, 0, 100, 0);
  noStroke();
  
  translate(100, 0, 0);
  fill(0, 0, 255);
  sphere(20);
  
  rotateY(aSub);
  line(0, 0, 40, 0);
  translate(40, 0);
  
  fill(255, 0, 255);
  box(10);
  
  aMain += .025;
  
  aSub += .025;
}
