public class Particle {
  private static final int HMIN = 160;
  private static final int HMAX = 255;
  float hInc = .3;
  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed = 2;
  PVector prevPos;
  float h;
  boolean increasing;
  
  float theTempR;

  public Particle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    prevPos = pos.copy();
    h = HMIN;
    increasing = true;
    theTempR = particleSize;
  }
  
  public Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    prevPos = pos.copy();
    h = HMIN;
    increasing = true;
    theTempR = particleSize;
  }

  void update() {
    prevPos = pos.copy();
    vel.sub(vel);
    vel.add(acc);
    vel.limit(maxSpeed);
    //pos.add(vel);
    //acc.mult(0);
  }

  void follow(PVector[] flowField) {
    int x = (int) (pos.x / scl);
    int y = (int) (pos.y / scl);
    int index = (x + (y * cols));
    PVector force = flowField[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    //acc.add(force);
    acc = force;
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
    drawOnTorus(pos.x, pos.y);
  }

  void drawOnTorus(float x2, float y2) {
    float zoff = 0;

    float aMainHere = map(x2, 0, width, 0, TWO_PI);
    //println(aMainHere);
    float aSub = map(y2, 0, height, 0, TWO_PI);

    float xoff = 0;
    float yoff = 0;

    float axVal = cos(aMainHere);
    float ayVal = sin(aMainHere);

    xoff = mainMag * axVal;
    yoff = mainMag * ayVal;
    //translate(xoff, yoff, zoff);

    //float colVal = map(aMain, 0, TWO_PI, 0, 255);
    //stroke(colVal, 100, 100);
    //sphere(15);

    //axVal = abs(axVal); //not sure what this line does
    //ayVal = abs(ayVal);
    float axyVal = cos(aSub);
    xoff += (axVal)  * subMag * axyVal;
    yoff += (ayVal)  * subMag * axyVal;
    zoff += -sin(aSub) * subMag;

    doColors(aMainHere, aSub);

    pushMatrix();
    translate(xoff * drawMag, yoff * drawMag, zoff * drawMag);
    //point(0, 0, 0);

    //rotation for main axis
    rotateZ(aMainHere);

    //rotation for sub axis
    rotateY(aSub);
    
    //box(12);
    //drawTetra(particleSize, 5.5);
    //drawTetra(particleSize, 5.5);
    drawTorusPixel();

    //sphereDetail(4);
    //sphere(8);

    popMatrix();
  }

  //so a torus pixel is gonna go from the both current angles to the
  //next iteration of both angles
  //we have already rotate to the correct location
  void drawTorusPixel() {
    pushMatrix();
    rotateY(-PI / 2);
    float circumfY = TWO_PI * subMag;
    float baseY = (circumfY / aSubChange);
    float baseR = 5;
    beginShape();
    
    vertex(baseY, baseR, 0);
    vertex(-baseY, baseR, 0);
    vertex(-baseY, -baseR, 0);
    vertex(baseY, -baseR, 0);
    endShape();
    popMatrix();
  }

  void drawTetra(float r, float l) {
    //println(r);
    rotateY(-PI / 2);
    
    float baseR = r * .5;
    float will = l;

    beginShape(TRIANGLES);
    vertex(-baseR, -baseR, 0);
    vertex( baseR, -baseR, 0);
    vertex(   0, 0, will * r);

    vertex( baseR, -baseR, 0);
    vertex( baseR, baseR, 0);
    vertex(   0, 0, will * r);

    vertex( baseR, baseR, 0);
    vertex(-baseR, baseR, 0);
    vertex(   0, 0, will * r);

    vertex(-baseR, baseR, 0);
    vertex(-baseR, -baseR, 0);
    vertex(  0, 0, will * r);

    endShape(CLOSE);
    
    beginShape();
    vertex(baseR, baseR, 0);
    vertex(-baseR, baseR, 0);
    vertex(-baseR, -baseR, 0);
    vertex(baseR, -baseR, 0);
    endShape();
  }

  void doColors(float aMain, float aSub) {
    noStroke();
    //println(aMain);
    //float colVal = map(aMain, 0, TWO_PI, 0, 255);
    //float val2 = map(aSub, 0, TWO_PI, 0, 255);

    //colVal = (colVal + val2) % 255;
    //fill(colVal, 100, 100);
    
    //theTempR = map(colVal, 0, 255, -1, 1);
    //theTempR = abs(theTempR);
    //theTempR = map(theTempR, 0, 1, 1, particleSize);
    
    float val = map((acc.heading() + 3 * TWO_PI) % TWO_PI, 0, TWO_PI, 0, colors.size() - 1);
    fill(getColor(val));

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
