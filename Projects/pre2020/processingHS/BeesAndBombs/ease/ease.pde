// by dave @ bees & bombs >:)

int[][] result;
float t;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float mn = .5*sqrt(3);

void setup() {
  size(500, 500, P2D);
  smooth(8);
  rectMode(CENTER);
  stroke(248);
  strokeWeight(1.55);
  noFill();
  result = new int[width*height][3];
}

void draw() {

  if (!recording) {
    t = mouseX*1.0/width;
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

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

    /*saveFrame("f###.gif");
    if (frameCount==numFrames)
      exit();*/
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 8;
int numFrames = 120;        
float shutterAngle = .45;

boolean recording = true;

void setup_() {
  
}

float x, y, tt;
int N = 12;
float sp = 39;

void draw_() {
  background(32); 
  pushMatrix();
  translate(width/2, height/2);
  rotate(TWO_PI*t/6);
  for (int a=0; a<3; a++) {
    pushMatrix();
    rotate(TWO_PI*a/3);
    for (int i=-N; i<=N; i++) {
      y = i*sp*pow(2, t);
      tt = constrain(1.09*t - 0.00275*abs(y) + .075, 0, 1);
      if (i%2 == 0)
        x = width;
      else
        x = width*tt;
      if (x>0)
        line(-x, y, x, y);
    }
    popMatrix();
  }
  popMatrix();
}