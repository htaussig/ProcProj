//the darker a color is the more "wet" it looks
//maybe less brightness change for darker colors

//could try making stuff go the same way, normalize the length of the strokes

//increasing this will create more mini strokes per line of each big stroke
float SPLMULT = 2.5;
//float STROKEWEIGHT = 4;
//the maximum amount the brightness of the color can change between strokes / 2
//basically how wet/thick the paint looks
float MAXBCHANGE = 8;
float strokeLength = 20;

//helps the strokes cover the whole frame, allows them to go out of the window
//something weird is going on, strokes don't like going in the top left
float HELP = 80;



public class PaintStroke {

  float x1, y1, x2, y2;
  //the length
  float l;
  color col;
  //the direction to move to layer the stroke
  PVector inwards;

  float h, s, b;

  //number of lines that make up a stroke
  //right now we only go downwards ***
  int numLines;

  //a line constructor
  public PaintStroke(float x1_, float y1_, float x2_, float y2_, color col_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;

    PVector pos1 = new PVector(x1, y1);
    PVector pos2 = new PVector(x2, y2);

    l = PVector.dist(pos1, pos2);

    //strokeLength = l;

    //a pvector perpendicular to the line with a length of one 
    //allows us to draw many lines for each tiny stroke of one big paint stroke
    inwards = new PVector(x2 - x1, y2 - y1).rotate(radians(90)).setMag(1);
    col = col_;

    //how thick the whole paintStroke will be
    numLines = (int) random(90, 170);

    pushStyle();
    colorMode(HSB, 99, 99, 99);
    h = hue(col);
    s = saturation(col);
    b = brightness(col);
    popStyle();

    //shape = generateShape();
  }

  //a curve constructor
  public PaintStroke(float x1_, float y1_, float x2_, color col_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;

    PVector pos1 = new PVector(x1, y1);
    PVector pos2 = new PVector(x2, y2);

    l = PVector.dist(pos1, pos2);

    //strokeLength = l;

    //a pvector perpendicular to the line with a length of one 
    //allows us to draw many lines for each tiny stroke of one big paint stroke
    inwards = new PVector(x2 - x1, y2 - y1).rotate(radians(90)).setMag(1);
    col = col_;

    //how thick the whole paintStroke will be
    numLines = (int) random(90, 170);

    pushStyle();
    colorMode(HSB, 99, 99, 99);
    h = hue(col);
    s = saturation(col);
    b = brightness(col);
    popStyle();
  }

  //a random line and random color
  public PaintStroke() {
    this(random(-HELP, width + HELP), random(-HELP, height + HELP), random(-HELP, width + HELP), random(-HELP, height + HELP), pal.getColor());
  }

  PShape generateShape() {
    //how far along the path to make this partcular stroke
    float lerpPercent = strokeLength / l;

    float otherX = lerp(x1, x2, lerpPercent);
    float otherY = lerp(y1, y2, lerpPercent);

    return createShape(LINE, x1, y1, otherX, otherY);
  } 

  void display() {
    noFill();
    //stroke(col);
    //line(x1, y1, x2, y2);

    pushMatrix();
    pushStyle();
    colorMode(HSB, 99, 99, 99);

    PShape tempShape = generateShape();
    //so that the shape just uses the default styles like stroke()
    tempShape.disableStyle();

    //stroke per line
    float sPL = (l / strokeLength) * SPLMULT;
    for (int i = 0; i < numLines / 2; i++) {

      strokeWeight(random(2, 4.5));
      stroke(color(h, s, b + random(-MAXBCHANGE, MAXBCHANGE)));
      //stroke(color(h, s, b + random(-MAXBCHANGE, MAXBCHANGE)));
      //to get where we actually want to draw each individual stroke
      translate(inwards.x, inwards.y);

      //the proper lerp percentage to add to have the stroke lengths we want
      float extraLerp = strokeLength / l;

      for (int k = 0; k < sPL; k++) {
        //adjusted strokeweight here gives a much rougher feel
        //strokeWeight(random(2, 4));
        //how far along the path to make this partcular stroke
        float r = random(1 - extraLerp);
        float x = lerp(x1, x2, r);
        float y = lerp(y1, y2, r);

        //the subtraction centers each line since we are drawing them from one point
        shape(tempShape, x - x1 / 2, y - y1 / 2);
      }
    }
    popStyle();
    popMatrix();
  }
}
