public abstract class Truck extends Car{
  
  public Truck(float x_, float y_, float vx_, float vy_){
    super(x_, y_, vx_, vy_);
    
  }
   
   
  
  public void display(){
    stroke(0);
    strokeWeight(truckSize);
    point(x, y);
  }
}
