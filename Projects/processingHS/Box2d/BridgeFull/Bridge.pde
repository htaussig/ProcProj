public class Bridge extends Displayable{
  
  private int len;
  
  private int y;
  private int r;
  
  private ArrayList<Displayable> particles;

  
  public Bridge(int y_, int r_){
    
    
    y = y_;
    r = r_;
    
    len = r * 2;
    
    particles = new ArrayList<Displayable>();
    
    Boundary bound1 = new Boundary(0, y);
    particles.add(bound1);
    
    Particle p2 = new Particle(r * 2, y, r);
    particles.add(p2);
    
    Body b1 = bound1.body;
    Body b2;
    
    createJoint(b1, p2.body);
    
    for(int i = 1; i < width / (r * 2); i++){
      int x = r * 2 * i;
      
      b1 = p2.body;
      
      p2 = new Particle(x, y, r);      
      particles.add(p2);
      
      createJoint(b1, p2.body);
      
    }
    
    int x = width;
    
    b1 = p2.body;
      
    bound1 = new Boundary(x, y);      
    particles.add(bound1);
    
    createJoint(b1, bound1.body);
    
  }
  
  void createJoint(Body b1, Body b2){
    DistanceJointDef djd = new DistanceJointDef();
      djd.bodyA = b1;
      djd.bodyB = b2;
      
      djd.length = box2d.scalarPixelsToWorld(len);
      
      djd.frequencyHz = 0;
      djd.dampingRatio = 1;
      
      DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  }
  
  void display(){
    for(Displayable particle: particles){
      particle.display();
    }
  }
  
  boolean done(){
   return false; 
  }
}