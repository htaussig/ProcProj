float r = 300;

//color values
float white = 245;
float dark = 40;

//angle around the hex that the triangle is
float a = 0;

Triangle tri;

float triR = r / sqrt(3);

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

  drawHex();
  tri.display();
}

void drawHex() {
  noStroke();
  fill(dark);
  beginShape();
  for (float i = .5; i < 6.5; i++) {
    float thisA = i * TWO_PI / 6;
    vertex(r * cos(thisA), r * sin(thisA));
  }
  endShape(CLOSE);
}
