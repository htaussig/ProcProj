public class Square{
  
 float x, y, size, val;
  public Square(float x_, float y_, float size_, float val_){
    x = x_;
    y = y_;
    size = size_;
    val = val_;
  }
  
  int sWidth = 5;
  
  public void display(){
    pushMatrix();
    translate(x, y);
    fill(255);
    stroke(255);
    strokeWeight(7);
    rectMode(CENTER);
    if(val < 123){
      line(0, 0, size, size);
      translate(size, size);
      noStroke();
      rotate(radians(45));
      //rect(0, 0, sWidth, sWidth);
      rect(0, 0, sWidth, sWidth);
    }
    else{
      line(0, size, size, 0);
    }
    popMatrix();
  }
}
