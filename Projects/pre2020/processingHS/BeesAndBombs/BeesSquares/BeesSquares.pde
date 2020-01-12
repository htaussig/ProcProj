int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float mn = .5*sqrt(3), ia = atan(sqrt(.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

float c01(float g) {
  return constrain(g, 0, 1);
}

void draw() {

  if (!recording) {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();

  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 1;
int numFrames = 600;        
float shutterAngle = .1;

boolean recording = false;

void setup() {
  size(800, 800, P3D);
  pixelDensity(recording ? 1 : 2);
  smooth(8);
  result = new int[width*height][3];
  rectMode(CENTER);
  fill(32);
  noStroke();
  ortho();
}

float x, y, z, tt;
int N = 24;
float l = 340;
float ss = 8;

void boxx() {
  fill(30);
  box(l, l/N, l);
  fill(250);
  for (int i=0; i<4; i++) {
    push();
    rotateY(HALF_PI*i);
    translate(0, 0, l/2+.1);
    rect(0, 0, l-ss, l/N-ss);
    pop();
  }

  for (int i=0; i<2; i++) {
    push();
    rotateX(HALF_PI+PI*i);
    translate(0, 0, l/(2*N)+.1);
    rect(0, 0, l-ss, l-ss);
    pop();
  }
}

void draw_() {
  background(30); 
  push();
  translate(width/2, height/2);
  rotateX(-ia);
  rotateY(QUARTER_PI);
  
  for (int i=0; i<N; i++) {
    push();
    translate(0, l/N*(i-.5*(N-1)), 0);
    rotateY(-HALF_PI*(i+1)*t);
    boxx();
    pop();
  }
  pop();
}