public class TShape implements Displayable{
 
  private float MARGIN;
  
  Body body;
  
  float w;  //w must = h at this point
  float h;
  float x,y;
  //boolean isDynamic;
  
  public TShape(float theX, float theY, float theW, float theH){
    x = theX;
    y = theY;
    
    w = theW;
    h = theH;
   
    BodyDef bd = new BodyDef();
    
    bd.type = BodyType.DYNAMIC;
    
    
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    
    //first box
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/ (2 * 3));
    float box2dH = box2d.scalarPixelsToWorld(h / (2));
    ps.setAsBox(box2dW, box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    
    fd.density = 1.5;
    fd.friction = 0.3;
    fd.restitution = 0.6;
    
    body.createFixture(fd);
    
    
    //second box
    PolygonShape ps2 = new PolygonShape();
    box2dW = box2d.scalarPixelsToWorld(h /(2));
    box2dH = box2d.scalarPixelsToWorld(w / (2 * 3));
    ps2.setAsBox(box2dW, box2dH);
    
    FixtureDef fd2 = new FixtureDef();
    fd2.shape = ps2;
    
    fd2.density = 1.5;
    fd2.friction = 0.3;
    fd2.restitution = 0.6;
    
    body.createFixture(fd2);
    
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
    
    drawTShape();
    
    popMatrix();
    
  }
  
  void drawTShape(){
   beginShape();
   
   vertex(-w / 6, h / 2);
   vertex(-w / 6, h / 6);
   vertex(-w / 2, h / 6);
   vertex(-w / 2, -h / 6);
   vertex(-w / 6, -h / 6);
   vertex(-w / 6, -h / 2);
   vertex(w / 6, -h / 2);
   vertex(w / 6, -h / 6);
   vertex(w / 2, -h / 6);
   vertex(w / 2, h / 6);
   vertex(w / 6, h / 6);
   vertex(w / 6, h / 2);
   
   
   endShape(CLOSE);
   
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