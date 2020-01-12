// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A circular particle

class Bullet extends Displayable{

  //private float margin;
  
  // We need to keep track of a Body and a radius
  //Body body;
  float r;

  Bullet(float x, float y, Vec2 linearVelocity, float r_) {
    r = r_;
    // This function puts the particle in the Box2d world
    makeBody(x,y,r);
    
    body.setUserData(this);
    
    body.setLinearVelocity(linearVelocity);
    
    margin = r;
  }

  void applyForceCenter(Vec2 force){
    Vec2 pos = body.getWorldCenter();
     body.applyForce(force, pos);
  }


  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    //float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    stroke(0);
    fill(146, 66, 244);
    ellipse(0,0,r*2,r*2);
    //line(0,0,r,0);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.4;
    fd.restitution = 1;
    
    // Attach fixture to body
    body.createFixture(fd);

    //body.setAngularVelocity(random(-10,10));
  }
}