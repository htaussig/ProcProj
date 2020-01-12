import processing.video.*;

PImage img;

Capture cam;

void setup() {
  size(1280, 720);
  String[] cameras = Capture.list();
  for (String str : cameras) {
    System.out.println(str);
  }
  cam = new Capture(this, cameras[1]);
  cam.start();
  setup1();
}

void setup1() {
  updateSquares();
}

void updateSquares() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  horizReverse();
}

void grayScale() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color(brightness(pixels[i]));
  }
  updatePixels();
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


float magnify(float val) {
  val = map(val, 0, 255, -1, 1);
  val = pow(val, 3);
  val = map(val, -1, 1, 0, 255);
  return val;
}

void draw() {
  setup1();
}

void keyPressed() {
  if (key ==  's') {
    saveFrame("grayScaleV-######.png");
    System.out.println("Frame saved");
  }
}
