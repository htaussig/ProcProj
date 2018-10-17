float th1, th2, r1 = 110, r2 = 100;
float d;
float x, y, t;
int N = 66;
float s = .0015;
int nf = 320;
float tt;

void setup() {
  size(500, 500, P2D);
  smooth(8);
  colorMode(HSB,1);
  noStroke();
}

void draw() {
  t = frameCount/float(nf);

  background(0);
  for (int i=0; i<N; i++) {
    tt = (frameCount + i/3.0)/float(nf);
    th1 = TWO_PI*(tt);
    fill((th1/TWO_PI)%1,0.65,1);
    th2 = -10*TWO_PI*(tt);
    x = width/2 + r1*cos(th1) + r2*cos(th2);
    y = height/2 + r1*sin(th1) + r2*sin(th2);
    d = map(cos(TWO_PI*i/N),1,-1,0,6);
    pushMatrix();
    translate(x,y);
    rotate(-QUARTER_PI);
    ellipse(0, 0, d, d*1.25);
    popMatrix();
  }
  
  //saveFrame("f###.gif");
  if(frameCount==nf)
    exit();
}