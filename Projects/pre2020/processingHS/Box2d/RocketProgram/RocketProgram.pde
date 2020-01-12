import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;


private static final int RIGHTTHRUST = -1;
 private static final int LEFTTHRUST = 1;
 private static final float DEFAULTMAXSIZE = 50;

private int shotForce = 2450;
private int bulletDamage = 12; //number of times more damage bullets do to asteroids
private int bulletSize = 3;

int currentShape = BOX;

float asteroidForceLow = 25000;
float asteroidForceHigh = 75000;

float asteroidAngularVMax = 6;
float minAsteroidSize = 10;

private int framesPerAsteroid = 200;

Box2DProcessing box2d;

Rocket rocket;

private boolean leftThrusting, rightThrusting, backThrusting, shooting = false;
private int score;

private int shotNumber = 0;

ArrayList<Displayable> displayThings;

void setup(){
  size(800, 800);
  frameRate(60);
 
  displayThings = new ArrayList<Displayable>();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(0,0));
  
  rocket = new Rocket(width / 2, height / 2, 15);
  displayThings.add(rocket);
  
  box2d.listenForCollisions();
}

void draw(){
 
  background(255);
  
  if(frameCount % framesPerAsteroid == 1){
    spawnAsteroid();
  }
  if(frameCount % 80 == 0){
    if(framesPerAsteroid > 30){
      framesPerAsteroid -= 2;
    }
  }
  
  engageThrusters();
  checkShoot();
  
  
  box2d.step();
  
  displayAndCheckStuff(); 
  checkRocket();
  
  noStroke();
  fill(0);
  textSize(26);
  text("Score: " + score + "", 10, 30);
}

void displayAndCheckStuff(){
 for(int i = displayThings.size() - 1; i >= 0; i--){
    
   Displayable thing = displayThings.get(i);
    
   thing.display(); 
   
   if(thing.done()){
      displayThings.remove(i); 
      if(thing == rocket){
       gameOver(); 
      }
   }
   if(thing instanceof Asteroid){
        Asteroid asteroid = (Asteroid) thing;
        if(asteroid.isDead()){
          explode(asteroid);
          score++;
        }  
   }
  }  
}

void checkRocket(){
  if(rocket.isDead()){
   rocket.explode();
   gameOver();
  }
}

void explode(Asteroid asteroid){
  Vec2 pos = box2d.coordWorldToPixels(asteroid.body.getWorldCenter()); 
  float size = asteroid.getSize();
  
  displayThings.remove(asteroid);
  asteroid.killBody();
   
  //size *= 2 / 3;
  
  if(size >= minAsteroidSize + 4){
    Vec2 linearVelocity = asteroid.body.getLinearVelocity();
    addRandomAsteroid(pos.x, pos.y, new Vec2(0, 0), linearVelocity, random(-6, 6), size);
    addRandomAsteroid(pos.x, pos.y, new Vec2(0, 0), linearVelocity, random(-6, 6), size);
  }
}

void checkShoot(){
  //3 shots a second
  if(shooting && shotNumber++ % (8) == 0){ 
    shoot();
  }
  
}

void shoot(){  
  float a = rocket.body.getAngle() + PI / 2;
  
  float bulletX = rocket.getTipX() + ((float) Math.cos(-a) * bulletSize);
  float bulletY = rocket.getTipY() + ((float) Math.sin(-a) * bulletSize);
  
  //added a method in Rocket for this
  Vec2 linearVelocity = rocket.getLinearVelocity();
  
  Bullet bullet = new Bullet(bulletX, bulletY, linearVelocity, bulletSize);
  displayThings.add(bullet);
  
  
  Vec2 pos = box2d.getBodyPixelCoord(rocket.body);
  
  Vec2 force = box2d.coordPixelsToWorld((float) (pos.x + (Math.cos(-a) * shotForce)), (float) (pos.y + (Math.sin(-a) * shotForce))); 
  //equal and opposite forces (especially since we are in space) now bullets can be used as a tool to slow down
  bullet.applyForceCenter(force); 
  rocket.applyForceCenter(force.mul(-1));
}

