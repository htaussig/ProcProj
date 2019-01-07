public class WaveCircle {
  float x;
  float y; 
  float r;
  FlatWave flat;
  float lastAddR;
  float noiseX;
  color col;
  float ain;

  public WaveCircle(float x_, float y_, float r_, float xin, float yin) {
    x = x_;
    y = y_;
    r = r_;
    col = (color(255, 0, 0));
    noiseX = random(-2, 2);
    flat = new FlatWave(TWO_PI * r, .1, xin, yin);
    ain = random(TWO_PI);
  }

  public WaveCircle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    col = (color(255, 0, 0));
    noiseX = random(-2, 2);
    flat = new FlatWave(PI * r, 310);
    ain = random(TWO_PI);
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
    for (float a = ain; a < TWO_PI + ain; a += 2 / r) {
      float newR = 0;
      if (flat.points.size() > index) {
        newR = r + getWave(index);
      }
      index++;
      vertex(cos(a) * newR, sin(a) * newR);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  float getWave(int index) {
    float y;
    /**if (flat.len == TWO_PI * r) {
      y = flat.getPointCirc(index, r, 2.5);
    }
    else{**/
      y = flat.getPointStand(index, r, 1);
    //}
    return y;
  }
}
