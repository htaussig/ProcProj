
//can use my PalletteBook Sketch, click on the pallettes, and copy them in here
Palette pal = new Palette("17#EEEEEE");

//wave variables
float AMP = 1890;
float LENDIV = 1220;

float start;
float xin;

FlatWave flat;

void setup() {
  size(600, 600);

  //paints use subtractive color blending
  //blendMode(SUBTRACT);

  initWave();
  //smooth(8);
}

void initWave() {
  frameRate(60);
  flat = new FlatWave(width, AMP, LENDIV);
}


void draw() {
  background(0);
  
  displayWave();
}

void displayWave(){
  strokeWeight(2);
  
  flat.addNoiseY(1.25);
  flat.addNoiseX(1.5);
  ArrayList<PVector> points = flat.display();
  
  PaintCurveVert asdf = new PaintCurveVert(points);
  asdf.points.add(0, asdf.points.get(0));
  
  int index = asdf.points.size() - 1;
  asdf.points.add(index, asdf.points.get(index));
  asdf.display();
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
}

void keyPressed() {
  if (key == 's') {
    saveFrame("Paint-######.png");
    System.out.println("Frame saved");
  }
}
