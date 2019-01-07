float MAXSPEED = .4;

public class Circle {
  float r;
  PVector pos;
  PVector vel;
  PVector acc;
  color col;
  WaveCircle waveCirc;

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
    waveCirc = new WaveCircle(pos.x, pos.y, r);
    waveCirc.setColor(col);
  }

  public void setColor(color col_) {
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
    force.mult(1 / r);
    acc.add(force);
  }

  void display() {
    fill(col);
    noStroke();
    waveCirc.display(pos.x, pos.y, r);

    int reX = 0;
    int reY = 0;
    if (pos.x + r * (1 + ampMult) >= width) reX = -1;
    if (pos.x - r * (1 + ampMult) <= 0) reX = 1;
    if (pos.y + r * (1 + ampMult) >= height) reY = -1;
    if (pos.y - r * (1 + ampMult) <= 0) reY = 1;
    reDisplay(reX, reY);
  }

  //redisplay allows a circle to be shown half on one side of the screen and half on the other
  void reDisplay(int xMult, int yMult) {
    waveCirc.display(pos.x + (width * xMult), pos.y + (height * yMult), r);
    if(xMult != 0 && yMult != 0){
      waveCirc.display(pos.x + (width * xMult), pos.y, r);
      waveCirc.display(pos.x, pos.y + (height * yMult), r);
    }
  }

  //flowfield stuff
  void follow(PVector[] flowField) {
    int x = (int) (pos.x / scl);
    int y = (int) (pos.y / scl);
    int index = (x + (y * cols));
    if (index >= 0 && index < flowField.length) {
      PVector force = flowField[index];
      applyForce(force);
    }
  }

  void edges() {
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }
}
