class Pendulum implements Displayable{
  
  Particle p1;
  Particle p2;
  Boundary boundary;
  
  private float MARGIN;
  
  // We need to keep track of a Body and a radius
  float r;
  
  float len;


  public Pendulum(float x, float y, float r_) {
    r = r_;
    len = 90;
    // This function puts the particle in the Box2d world
    
    boundary = new Boundary(x, y + r);
    p1 = new Particle(x, y, r * 1.5);
    p2 = new Particle(x + random(-5, 5), y + random(-5, 5), r);
    
    DistanceJointDef djd1 = new DistanceJointDef();
    
    djd1.bodyA = boundary.body;
    djd1.bodyB = p1.body;
    
    djd1.length = box2d.scalarPixelsToWorld(len);
    
    djd1.frequencyHz = 0;
    djd1.dampingRatio = 1;
    
    DistanceJoint dj1 = (DistanceJoint) box2d.world.createJoint(djd1);
    
    //the joint between the two points
    DistanceJointDef djd = new DistanceJointDef();
    
    djd.bodyA = p1.body;
    djd.bodyB = p2.body;
    
    djd.length = box2d.scalarPixelsToWorld(len * 2 / 3);
    
    djd.frequencyHz = 0;
    djd.dampingRatio = 1;
    
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
    Vec2 bPos = box2d.getBodyPixelCoord(boundary.body);
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    
    boundary.display();
    p1.display();
    p2.display();
    
    stroke(0);
    line(bPos.x, bPos.y, pos1.x, pos1.y);
    line(pos1.x, pos1.y, pos2.x, pos2.y); 
  }
}
  