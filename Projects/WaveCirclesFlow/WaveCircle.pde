public class WaveCircle {
  float x;
  float y; 
  float r;
  FlatWave flat;
  float lastAddR;
  float noiseX;
  color col;
  float ain;
  float noiseYInc = 1;
  float ampMult = 1;
  int flatWaveLen = 100;

  /** public WaveCircle(float x_, float y_, float r_, float xin, float yin) {
   x = x_;
   y = y_;
   r = r_;
   col = (color(255, 0, 0));
   noiseX = random(-2, 2);
   flat = new FlatWave(TWO_PI * r, .1, xin, yin);
   ain = random(TWO_PI);
   }**/

  public WaveCircle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    col = (color(255, 0, 0));
    noiseX = random(-2, 2);
    flat = new FlatWave(flatWaveLen, 50);
    ain = random(TWO_PI);
  }

  void setColor(color col_) {
    col  = col_;
  }

  void display() {
    //flat.addNoiseX(noiseX);
    display(x, y, r);
  }

  void display(float x1, float y1, float r1) {
    flat.addNoiseY(noiseYInc);
    noStroke();
    fill(col);
    pushMatrix();
    translate(x1, y1);
    int index = 0;
    beginShape();
    //for (float a = ain; a < TWO_PI + ain; a += 1 / r1) {
    for (float a = ain; a <= TWO_PI + ain; a += TWO_PI / flatWaveLen) {
      float newR = 0;
      if (flat.points.size() > index) {
        newR = r1 + getWave(index);
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
    y = flat.getPointStand(index, r, ampMult);
    //}
    return y;
  }
}
