int[][] result;
float t;

void setup() {
  size(500, 500, P2D);
  smooth(8);
  fill(255);
  blendMode(EXCLUSION);
  noStroke();
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
      pixels[i] =color(result[i][0]*1.0/samplesPerFrame, 
      result[i][1]*1.0/samplesPerFrame, result[i][2]*1.0/samplesPerFrame);
    updatePixels();

    /*saveFrame("f###.gif");
    if (frameCount==numFrames)
      exit();*/
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 1;
int numFrames = 86;        
float shutterAngle = .7;

boolean recording = true;

void setup_() {
  
}

float d = 110, sp = d*.5;
float hd, x, y;
int N = 8;
int q;
float tt;
float f1 = 1, f2 = .5*sqrt(3);
float df;

void draw_() {
  tt = 3*t*t - 2*t*t*t;
  background(255);
  pushMatrix();
  translate(width/2, height/2);
  for (int i=-N; i<=N; i++) {
    for (int j=-N; j<=N; j++) {
      x = i*sp; 
      y = j*.5*sqrt(3)*sp;
      if (j%2 != 0)
        x += .5*sp;
      hd = max(abs(y), abs(.5*y+.5*sqrt(3)*x));
      hd = max(hd, abs(.5*y-.5*sqrt(3)*x));
      q = floor(hd/sp+.9);
      df = map(sin(TWO_PI*t - PI*q/12),-1,1,0,1);
      df = 3*df*df - 2*df*df*df;
      df = 3*df*df - 2*df*df*df;
      df = map(df,0,1,f1,f2);
      
      x *= df;
      y *= df;
      ellipse(x, y, d, d);
    }
  }
  popMatrix();
  filter(OPAQUE);
}