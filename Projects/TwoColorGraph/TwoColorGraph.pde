
int NUMCOLS = 10;
int NUMROWS = 10;

float size = 10;

void setup(){
  size(600, 600);
  blendMode(DIFFERENCE);
  noStroke();
}

void draw(){
  background(255);
  float dx = (float) width / NUMCOLS;
  for(float x = 0; x < width; x += dx){
    fill(255);
    rect(x, 0, size, height);
  }
  
  float dy = (float) height / NUMCOLS;
  for(float y = 0; y < height; y += dy){
    fill(255);
    rect(0, y, width, size);
  }
  
  ellipse(mouseX, mouseY, 100, 100);
}
