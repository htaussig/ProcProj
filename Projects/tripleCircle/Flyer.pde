float FLYERVEL = 3.2;
int NUMPARTICLES = 100;

public class Flyer{
  Point curPoint;
  Point nextPoint;
  
  boolean isFlying;
  
  int waiting;
  
  PVector pos; 
  
  PVector lastVel;
  
  ArrayList<Particle> parts;
  
  public Flyer(Point p){
    curPoint = p;
    isFlying = false;
    nextPoint = null;
    waiting = 0;
    
    //don't want these two vectors to be connect
    pos = new PVector(p.pos.x, p.pos.y);
    
    parts = new ArrayList<Particle>();
  }
  
  void findNextPoint(){
    waiting = 0;
    nextPoint = findNextPointForFlyer(this);
    if(nextPoint != null){
      isFlying = true;
      pos.x = curPoint.pos.x;
      pos.y = curPoint.pos.y;
    }
  }
  
  void fly(){
    PVector path = PVector.sub(nextPoint.pos, pos);
    
    path.setMag(FLYERVEL); 
    lastVel = path;
    pos.add(path);
    
    checkIfArrived();
    
    if(isFlying){
       genParticle();
    }
       
  }
  
  void updateParticles(){    
    for(int i = parts.size() -1; i >= 0; i--){
      Particle p = parts.get(i);
      if(p.update()){
        parts.remove(p);
      }
    }
  }
  
  void checkIfArrived(){
    if(PVector.dist(pos, nextPoint.pos) < 3){
      arrived();
    }
  }
  
  //what to do when the flyer gets to it's next point
  void arrived(){
    curPoint = nextPoint;
    nextPoint = null;
    
    //waiting should be 0
    isFlying = false;
  }
  
  void genParticle(){
    for(int i = 0; i < 4; i++){
       parts.add(new Particle(pos.x, pos.y, lastVel));
    }
  }
  
  void update(){
    if(isFlying){
      fly();
    }
    else{
      if(waiting == 60){
        parts.clear();
        findNextPoint();
      }
      else{
        waiting++;
      }
    }
    updateParticles();
  }
  
  void display(){
    noStroke();
    fill(255);
    
    for(int i = parts.size() -1; i >= 0; i--){
      Particle p = parts.get(i);
      p.display();
    }
  }
  
  void display(Circle c){
    noStroke();
    fill(255);
    
    for(int i = parts.size() -1; i >= 0; i--){
      Particle p = parts.get(i);
      
      float dist = PVector.dist(p.pos, c.pos);
      
      if(dist < c.getRadius()){
         p.display();
      }
    }
  }
  
}
