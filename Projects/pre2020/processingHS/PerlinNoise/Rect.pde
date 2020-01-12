public class Walker{
  
  float lastX, lastY;
  float x;
  float y;
  color theColor;
  float myTimeX, myTimeY;

  public Walker(color color_){
   x = noise(myTimeX);
   y = noise(myTimeY);
   lastX = x;
   lastY = y;
   theColor = color_;
   
   myTimeX = random(-1000, 1000);
   myTimeY = random(-1000, 1000);
  }
  
  void walk(float time){

    x = noise(time + myTimeX);
    x = map(x, 0, 1, 0, width);
    y = noise(time + myTimeY);
    y = map(y, 0, 1, 0, height);
  }
  
  void display(){
    stroke(theColor);
    fill(theColor);
    //line(lastX, lastY, x, y);
    ellipse(x, y, 1, 1);
    lastX = x;
    lastY = y;
  }
}