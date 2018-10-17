public class TAsteroid extends Asteroid{
 
  //Body body;
  
  float w;  //w must = h at this point
  float h;
  float x,y;
  //boolean isDynamic;
  
  public TAsteroid(float x_, float y_, float size_, Vec2 linearForce, float angularVelocity){
    margin = size_ / 2;
    
    size = size_;
    
    x = x_;
    y = y_;
    
    w = size_;
    h = size_;
   
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
    
    fd.density = .8;
    fd.friction = 0.6;
    fd.restitution = 1;
    
    body.createFixture(fd);

    //second box
    PolygonShape ps2 = new PolygonShape();
    box2dW = box2d.scalarPixelsToWorld(h /(2));
    box2dH = box2d.scalarPixelsToWorld(w / (2 * 3));
    ps2.setAsBox(box2dW, box2dH);
    
    FixtureDef fd2 = new FixtureDef();
    fd2.shape = ps2;
    
    fd2.density = .8;
    fd2.friction = 0.6;
    fd2.restitution = 1;
    
    body.createFixture(fd2);
    
    applyForceCenter(linearForce);
    body.setAngularVelocity(angularVelocity);
      
    initialize();
  }
  
  public void display(){ 
    
    stroke(0);
    fill(r, g, b); 
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    
    drawTAsteroid();
    
    popMatrix();
    
    if(healthBar.isDamaged()){
      healthBar.display(pos.x, pos.y);
    }
        
  }
  
  void drawTAsteroid(){
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

}