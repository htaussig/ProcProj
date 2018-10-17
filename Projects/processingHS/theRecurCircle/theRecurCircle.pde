RecurCircle rCirc;
RecurCircle clickedCirc;
PVector mouseOld;

void setup() {
  size(600, 600);
  noStroke();
  smooth(8);
  background(0);
  colorMode(HSB, 100, 100, 100, 100);
  newRecurCircle();
}

void draw() {
  translate(width / 2, height / 2);
  //rCirc.roll(radians(.1));
  rCirc.display(0, 0);
}

void newRecurCircle() { 
  background(0);
  rCirc = new RecurCircle(new PVector(0, 0), width, random(100));
  rCirc.generateCircles();
}


/*void recursiveCircle(float x, float y, float d, float hue, float sat, float bright) {
 noStroke();
 float hueDiff = random(4, 8);
 if (random(1) < .5) {
 hueDiff *= -1;
 }
 if (random(1) < .03) {
 float num = random(1);
 if(num < .33){
 hue += 50;
 }
 else if(num < .66){
 hue -= 33;
 }
 else{
 hue += 33; 
 }
 
 } else {
 hue += hueDiff;
 }
 
  /*sat += random(-5, 5);
 bright += random(-6, 6);
 
 if(sat < MIN_SAT){
 sat = MIN_SAT; 
 }
 if(bright < MIN_BRIGHT){
 bright =  MIN_BRIGHT; 
 }
 
 fill(hue, random(100), random(100));
 ellipse(x, y, d, d);
 float d1 = random(d);
 float d2 = d - d1;
 float angle = random(TWO_PI);
 PVector displace1 = new PVector(sin(angle) * d2 / 2, cos(angle) * d2 / 2);
 angle += PI;
 PVector displace2 = new PVector(sin(angle) * d1 / 2, cos(angle) * d1 / 2);
 if (d > 50) {
 if (random(1) < .9) {
 recursiveCircle(x + displace1.x, y + displace1.y, d1, hue, sat, bright);
 }
 if (random(1) < .9) {
 recursiveCircle(x + displace2.x, y + displace2.y, d2, hue, sat, bright);
 }
 }
 }*/


void mousePressed() {
  PVector mouse = new PVector(mouseX - width / 2, mouseY - height / 2);
  clickedCirc = rCirc.getCirc(mouse);
  if (clickedCirc != null) {
    mouseOld = new PVector(mouseX - width / 2, mouseY - height / 2).sub(clickedCirc.pos);
  }
  //mouseOld = clickedCirc.pos.sub(mouse);
  /*if (clicked != null) {
   //clicked.hue = 100;
   clicked.spinChildren(radians(10));
   }*/
}

void mouseDragged() {
  if (clickedCirc != null) {
    PVector mouseNow = new PVector(mouseX - width / 2, mouseY - height / 2).sub(clickedCirc.pos);
    clickedCirc.spinChildren(mouseNow.heading() - mouseOld.heading());
    mouseOld = mouseNow.copy();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("recurCircle-######.png");
    System.out.println("Frame saved");
  } else {
    newRecurCircle();
  }
}
