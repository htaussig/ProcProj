import processing.video.*;


int NUMROWS = 40;

Square[][] squares;

String filename = "yinyang.png";
PImage img;

Capture cam;

void setup() {
  size(640, 360);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[3]);
  cam.start();
  setup1();
}

void setup1() {
  img = loadImage(filename);
  updateSquares();
}

void updateSquares() {
  squares = new Square[NUMROWS][NUMROWS];
  float s = width / (float) NUMROWS;
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  horizReverse();
  for (int i = 0; i < NUMROWS; i++) {
    for (int k = 0; k < NUMROWS; k++) {
      float x = i * s;
      float y = k * s;
      squares[i][k] = new Square(x, y, s, getVal(x, y, s));
    }
  }
}

void horizReverse() {
  loadPixels();
  int[] newPixels = new int[pixels.length];
  for (int x = 0; x < width; x++) {
    for (int y= 0; y < height; y++) {
      newPixels[x + y * width] = pixels[(-x) + (y + 1) * width - 1];
    }
  }
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = newPixels[i];
  }
  updatePixels();
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
      val = magnify(val);
      sum += val;
    }
  }
  return sum / (s * s);
}

float magnify(float val) {
  val = map(val, 0, 255, -1, 1);
  val = pow(val, 3);
  val = map(val, -1, 1, 0, 255);
  return val;
}

void draw() {
  setup1();
  background(255);
  for (int i = 0; i < NUMROWS; i++) {
    for (int k = 0; k < NUMROWS; k++) {
      squares[i][k].display();
    }
  }
}

void keyPressed() {
  if (key == 'w') {
    NUMROWS++;
    //setup1();
  }
  if (key == 's') {
    NUMROWS--;
    //setup1();
  }
}
