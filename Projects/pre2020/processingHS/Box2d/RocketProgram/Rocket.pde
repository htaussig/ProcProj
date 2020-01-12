public class Rocket extends Displayable{
  
  private static final int RIGHT = -1;
  private static final int LEFT = 1;
  
  Vec2[] vertices;
  
  private float backThrustForce;
  private float sideThrustForce;
  
  private boolean leftThrusting, rightThrusting, backThrusting = false;
  
  ArrayList<Fixture> fixtureList;
  
  float x, y, size;
  
  HealthBar healthBar = new HealthBar(120, 20, 1000);
  
  color rocketColor = color(146, 66, 244);
  
  public Rocket(float x_, float y_, float size_){
    
    x = x_;
    y = y_;
    size = size_;
    
    backThrustForce = 30 * size;
    sideThrustForce = backThrustForce / 24;

    makeRocketBody();
    
    body.setUserData(this);
    
    margin = size * 2.5;

  }
  
  void makeRocketBody(){
    PolygonShape sd = new PolygonShape();
    
    vertices = new Vec2[3];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-1 * size, 0));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(1 * size, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(0, -2.5 * size));
    
    sd.set(vertices, vertices.length);
    
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);
    
    body.createFixture(sd, 1.0);
  }
  
  void applyForceCenter(Vec2 force){
   Vec2 pos = body.getWorldCenter();
   body.applyForce(force, pos);
  }
  
  void applyForce(Vec2 force, Vec2 pos){
    body.applyForce(force, pos);
  }
  
  void backThrust(){
    float a = body.getAngle() + PI / 2;
    Vec2 thrust = box2d.coordPixelsToWorld((float) (x + (Math.cos(-a) * backThrustForce)), (float) (y + (Math.sin(-a) * backThrustForce)));
    
    applyForceCenter(thrust);
    
    backThrusting = true;
  }
  
  void sideThrust(int side){   //1 == left, -1 == right
    /*float a = body.getAngle() + PI / 2;
    if(side == RIGHT || side == LEFT){
     a += side * PI / 2; 
    }
    else{
      System.out.println("invalid side entered for sideThrust()");
     return; 
    }
    Vec2 thrust = box2d.coordPixelsToWorld((float) (x + (Math.cos(-a) * sideThrustForce)), (float) (y + (Math.sin(-a) * sideThrustForce)));
    
    Vec2 pos = new Vec2(0, 0);
    
    
    a = body.getAngle();
    
    pos = 
    
    applyForce(thrust, pos);*/
    
    body.applyTorque(sideThrustForce * side);
    
    if(side == 1){
     rightThrusting = true;
    }
    else{
     leftThrusting = true; 
    }
  }
  
  void collide(float impulse){
    healthBar.takeDamage(impulse);
    
    if(healthBar.getHealth() <= 0){
     explode(); 
    }
  }
  
  void explode(){
    rocketColor = color(0);
    System.out.println("rocket go boom boom");
  }
  
  void display(){
    stroke(0);
    fill(rocketColor); 
   
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    
    drawTriangle(size);
    
    noFill();
    stroke(255);
    
    translate(0, -size / 3);
    drawTriangle(size * 1 / 2);   
    popMatrix();
    
    
    if(backThrusting){
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(-a + PI);
      
      stroke(242, 14, 29);
      fill(244, 143, 66);
      
      drawTriangle(size / 2);
      popMatrix();
    }
    
    healthBar.display(70, 50);
    
    resetThrusts();
  }
  
  void resetThrusts(){
   leftThrusting = false;
   rightThrusting = false;
   backThrusting = false; 
  }
  
  void drawTriangle(float theSize){
   beginShape();
   
   vertex(-1 * theSize, 0);
   vertex(1 * theSize, 0);
   vertex(0, -2.5 * theSize);
   
   endShape(CLOSE);
  }
  
  boolean isDead(){
   return healthBar.getHealth() == 0;   
  }
  
  float getTipX(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle() + PI / 2;
    return pos.x + ((float) Math.cos(-a) * size * 2.5);
  }
  
  float getTipY(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle() + PI / 2;
    return pos.y + ((float) Math.sin(-a) * size * 2.5);
  }
  
  Vec2 getLinearVelocity(){
   return body.getLinearVelocity(); 
  }
}