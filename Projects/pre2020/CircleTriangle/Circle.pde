public class Circle{
  float x, y, d;
  color col;
  
  public Circle(float x_, float y_, float d_, color col_){
    x = x_;
    y = y_;
    d = d_;
    col = col_;
  }
  
  void display(){
    fill(col);
    ellipse(x, y, d, d);
  }
}
