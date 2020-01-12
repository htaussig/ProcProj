public class Circle{
  float x, y, r;
  float hue, sat, bri;
  public Circle(float x_, float y_, float r_, float[] col_){
    x = x_;
    y = y_;
    r = r_;
    hue = col_[0];
    sat = col_[1];
    bri = col_[2];
  }
  
  void display(){
    point(x, y);
    for(int i = 1; i < r; i += 1){
      //strokeWeight(2);
      noStroke();
      float opacity = 100 * (i / r) / 12.0;
      opacity = min(opacity, 100);
      opacity = max(opacity, 0);
      //stroke(color(hue, sat, bri, opacity));
      fill(color(hue, sat, bri, opacity));
      float drawR = i * 5;
      ellipse(x,y, drawR, drawR);
    }
    
  }
}
