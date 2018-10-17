public class WaveCircle {
  float x;
  float y; 
  float r;
  FlatWave flat;
  float lastAddR;
  float noiseX;
  color col;

  public WaveCircle(float x_, float y_, float r_, float xin, float yin) {
    x = x_;
    y = y_;
    r = r_;
    col = (color(255, 0, 0));
    noiseX = random(-2, 2);
    flat = new FlatWave(TWO_PI * r, 890, 510, xin, yin);
  }

  public WaveCircle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    col = (color(255, 0, 0));
    noiseX = random(-2, 2);
    flat = new FlatWave(TWO_PI * r, 890, 510);
  }

  void setColor(color col_) {
    col  = col_;
  }

  void display() {
    flat.addNoiseX(noiseX);
    flat.addNoiseY(1);
    stroke(col);
    pushMatrix();
    translate(x, y);
    int index = 1;
    lastAddR = getWave(0);
    for (float a = 1 / r; a < TWO_PI; a += 1 / r) {
      float newR = r;
      float nextAddR = 0;
      if (flat.points.size() > index) {
        nextAddR = getWave(index);
        newR += nextAddR;
      }
      index++;
      float lastR = r + lastAddR;
      float lastA = a - (1 / r);
      displayTriangle(cos(lastA) * lastR, sin(lastA) * lastR, cos(a) * newR, sin(a) * newR);
      //line(cos(lastA) * lastR, sin(lastA) * lastR, cos(a) * newR, sin(a) * newR);
      lastAddR = nextAddR;
      if (a >= TWO_PI - (1 / r)) {
        float firstR = r + getWave(0);
        displayTriangle(cos(0) * (firstR), sin(0) * (firstR), cos(a) * newR, sin(a) * newR);
        //line(cos(0) * (firstR), sin(0) * (firstR), cos(a) * newR, sin(a) * newR);
      }
    }
    popMatrix();
  }
  
  void displayTriangle(float x1, float y1, float x2, float y2){
    pushMatrix();
    noStroke();
    //strokeWeight(1);
    fill(col);
    
    beginShape();
    vertex(0,0);
    vertex(x1, y1);
    vertex(x2, y2);
    endShape(CLOSE);
    
    popMatrix();
  }

  float getWave(int index) {
    if (flat.len == TWO_PI * r) {
      return flat.getPointCirc(index, r, 1.5);
    }
    return flat.getPointStand(index);
  }
}
