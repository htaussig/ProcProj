public class Square{
  float x, y, w, h;
  float angle;
  color col;
  public Square(float x_, float y_, float w_, float h_, color col_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;  
    angle = 0;
    col = col_;
  }
  
  void display(){
    pushMatrix();
    translate(x + w / 2, y + h / 2);
    rotate(angle);
    fill(col);
    noStroke();
    rect(-w/2, -h/2, w, h);
    popMatrix();
  }
  
}
