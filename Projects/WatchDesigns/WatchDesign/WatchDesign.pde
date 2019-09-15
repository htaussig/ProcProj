int NUMROWS = 34;

Square[][] squares;

String filename = "Harry.png";
PImage img;

void setup() {
  size(800, 226);
  setup1();
}

void setup1(){
  img = loadImage(filename);
  updateSquares();
}

void updateSquares(){
  squares = new Square[NUMROWS][NUMROWS];
  float s = width / (float) NUMROWS;
  image(img, 0, 0, width, height);
  for (int i = 0; i < NUMROWS; i++) {
    for (int k = 0; k < NUMROWS; k++) {
      float x = i * s;
      float y = k * s;
      squares[i][k] = new Square(x, y, s, getVal(x, y, s));
    }
  }
}

float getVal(float x2, float y2, float s) {
  //loadPixels();  
  float sum = 0;
  // Loop through every pixel column
  for (int x = (int) x2; x < x2 + s; x++) {
    // Loop through every pixel row
    for (int y = (int) y2; y < y2 + s; y++) {
      // Use the formula to find the 1D location
      color c = get((int) x2, (int) y2);
      float val = brightness(c);
      sum += val;
    }
  }
  return sum / (s * s);
  
}


void draw() {
  setup1();
  background(0);
  for (int i = 0; i < NUMROWS; i++) {
    for (int k = 0; k < NUMROWS; k++) {
      squares[i][k].display();
    }
  }
}

void keyPressed(){
  if(key == 'w'){
    NUMROWS++;
    //setup1();
  }
  if(key == 's'){
    NUMROWS--;
    //setup1();
  }
  if(key == 'S'){
    saveFrame();
    
    //setup1();
  }
}
