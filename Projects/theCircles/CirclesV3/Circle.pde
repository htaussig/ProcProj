public class Circle{
  float x, y, r;
  float hue, sat, bri;
  color col;
  float lastDistance;
  public Circle(float x_, float y_, float r_, float[] col_){
    x = x_;
    y = y_;
    r = r_;
    hue = col_[0];
    sat = col_[1];
    bri = col_[2];
    col = color(hue, sat, bri);
  }
  
  void display(Circle[] near){
    noStroke();
    color c = lerpColor(near[0].col, near[1].col, .5);
    c = lerpColor(c, near[2].col, .5);
    fill(c);
    beginShape();
    for(int i = 0; i < NUMSIDES; i++){
      vertex(near[i].x, near[i].y);
    }
    endShape(TRIANGLE_STRIP);
  }
}
