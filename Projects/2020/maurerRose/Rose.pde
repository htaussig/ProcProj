public class Rose {

  float n;
  float d;
  float x, y;

  public Rose(float n_, float d_, float x_, float y_) {
    n = n_;
    d = d_;
    x = x_;
    y = y_;
  }

  public void display() {
    
    pushMatrix();
    translate(x, y);
    
    beginShape();
    stroke(0, 0, 255);
    strokeWeight(0.5);
    for (int theta = 0; theta <= NUMLINES; theta++) {
      float k = theta * d * PI / 180;
      float r = 300 / NUMCOLS * sin(n * k);
      float x1 = r * cos(k) + width/2;
      float y1 = r * sin(k) + height/2;
      vertex(x1, y1);
    }
    endShape();
    popMatrix();

    //for the strong outline
    //beginShape();
    //stroke(255, 0, 0);
    //strokeWeight(4);
    //for (int theta = 0; theta <= 360; theta++) {
    //  float k = theta * PI / 180;
    //  float r = 300 * sin(n * k);
    //  float x = r * cos(k) + width/2;
    //  float y = r * sin(k) + height/2;
    //  vertex(x, y);
    //}
    //endShape();
  }
}
