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
    flat = new FlatWave(PI * r, 1, 310, xin, yin);
    if(PI * r > 800){
      System.out.println("array size is greater than 800");
    }
  }

  public WaveCircle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    col = (color(255, 0, 0));
    noiseX = random(-2, 2);
    flat = new FlatWave(PI * r, 1, 310);
    if(PI * r > 800){
      System.out.println("array size is greater than 800");
    }
  }

  void setColor(color col_) {
    col  = col_;
  }

  void display() {
    //flat.addNoiseX(noiseX);
    flat.addNoiseY(1);
    noStroke();
    fill(col);
    pushMatrix();
    translate(x, y);
    int index = 0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += 2 / r) {
      float newR = r;
      float nextAddR = 0;
      if (flat.points.size() > index) {
        nextAddR = getWave(index);
        newR += nextAddR;
      }
      index++;
      vertex(cos(a) * newR, sin(a) * newR);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  float getWave(int index) {
    float y;
    if (flat.len == TWO_PI * r) {
      y = flat.getPointCirc(index, r, 1.5);
    }
    else{
      y = flat.getPointStand(index, r, 1.5);
    }
    return y;
  }
}
