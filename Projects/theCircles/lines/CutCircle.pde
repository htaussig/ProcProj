public class Circle{
  float x, y, r;
  public Circle(float x_, float y_, float r_){
    x = x_;
    y = y_;
    r = r_;
  }
  
  void display(){
    ellipse(x,y,r * 2,r * 2);
  }
}
