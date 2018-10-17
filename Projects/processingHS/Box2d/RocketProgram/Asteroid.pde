public abstract class Asteroid extends Displayable{
  
  public abstract void display();
  
  public float r, g, b;
  float size;
  
  public HealthBar healthBar;
  
  void setRandomColor(){
    r = random(255);
    g = random(255);
    b = random(255);
  }
  
  public void collide(float impulse){
    healthBar.takeDamage(impulse);
  }
  
  public float getSize(){
   return size; 
  }
  
  public boolean isDead(){
   return healthBar.getHealth() == 0; 
  }
  
  void applyForceCenter(Vec2 force){
   Vec2 pos = body.getWorldCenter();
   body.applyForce(force, pos);
  }
  
  void initialize(){
    if(this instanceof TAsteroid){
      healthBar = new HealthBar(size, size / 4, (size * size * 2.5 / 2) / 1.8); //TAsteroids were not taking enough damage
    }
    else{
      healthBar = new HealthBar(size, size / 4, size * size * 2.5 / 2);
    }
    setRandomColor();
    body.setUserData(this);
  }
}