public class HealthBar{
  
  float w, h, currentHealth, maxHealth;
  color healthColor = color(67, 255, 61);
  
  public HealthBar(float w_, float h_, float currentHealth_, float maxHealth_){
    w = w_;
    h = h_;
    currentHealth = currentHealth_;
    maxHealth = maxHealth_;
  }
  
  public HealthBar(float w_, float h_, float currentHealth_){
    this(w_, h_, currentHealth_, currentHealth_);
  }
  
  public void takeDamage(float damage){
    currentHealth -= damage;
    if(currentHealth < 0){
      currentHealth = 0;
    }
  }
  
  public float getHealth(){
   return currentHealth; 
  }
  
  public boolean isDamaged(){
   return currentHealth != maxHealth; 
  }
  
  public void display(float x, float y){ //x and y are center coordinatess
    x -= w / 2;
    y -= h / 2;
    stroke(0);
    noFill();
    rect(x, y, w, h);
    
    //noStroke();
    fill(healthColor);
    pushMatrix();
    float width = w * currentHealth / maxHealth;
    rect(x, y, width, h);
    popMatrix();
  }
  
}