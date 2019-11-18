public class Car implements Vehicle{
  
  float x, y, vx, vy;
  
  public Car(float x_, float y_, float vx_, float vy_){
    x = x_;
    y= y_;
    
    vx = vx_;
    vy = vy_;
  }
  
  public void move(){
    x += vx;
    y += vy;
  }
  
  public void display(){
    stroke(0);
    strokeWeight(carSize);
    point(x, y);
  }
}
