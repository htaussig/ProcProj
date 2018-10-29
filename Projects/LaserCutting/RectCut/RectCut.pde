import processing.svg.*;

ArrayList<Shape> shapes;

int NUMTIMES = 5;

void setup() {
  size(800, 800);
  noLoop();
  background(255);
  beginRecord(SVG, "RectCut" + NUMTIMES + ".svg");
}

void draw() {
  shapes = new ArrayList<Shape>();
 
  translate(width / 2, height / 2);
  float size = 780;
  Shape bigTri = new Shape(0, 0, 0, size);
  shapes.add(bigTri);

  
  for (int i = 0; i < NUMTIMES; i++) {
    for (int k = shapes.size() - 1; k >= 0; k--) {
      Shape tri = shapes.get(k);
      if (tri.needsRec) {
        for (Shape babTri : tri.getChildrens()) {
          shapes.add(babTri);
        }
      }
    }
  }

  //triangles.add(bigTri);

  for (Shape tri : shapes) {
    tri.display();
  }

  System.out.println(shapes.size());
  //endRecord();
}

void keyPressed(){
  if(key == 'w'){
    NUMTIMES++;
    setup();
  }
  if(key == 's'){
    NUMTIMES--;
    setup();
  }
  if(key == 'p'){
    saveFrame("RectCut-######.png");
    System.out.println("saved");
  }
}
