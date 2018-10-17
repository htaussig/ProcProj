public class Box implements Displayable{
 
  private float MARGIN;
  
  Body body;
  
  float w;
  float h;
  float x,y;
  //boolean isDynamic;
  
  public Box(float theX, float theY, float theW, float theH){
    x = theX;
    y = theY;
    
    w = theW;
    h = theH;
   
    BodyDef bd = new BodyDef();
    
    bd.type = BodyType.DYNAMIC;
    
    
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h / 2);
    ps.setAsBox(box2dW, box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 1;
    
    body.createFixture(fd);
    
    MARGIN = w * 2;
  }
  
  public void display(){ 
    
    stroke(0);
    fill(146, 66, 244); 
   
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
    
  }
  
  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.x < -MARGIN || pos.x > width + MARGIN) {
      killBody();
      return true;
    }
    return false;
  }
}