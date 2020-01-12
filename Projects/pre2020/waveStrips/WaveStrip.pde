float da = 1 * PI / 64.0;

class WaveStrip {

  color col;
  
  float y, w, amp, a;

  public WaveStrip(float y_, float w_, float amp_, float a_, color col_) {
    y = y_;
    w = w_;
    amp = amp_;
    a = a_;
    
    col = col_;
  }

  void display() {
    
    colorMode(HSB);
    //fill(col);
    //stroke(255);
    //noStroke();
    
    beginShape();

    vertex(0, y);

    float tempA = a;

    for (int i = 0; i < NUMTRIS; i++) {    

      float x = (((i + .5) / NUMTRIS) * width) + ((sin(tempA) / 3) * width / NUMTRIS);

      vertex(x, y - amp);

      vertex(((i + 1.0) / NUMTRIS) * width, this.y);

      tempA += xPERIOD;
    }

    a += da;

    endShape(OPEN);
  }
}
