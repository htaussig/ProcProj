public class Rocket {

  PVector pos;
  PVector vel;
  PVector acc;
  DNA dna;
  float fitness;
  float prob;
  int completed = lifeSpan;
  boolean crashed = false;

  public Rocket() {
    pos = new PVector(width / 2, height - 10);
    vel = new PVector();
    acc = new PVector();
    dna = new DNA();
    count = 0;
  }

  public Rocket(DNA dna_) {
    pos = new PVector(width / 2, height);
    vel = new PVector();
    acc = new PVector();
    dna = dna_;
    count = 0;
  }

  public void applyForce(PVector force) {
    acc.add(force);
  }

  public void update() {
    float d = dist(pos.x, pos.y, target.x, target.y);
    if (d < 10 && completed == lifeSpan) {
      completed = count;
      if(completed < quickestComplete){
       quickestComplete = completed; 
      }
      pos = target.copy();
    }

    if (pos.x > rx && pos.x < rx + rw && pos.y > ry && pos.y < ry + rh) {
      crashed = true;
    }
    
    if(pos.x > width || pos.x < 0){
     //crashed = true; 
    }
    
    if(pos.y > height || pos.y < 0){
     //crashed = true; 
    }

    this.applyForce(dna.genes[count]);
    if (completed == lifeSpan && !crashed) {
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
      vel.limit(4);
    }
  }

  public float calcFitness() {
    float d = dist(pos.x, pos.y, target.x, target. y);

    //fitness = map(d, 0, width, width, 0);
    if(d == 0){
     d = 1; 
    }
    fitness = 1.0 / d;
    if (completed != lifeSpan) {
      fitness *= 1 / (.01 + quickestComplete - completed);
    }
    if(crashed){
     fitness /= 10; 
    }
    fitness = pow(fitness, 2);
    //fitness *= 100;
    return fitness;
  }

  public void show() {
    pushMatrix();
    noStroke();
    fill(255, 150);
    translate(pos.x, pos.y);
    rotate(vel.heading());
    rectMode(CENTER);
    rect(0, 0, 25, 5); 
    popMatrix();
  }
}