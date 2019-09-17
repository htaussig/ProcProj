
int NUMCOLS = 10;
int NUMROWS = 10;

//float size = 10;

ArrayList<CurvyLine> lines = new ArrayList<CurvyLine>();

//time for perlin noise
float t;
float TIMEINC = .003;

int NUMLINES = 5; //numlines per side


void setup(){
  size(600, 600);
  blendMode(DIFFERENCE);
  noStroke();
  frameRate(1000);
  
  genLines();
}

void genLines(){
  NUMLINES -= 1;
  for(int i = 0; i <= width; i += width){
    for(float j = 0; j <= NUMLINES; j++){
      lines.add(new CurvyLine(i, (j/ NUMLINES) * height));
      lines.add(new CurvyLine((j/ NUMLINES) * width, i));
    }
  }
  
}

void draw(){
  background(255);
  //grid
  //float dx = (float) width / NUMCOLS;
  //for(float x = 0; x < width; x += dx){
  //  fill(255);
  //  rect(x, 0, size, height);
  //}
  
  //float dy = (float) height / NUMCOLS;
  //for(float y = 0; y < height; y += dy){
  //  fill(255);
  //  rect(0, y, width, size);
  //}
  
  for(CurvyLine c : lines){
    c.display();
  }
  
  t += TIMEINC;
  
  //ellipse(mouseX, mouseY, 100, 100);
}

void keyPressed(){
  if(key == 's'){
    saveFrame();
    println("frame saved");
  }
}
