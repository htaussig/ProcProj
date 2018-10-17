public class Circle{
 
  float x, y, r;
  color col;
  
  public Circle(float x_ , float y_ , float r_, color col_){
    x = x_;
    y = y_;
    r = r_;
    col = col_;
  }
  
  void display(){
    fill(col);
    ellipse(x, y, r, r);
  }
  
  void display(float xAdd){
    fill(col);
    ellipse(x + xAdd, y, r, r);
  }
  
  float getX(){
   return x; 
  }
  
  float getY(){
   return y; 
  }
}