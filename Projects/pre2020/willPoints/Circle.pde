public class Circle{
  float x, y, r;
  color col;
  public Circle(float x_, float y_, float r_, color col_){
    x = x_;
    y = y_;
    r = r_;
    col = col_;
  }
  
  void display(){
    fill(col);
    noStroke();
    ellipse(x,y,r * 2,r * 2);
  }
}
