public class Curve {
  float x, y, w, h, a;
  Curve(float x_, float y_, float w_, float h_, float a_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    a = a_;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(a);
    float x1 = 0;
    float y1 = h;
    float x2 = 0;
    float y2 = 0;
    float dx = w / NUMTIMES;
    float dy = h / NUMTIMES;
    for (int i = 0; i <= NUMTIMES; i++) {
      line(x1, y1, x2, y2);
      x2 += dx;
      y1 -= dy;
    }
    popMatrix();
  }
}
