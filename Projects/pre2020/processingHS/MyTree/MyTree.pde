float angle;
float colorNum;
float yIn;
float maxWeight = 4;
float branchMult;

void setup(){
  size(840, 560);
  background(255);
  colorMode(HSB, 255);
  stroke(0);
  angle = PI / 2;
  colorNum = 0;
  frameRate(20);
  branchMult = .5;
}

void draw(){
  background(color(0, 0, 0));
  translate(width / 2, height);
  yIn =  (-height / 3) * (height - mouseY) / height;
  strokeWeight(maxWeight - 1);
  branch(0,0,0, yIn , colorNum);
  angle = ((float) mouseX / width) *  3 * PI / 4;
  colorNum++;
  colorNum %= 255;
}

void branch(float x1, float y1, float x2, float y2, float col){
  line(x1, y1, x2, y2);
  translate(0, y2);
  y2 *= branchMult;
  col += 2;
  col %= 255;
  
  if(Math.abs(y2) > 2){
    //RIGHT BRANCH
  pushMatrix();
  rotate(angle);
  stroke(color(col,255,255));
  strokeWeight(maxWeight * ((y2) / yIn) + 1);
  branch(0, 0, 0, y2, col);
  popMatrix();
  
  //LEFT BRANCH
  pushMatrix();
  rotate(-angle);
  stroke(color(col,255,255));
  strokeWeight(maxWeight * ((y2) / yIn) + 1);
  branch(0, 0, 0, y2, col);
  popMatrix();
  }  
}

void keyPressed(){
  if(key == 'w'){
    branchMult += .1;
  }
  if(key == 's'){
    branchMult -= .1;
  }
}