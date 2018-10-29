import processing.svg.*;

ArrayList<Triangle> triangles;

int NUMTIMES = 4;

void setup() {
  size(800, 800);
  noLoop();
  beginRecord(SVG, "Triangle" + NUMTIMES + ".svg");
}

void draw() {

  translate(width / 2, height / 2);
  Triangle bigTri = new Triangle(0, 0, 412, 0);
  bigTri.display();

  triangles = new ArrayList<Triangle>();
  triangles.add(new Triangle(0, 0, 200, PI));
  for (int i = 0; i < NUMTIMES; i++) {
    for (int k = triangles.size() - 1; k >= 0; k--) {
      Triangle tri = triangles.get(k);
      if (tri.needsRec) {
        for (Triangle babTri : tri.getChildrenTri()) {
          triangles.add(babTri);
        }
      }
    }
  }

  //triangles.add(bigTri);

  for (Triangle tri : triangles) {
    tri.display();
  }

  System.out.println(triangles.size());
  endRecord();
}
