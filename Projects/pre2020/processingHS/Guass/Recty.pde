public class Recty{
  
  float x, y;
  float w, h;
  
  public Recty(float x_, float y_, float w_, float h_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  public void display(){
    stroke(55, 95, 135);
    rect(x, y - h, w, h);
  }
  
  public void increaseHeight(int increase){
    h += increase;
  }
}