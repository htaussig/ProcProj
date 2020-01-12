int numStrokes = 100;
ArrayList<PaintStroke> strokes;

//can use my PalletteBook Sketch, click on the pallettes, and copy them in here
Palette pal = new Palette("37#22283126#393E4617#00ADB517#EEEEEE");

void setup() {
  size(600, 600);

  //paints use subtractive color blending
  //blendMode(SUBTRACT);

  strokes = new ArrayList<PaintStroke>();

  initStrokes();
  smooth(8);
}

void initStrokes() {
  strokes.clear();
  for (int i = 0; i < numStrokes / 3; i++) {
    strokes.add(new PaintStroke());
    strokes.add(new PaintCurve());
    //strokes.add(new PaintCurveVert());
  }
      
  background(pal.getColor());
  for (PaintStroke stroke : strokes) {
    stroke.display();
  }

  borders();
}

void draw() {
  print();
}

void borders() {

  float w = 15;
  noStroke();
  //fill(pal.getLightestColor());
  fill(0);
  rect(0, 0, width, w);
  rect(0, height - w, width, height);

  rect(0, 0, w, height);
  rect(width - w, 0, width, height);

  noFill();
  strokeWeight(15);
  stroke(0);
  //rect(w, w, width - w * 2, height - w * 2);
}

void mouseClicked() {
  initStrokes();
}

void keyPressed() {
  if (key == 's') {
    saveFrame("Paint-######.png");
    System.out.println("Frame saved");
  }
}
