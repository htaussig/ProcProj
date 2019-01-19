float r = 340;

//color values
float white = 255;
float dark = 0;

Triangle tri;
Triangle tri2;

ArrayList<Triangle> tris = new ArrayList<Triangle>();

float triR = r / sqrt(3);

float wholeA = 0;

boolean RECORDING = true;

float da = .6;

void setup() {
  size(800, 800);
  
  frameRate(60);
  
  for(int i = 0; i < 6; i++){
    tris.add(new Triangle(0, 0, triR, radians(60 * i), da));
  }
  blendMode(DIFFERENCE);
}

void draw() {  
  translate(height / 2, width / 2);
  rotate(wholeA);
  wholeA += radians(da);
  
  background(white);

  drawHex();
  for(Triangle tri : tris){
   tri.display(); 
  }
  
  if(RECORDING && frameCount <= 100){
   saveFrame("movie/f####.gif");
   print("saved");
  }
}

void drawHex() {
  noStroke();
  fill(white);
  beginShape();
  for (float i = .5; i < 6.5; i++) {
    float thisA = i * TWO_PI / 6;
    vertex(r * cos(thisA), r * sin(thisA));
  }
  endShape(CLOSE);
}
