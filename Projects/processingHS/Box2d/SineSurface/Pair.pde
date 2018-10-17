class Pair implements Displayable{

  Particle p1;
  Particle p2;
  
  private float MARGIN;
  
  // We need to keep track of a Body and a radius
  float r;
  
  float len;


  public Pair(float x, float y, float r_) {
    r = r_;
    len = 32;
    // This function puts the particle in the Box2d world
    p1 = new Particle(x, y, r);
    p2 = new Particle(x + random(-5, 5), y + random(-5, 5), r);
    
    DistanceJointDef djd = new DistanceJointDef();
    
    djd.bodyA =  p1.body;
    djd.bodyB = p2.body;
    
    djd.length = box2d.scalarPixelsToWorld(len);
    
    djd.frequencyHz = 3;
    djd.dampingRatio = 0.1;
    
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
    
    MARGIN = r;
  }
  
  
  // This function removes the particle from the box2d world
  void killBody() {
    p1.killBody();
    p2.killBody();
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    /*Vec2 pos = box2d.getBodyPixelCoord();
    // Is it off the bottom of the screen?
    if (pos.x < -MARGIN || pos.x > width + MARGIN) {
      killBody();
      return true;
    }
    return false;*/
    return false;
  }
  
  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    
    p1.display();
    p2.display();
    
    stroke(0);
    line(pos1.x, pos1.y, pos2.x, pos2.y); 
  }
}