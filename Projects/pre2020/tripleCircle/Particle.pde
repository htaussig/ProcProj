int MAXHEALTH = 36;
float PARTICLESIZE = 3.8;
float PARTVELMAG = .1;

public class Particle{
  PVector pos;
  PVector vel;
  
  int health;
  
  public Particle(float x, float y, PVector lastVel){
    pos = new PVector(x, y);
    
    //pushing particles opposite direction of the flyer
    lastVel.mult(-.1);
    vel = PVector.fromAngle(random(TWO_PI)).setMag(PARTVELMAG);
    vel.add(lastVel);
    
    health = MAXHEALTH;
  }
  
  boolean update(){
    if(health == 0){
      return true;
    }
    
    //add a little boost to particles the opposite way of the flyer
    pos.add(vel);
    
    health--;
    return false;
  }
  
  void display(){
    noStroke();
    float colNum = (health / (float) MAXHEALTH) * 255;
    float colNum2 = map(colNum, 0, 255, 100, 255);
    fill(colNum2, colNum);
    ellipse(pos.x, pos.y, PARTICLESIZE, PARTICLESIZE);
  }
}
