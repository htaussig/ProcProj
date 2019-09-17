//effectively a planet (a point with gravity)
public class Point{
  PVector pos;
  PVector vel;
  PVector acc; 
  
  float mass;
  
  //current angle
  float angle;
  //angular velocity
  float rotateV;
  
  
  Point(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    rotateV = 0;
    
    mass = 1;
  }
  
  float getX(){
    return pos.x;
  }
  
  float getY(){
    return pos.y;
  }
  
  void applyForce(PVector f){
    f.mult(1 / mass);
    acc.add(f);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    
    acc.mult(0);
    
    angle += rotateV;
  }
  
  void display(){
    noStroke();
    strokeWeight(2);
    stroke(255);
    fill(255);
    //ellipse(pos.x, pos.y, 10, 10);
    point(pos.x, pos.y);
  }
}