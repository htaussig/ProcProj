public class Walker{
  
  private float stepSize = 3;
  
  float x;
  float y;
  color theColor;

  public Walker(color color_){
   x = random(width);
   y = random(height);
   theColor = color_;
  }
  
  void walk(){

    x += random(-1, 1) * stepSize;
    y += random(-1, 1) * stepSize;
    
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);

  }
  
  void display(){
    stroke(theColor);
    fill(theColor);
    rect(x, y, 1, 1);
  }
}