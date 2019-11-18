public class MonsterTruck extends Truck{
  
  public MonsterTruck(float x_, float y_, float vx_, float vy_){
    super(x_, y_, vx_, vy_);
    
  }
  
  public void move(){
    super.move();
    x += random(-2, 2);
    y += random(-2, 2);
  }
}
