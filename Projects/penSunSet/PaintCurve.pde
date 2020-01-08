//makes the curves non-uniform
boolean weirdCurves = true;

class PaintCurve extends PaintStroke {

  //max d for a circle the stroke is based on
  float MAXD = 400;
  float MIND = 80;

  //max angle deviation for the rough look of curves
  float ADEV = radians(3);

  float a1, a2;
  float d;

  //x an y hold the center of the circle
  //a curve constructor
  public PaintCurve(float x1_, float y1_, float r_, float a1_, float a2_, color col_) {
    initVars(x1_, y1_, r_, a1_, a2_, col_);    

    initCurve();
  }

  //constructor for a random curve
  public PaintCurve() {
    float x = random(width); 
    float y = random(height);
    float r = random(MIND, MAXD);

    float ang1 = random(0, TWO_PI * 3 / 4);
    //max rotation is 3 / 4 of a circle
    float ang2 = random(ang1 + radians(30), ang1 + TWO_PI * 3 / 4);

    color col_ = THECOLOR;
    initVars(x, y, r, ang1, ang2, col_);

    initCurve();
  }

  void initVars(float x1_, float y1_, float r_, float a1_, float a2_, color col_) {
    x1 = x1_;
    y1 = y1_;
    a1 = a1_;
    a2 = a2_;
    d = r_;
    col = col_;
  }

  void initCurve() {

    // the points the curve ends and starts at
    PVector pos1 = new PVector(x1 + cos(a1) * d, y1 + sin(a1));
    PVector pos2 = new PVector(x1 + cos(a2) * d, y1 + sin(a2));

    l = calcLength();

    //strokeLength = l;

    //a pvector perpendicular to the line with a length of one 
    //allows us to draw many lines for each tiny stroke of one big paint stroke
    //inwards = new PVector(pos2.x - pos1.x, pos2.y - pos1.y).rotate(radians(180)).setMag(1);
    inwards = new PVector(pos2.x - pos1.x, pos2.y - pos1.y).setMag(.3);

    //how thick the whole paintStroke will be
    numLines = (int) random(70, 170);

    pushStyle();
    colorMode(HSB, 99, 99, 99);
    h = hue(col);
    s = saturation(col);
    b = brightness(col);
    popStyle();

    //shape = generateShape();
  }

  float calcLength() {
    return -1;
  }

  PShape generateShape() {
    //how far along the path to make this partcular stroke
    //float lerpPercent = strokeLength / l;

    return createShape(ARC, x1, y1, d, d, a1, a2);
  }

  //generate the arc but with different angles
  //this allows us to get the rough edges on the strokes
  PShape generateShape(float ang1, float ang2) {
    //how far along the path to make this partcular stroke
    //float lerpPercent = strokeLength / l;

    return createShape(ARC, x1, y1, d, d, ang1, ang2);
  }

  void display() {

    colorMode(HSB, 99, 99, 99);

    noFill();    
    //strokeWeight(4);


    //stroke(color(h, s, b + random(-MAXBCHANGE, MAXBCHANGE)));

    //PShape tempShape = generateShape();   
    //tempShape.disableStyle();


    pushMatrix();
    for (int i = 0; i < numLines / 2; i++) {

      //strokeWeight(random(1.7, 3));
      stroke(color(h, s, b + random(-MAXBCHANGE, MAXBCHANGE)));
      //stroke(color(h, s, b + random(-MAXBCHANGE, MAXBCHANGE)));
      //to get where we actually want to draw each individual stroke
      if (weirdCurves) {
        translate(inwards.x, inwards.y);
      }

      //the proper lerp percentage to add to have the stroke lengths we want
      //float extraLerp = strokeLength / l;

      //the angle that each mini stroke travels over
      float da = TWO_PI / 60;

      float aMin = a1 + random(-ADEV, ADEV);
      float aMax = a2 + random(-ADEV, ADEV);

      float num = (aMax - aMin) / da;
      for (int k = 0; k < num; k++) {
        
        //for the first inner layer and last outer layer, just do one big arc, otherwise the edges look very rough
        if (i == 0 || i == (numLines / 2) - 1) {
          PShape circShape = generateShape();
          circShape.disableStyle();
          shape(circShape, 0, 0);
          break;
        } else {
          //strokeWeight(random(1.5, 2.7));
          strokeWeight(STROKEWEIGHT);

          float aNext = aMin + da;
          PShape circShape = generateShape(aMin, aNext);
          circShape.disableStyle();
          shape(circShape, 0, 0);

          aMin = aNext;
        }
      }
       
      //increase the diameter of the circle being drawn
      d += 2;
    }
    popMatrix();

    //shape(tempShape, 0, 0);
  }
}
