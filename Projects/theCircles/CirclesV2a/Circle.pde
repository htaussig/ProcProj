public class Circle {
  float x, y, r;
  float hue, sat, bri;
  color col;
  public Circle(float x_, float y_, float r_, float[] col_) {
    x = x_;
    y = y_;
    r = r_;
    hue = col_[0];
    sat = col_[1];
    bri = col_[2];
  }

  void display() {
    noStroke();
    //stroke(color(hue, sat, bri, opacity));
    float opacity = map(r, minCircRadius, maxCircRadius, 1, 99);
    col = color(hue, sat, bri, opacity);
    fill(col);
    float radiusMult = random(.5 , 2);
    dotCircle(x, y, radiusMult * r);
  }

  void dotCircle(float x, float y, float drawR) {
    strokeWeight(2);
    stroke(col);
    pushMatrix();
    translate(x, y);

    for (float r = 1; r < drawR; r += 1) {
      float start = random(TWO_PI);
      //float dA = 16 * 2 * PI / diameter;
      float numIterations = 5 * drawR;

      for (float a = start; a < start + TWO_PI; a += TWO_PI / numIterations) {
        float rNum = 1 * (pow((r / drawR), 8));
        if(random(1) < rNum){
          point(r * cos(a), r * sin(a));
        }
      }
    }

    popMatrix();
  }
}
