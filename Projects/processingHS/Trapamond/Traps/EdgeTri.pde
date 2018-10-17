public class EdgeTri extends Triangle {

  PVector axis;
  float sl;
  float yA;

  //x and y define the edge of the triangle that will rotate in
  public EdgeTri(float x_, float y_, float z_, float r_) {
    super(x_, y_, z_, r_);
    sl = r_ * sqrt(3);
    yA = 0;
  }

  public boolean done() {
    if (abs(yA) >= PI) {
      return true;
    }
    return false;
  }

  public void enlarge() {
    r += sizeInc;
    PVector me = new PVector(x, y);
    PVector center = new PVector(0, 0);
    PVector diff = PVector.sub(me, center).normalize();
    diff.mult(r / 2);
    x = 0 + diff.x;
    y = 0 + diff.y;
    updateSL();
  }

  void updateSL() {
    sl = r * sqrt(3);
  }

  void rotateIn(float rotV) {
    yA += rotV;
  }

  public void display() {
    noStroke();
    //stroke(color(255));
    fill(col2);
    pushMatrix();
    translate(x, y, z);
    rotateZ(zA);
    rotateY(yA);
    beginShape(TRIANGLE);
    vertex(0, sl / 2, -.005);
    vertex(r * 3 / 2, 0, -.005);
    vertex(0, -sl / 2, -.005);
    
    fill(col1);
    vertex(0, sl / 2, .005);
    vertex(r * 3 / 2, 0, .005);
    vertex(0, -sl / 2, .005);

    endShape();
    popMatrix();
  }
}