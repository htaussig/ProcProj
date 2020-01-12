public class Particle {
  private static final int HMIN = 160;
  private static final int HMAX = 255;
  float hInc = .3;
  PVector pos;
  PVector vel;
  PVector acc;
  //reduce this for increased resolution
  float maxSpeed = 1;
  PVector prevPos;
  float h;
  boolean increasing;

  public Particle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    prevPos = pos.copy();
    h = HMIN;
    increasing = true;
  }

  void update() {
    prevPos = pos.copy();
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  void follow(PVector[] flowField) {
    int x = (int) (pos.x / scl);
    int y = (int) (pos.y / scl);
    int index = (x + (y * cols));
    PVector force = flowField[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void display() {
    stroke(getColor(colIndex));
    /*if(increasing){
     h += hInc;
     }
     else{
     h -= hInc;
     }
     
     if(h > HMAX){
     h = HMAX;
     increasing = false;
     }
     else if (h < HMIN){
     h = HMIN;
     increasing = true;
     }*/
    //System.out.println(h);
    strokeWeight(1);
    //point(pos.x, pos.y);
    drawOnTorus(pos.x, pos.y, prevPos.x, prevPos.y);
  }

  void drawOnTorus(float x2, float y2, float x1, float y1) {
    float zoff = 0;
    
    float aMain = map(x2, 0, cols - 1, 0, TWO_PI);
    float aSub = map(y2, 0, rows - 1, 0, TWO_PI);

    float xoff = 0;
    float yoff = 0;

    float axVal = cos(aMain);
    float ayVal = sin(aMain);

    xoff = mainMag * axVal;
    yoff = mainMag * ayVal;
    //translate(xoff, yoff, zoff);

    noStroke();
    fill(255, 0, 0);
    //sphere(15);

    //axVal = abs(axVal); //not sure what this line does
    //ayVal = abs(ayVal);
    float axyVal = cos(aSub);
    xoff += (axVal)  * subMag * axyVal;
    yoff += (ayVal)  * subMag * axyVal;
    zoff += -sin(aSub) * subMag;
    
    //fill(255);
    float strokeVal = map(zoff, -subMag, subMag, 50, 255);
    //float strokeVal = map(zoff, -subMag, subMag, 50, 255);
    stroke(getColor(colIndex));
    
    pushMatrix();
    translate(xoff * drawMag, yoff * drawMag, zoff * drawMag);
    point(0, 0, 0);
    //box(10);
    //point(0, 0);
    popMatrix();
  }

  void edges() {
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }

  int getColor(float v) {

    v = abs(v);

    v = v%(colors.size());

    int c1 = colors.get(int(v%colors.size()));

    int c2 = colors.get(int((v+1)%colors.size()));

    return lerpColor(c1, c2, v%1);
  }
}
