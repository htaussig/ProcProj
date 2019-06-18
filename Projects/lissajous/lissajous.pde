float angle = 0;
int w = 130;
int h = 130;
int cols, rows;
float d = w - 10;
float r = d / 2;

ArrayList<Circle> circs = new ArrayList<Circle>();

Curve[][] curves;

void setup() {
  size(800, 800);
  colorMode(HSB);
  
  pixelDensity(1);
  cols = -1 + width / w;
  rows = -1 + height / w;

  for (int i = 0; i < cols; i++) {
    circs.add(new Circle((i + 1.5) * w, h / 2, r, - PI / 2, true));
  }
  for (int i = 0; i < cols; i++) {
    circs.add(new Circle(w / 2, (i + 1.5) * h, r, - PI / 2, false));
  }


  curves = new Curve[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int k = 0; k < rows; k++) {
      curves[i][k] = new Curve(circs.get(i), circs.get(k + cols));
    }
  }
}

void keyPressed() {

  saveFrame("lissajous####.png");
  print("frame saved");
}

void draw() {
  background(0);

  stroke(255);
  noFill();
  
  boolean fade = false;
  if (circs.get(0).a + PI / 2 > TWO_PI / 2) {
    fade = true;
  }

  for (Curve[] curveArr : curves) {
    for (Curve c : curveArr) {
      c.addPoint();
      if (fade) {
        c.cut();
      }
      c.display();
    }
  }
  
  
  for (int i = 0; i < circs.size(); i++) {
    Circle circ = circs.get(i);
    circ.rot((((i) % rows) + 1) * .01);

    circ.display();
  }
}
