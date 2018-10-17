public class Circle{
  float r;
  PVector pos;
  color col;
  float lastA;
  
  public Circle(PVector pos_, float r_, color col_){
    pos = pos_;
    r = r_;
    col = col_;
    lastA = random(TWO_PI);
  }
  
  public Circle(PVector pos_, float r_, float a){
    pos = pos_;
    r = r_;
    lastA = a;
  }
  
  void display(){
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, r * 2,r * 2);
  }
}
