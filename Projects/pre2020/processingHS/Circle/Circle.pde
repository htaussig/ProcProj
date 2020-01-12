float factor = .3;
boolean increasing = true;
float rate = .01;
float col = 0;

void setup(){
 size(1000, 1000, P2D);
 background(255);
 colorMode(HSB, 100);
 
}

void draw(){
 col = 0;
 drawCircle(width / 2, height / 2, width - 10, height - 10);
 if(increasing){
  factor += (1 - factor) * rate; 
 }
 else{
   factor -= (1 - factor) * rate;
 }
 
 if(factor > .98){
   increasing = false;
 }
 else if(factor < .01){
   increasing = true;
 }
}

void drawCircle(float x, float y, float dx, float dy){
  stroke(col++ % 100, 255, 255);
  ellipse(x, y, dx, dy);
  if(dx > 5 && dy > 5){
    drawCircle(x, y, dx * factor, dy * factor);
  }
  
}