void spawnAsteroid(){
  int asteroidAxis = (int) random(2);
  
  float x, y;
  float vX = 0, vY = 0;
  
  if(asteroidAxis == 0){
    x = ((int) random(2)) * width;
    y = random(height);
    
    vX = random(asteroidForceLow, asteroidForceHigh);
    if(x == width){
     vX *= -1; 
    }
    
    float yOffSet = y - (height / 2);
    
    vY = ((yOffSet) / (height / 2)) * random(0, asteroidForceHigh);
    
  }
  else{
    x = random(width);
    y = ((int) random(2)) * height;
    
    vY = random(asteroidForceLow, asteroidForceHigh);
    if(y == 0){
      vY *= -1;
    }
    
    float xOffSet = x - (width / 2);
    
    vX = ((-xOffSet) / (width / 2)) * random(0, asteroidForceHigh);
  }
  
  
  Vec2 linearForce = box2d.coordPixelsToWorld((vX), (-vY)); 
  addRandomAsteroid(x, y, linearForce, random(-asteroidAngularVMax, asteroidAngularVMax));
  //displayThings.add(new TriAsteroid(x, y, random(10, 40), linearVelocity));
}

void addRandomAsteroid(float x, float y, Vec2 linearForce, Vec2 linearVelocity, float angularVelocity, float maxSize){
  int asteroidNum = (int) random(2);
  Asteroid asteroid;
  
  if(asteroidNum == 0){
    float size = random(minAsteroidSize, maxSize * 4 / 5);
    asteroid = new TriAsteroid(x, y, size, linearForce.mul(size / 32), angularVelocity);
  }
  else{
    float size = random(minAsteroidSize, maxSize);
    asteroid = new TAsteroid(x, y, size, linearForce.mul(size / 40), angularVelocity); 
  }
  asteroid.body.setLinearVelocity(linearVelocity);
  displayThings.add(asteroid);
}

void addRandomAsteroid(float x, float y, Vec2 linearForce, float angularVelocity){
  addRandomAsteroid(x, y, linearForce, new Vec2(0,0), angularVelocity, DEFAULTMAXSIZE);
}

void gameOver(){
  stop();
}

void engageThrusters(){
  if(backThrusting){
    rocket.backThrust();
  }
  if(rightThrusting){
    rocket.sideThrust(RIGHTTHRUST);
  }
  if(leftThrusting){
    rocket.sideThrust(LEFTTHRUST);
  }
}

//Collision event code
void beginContact(Contact cp){
  
}

void postSolve(Contact cp, ContactImpulse impulse) {
  float[] normalImps = impulse.normalImpulses; 
  //float[] tangentImps = impulse.tangentImpulses; 

  float normalSum = 0;
  for(float num : normalImps){
    normalSum += num;
  }

  float impactStrength = normalSum;

  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(o1 instanceof Asteroid){
    if(o2 instanceof Bullet){
      impactStrength *= bulletDamage;
    }
    ((Asteroid) o1).collide(impactStrength);
  }
  if(o2 instanceof Asteroid){ 
    if(o1 instanceof Bullet){
      impactStrength *= bulletDamage;
    }
    ((Asteroid) o2).collide(impactStrength);
  }
  if(o1 instanceof Rocket && !(o2 instanceof Bullet)){
    ((Rocket) o1).collide(impactStrength);
  }
  if(o2 instanceof Rocket && !(o1 instanceof Bullet)){ 
    ((Rocket) o2).collide(impactStrength);
  }

}

void endContact(Contact cp){
  
}

void mouseAction(){
  if(mouseButton == RIGHT){
    displayThings.add(new Boundary(mouseX, mouseY)); 
  }
  else if(mouseButton == LEFT){
    
  }
  
}

void mousePressed(){
  mouseAction();
}

void mouseDragged(){
  mouseAction();
}

void keyPressed(){
  if(key == 'w'){
    backThrusting = true;
  }
  if(key == 'a'){
   leftThrusting = true; 
  }
  if(key == 'd'){
   rightThrusting = true; 
  }
  if(key == ' '){
    shooting = true;
  }
}

void keyReleased(){
  if(key == 'w'){
    backThrusting = false;
  }
  if(key == 'a'){
   leftThrusting = false; 
  }
  if(key == 'd'){
   rightThrusting = false;   
  } 
  if(key == ' '){
   shooting = false;
   shotNumber = 0; 
  }
}