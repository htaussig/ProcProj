public class Path {
  float x, y, a;
  boolean b;

  public Path(float x_, float y_, float a_) {
    x = x_;
    y = y_;
    a = a_;
  }


  void display() {
    noFill();
    stroke(255);
    pushMatrix();
    translate(x, y);
    rotate(a);
    float dy = -cellD * sqrt(2) / 2;
    arc(0, dy, cellD, cellD, PI / 4, PI * 3 / 4, OPEN);
    //dy = cellD * 3 /4;
    rotate(PI);
    arc(0, dy, cellD, cellD, PI / 4, PI * 3 / 4, OPEN);
    //rect(0, 0, cellD, cellD / 4);
    popMatrix();
  }
}
