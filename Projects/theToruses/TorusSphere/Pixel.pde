public class Pixel {

  //where the "pixel" is drawn
  //points[1] -> points[4] is the corners of the pixel
  //points[0] is where the pixel is calculated (for color or distance)
  PVector[] points = new PVector[5];

  //not sure we'll need this but can update it separately
  color col;

  float val;

  public Pixel(PVector[] thePix_) {
    points = thePix_;
  }

  void doColors() {
    PVector p = points[0];
    float v = getNoiseValueBasic(p.x/drawMag, p.y/ drawMag, p.z/ drawMag);
    float colVal = map(v, -1, 1, 0, colors.size() - 1);
    fill(getColor(colVal));
    noStroke();

    val = map(v, -1, 1, .9, 1.1);
  }

  void setColor(PVector p) {
    float v = getNoiseValueBasic(p.x/drawMag, p.y/ drawMag, p.z/ drawMag);
    float colVal = map(v, -1, 1, 0, colors.size() - 1);
    fill(getColor(colVal));
  }

  int getColor(float v) {
    v = abs(v);
    v = v%(colors.size());
    int c1 = colors.get(int(v%colors.size()));
    int c2 = colors.get(int((v+1)%colors.size()));
    return lerpColor(c1, c2, v%1);
  }

  //draws a rect using the four vertices and the color
  void display() {
    doColors();
    //stroke(0);
    beginShape(TRIANGLE_STRIP);
    for (int i = 1; i < 5; i++) {
      PVector p = points[i];
      float v = getNoiseValueBasic(p.x/drawMag, p.y/ drawMag, p.z/ drawMag);
      float magMult = map(v, -1, 1, .8, 1.2);
      //float magMult = 1;
      vertex(p.x * magMult, p.y * magMult, p.z * magMult);
      //if (i == 3) {
      //  setColor(points[4]);
      //}
    }

    endShape(CLOSE);
  }
}
