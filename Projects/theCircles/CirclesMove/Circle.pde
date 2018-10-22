float MAXSPEED = .2;

public class Circle {
  float r;
  PVector pos;
  PVector vel;
  PVector acc;
  color col;

  public Circle(PVector pos_, float r_) {
    this(pos_, r_, color(0));
  }

  public Circle(PVector pos_, float r_, color col_) {
    pos = pos_;
    r = r_;
    col = col_;
    //vel = PVector.fromAngle(PI);
    vel = new PVector();
    acc = new PVector(0, 0);
  }

  public void setColor(color col_){
   col = col_; 
  }

  public void update() {
    vel.add(acc);
    vel.limit(MAXSPEED);
    pos.add(vel);
    acc.mult(0);
  }

  public void applyForce(PVector force) {
    //f = m / a
    acc.add(force.mult(1 / r));
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
}
