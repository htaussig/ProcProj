public class Car extends Displayable{
  
  RevoluteJoint joint1;
  RevoluteJoint joint2;
  Box carBox;
  Particle wheel1;
  Particle wheel2;
  
  public Car(float x, float y, int size){
    
    carBox = new Box(x, y, size, size / 2);
    wheel1 = new Particle(x - (size / 3), y + (size / 4), size / 6);
    wheel2 = new Particle(x + (size / 3), y + (size / 4), size / 6);
    
    RevoluteJointDef rjd = new RevoluteJointDef();
    
    rjd.initialize(carBox.body, wheel1.body, wheel1.body.getWorldCenter());
    
    rjd.motorSpeed = PI*2 * 8;
    rjd.maxMotorTorque = 2000.0;
    rjd.enableMotor = false;
    
    joint1 = (RevoluteJoint) box2d.world.createJoint(rjd);
    
    
    rjd.initialize(carBox.body, wheel2.body, wheel2.body.getWorldCenter());
    
    
    
    joint2 = (RevoluteJoint) box2d.world.createJoint(rjd);
  }
  
  public void toggleMotor(){
   joint1.enableMotor(!joint1.isMotorEnabled()); 
   joint2.enableMotor(!joint2.isMotorEnabled()); 
  }
  
  
  public void display(){
    carBox.display();
    wheel1.display();
    wheel2.display();
  }
  
  public boolean done(){
    return false;
  }
}