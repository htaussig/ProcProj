public class TriAsteroid extends Asteroid{
  
  float x, y;
  
  Vec2[] vertices;
  
  //private float margin;
  
  public TriAsteroid(float x_, float y_, float size_, Vec2 linearForce, float angularVelocity){    
    x = x_;
    y = y_;
    size = size_ - 4; //Triasteroids were too big compared to Tasteroid

    margin = size * 2.5;

    makeAsteroidBody(linearForce, angularVelocity);

    initialize();
  }
  
  void makeAsteroidBody(Vec2 linearForce, float angularVelocity){
    PolygonShape shapeDefinition = new PolygonShape();
    FixtureDef fd = new FixtureDef();
      
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);
    
    vertices = new Vec2[3];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-1 * size, 0));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(1 * size, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(0, -2.5 * size)); 
    
    shapeDefinition.set(vertices, vertices.length);
    
    fd.shape = shapeDefinition;
    
    // Parameters that affect physics
    fd.density = .8;
    fd.friction = 0.6;
    fd.restitution = 1;
    
    body.createFixture(fd);
    
    applyForceCenter(linearForce);
    body.setAngularVelocity(angularVelocity);
  }
  
  float getCentroidX(){
    return 0;
  }
  
  float getCentroidY(){
    return -2.5 * size / 3;
  }
  
  void display(){
    stroke(0);
    fill(r, g, b); 
   
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    
    drawTriangle();   
    popMatrix();
    
    if(healthBar.isDamaged()){
      pos = box2d.coordWorldToPixels(body.getWorldCenter()); 
      healthBar.display(pos.x, pos.y);
    }
 
  }
  
  void drawTriangle(){
   beginShape();
   
   vertex(-1 * size, 0);
   vertex(1 * size, 0);
   vertex(0, -2.5 * size);
   
   endShape(CLOSE);
  }
  
  
}