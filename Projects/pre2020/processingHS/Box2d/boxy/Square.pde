public class Square implements Displayable{
 
  Body body;
  
  float w;
  float h;
  float x,y;
  boolean isDynamic;
  
  public Square(float theX, float theY){
    x = theX;
    y = theY;
    
    w = random(3, 8);
    h = random(3, 8);
   
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
    
    fd.density = 1.5;
    fd.friction = 0.02;
    fd.restitution = 0.6;
    
    body.createFixture(fd);
    
  }
  
  public void display(){ 
    
    stroke(39, 9, 237);
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
}