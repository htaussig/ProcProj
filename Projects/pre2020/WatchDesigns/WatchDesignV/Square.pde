public class Square{
  
 float x, y, size, val;
  public Square(float x_, float y_, float size_, float val_){
    x = x_;
    y = y_;
    size = size_;
    val = val_;
  }
  
  public void display(){
    pushMatrix();
    translate(x, y);
    fill(255);
    if(val < 123){
      line(0, 0, size, size);
    }
    else{
      line(0, size, size, 0);
    }
    popMatrix();
  }
}
