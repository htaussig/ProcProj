// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>

// The "Vehicle" class

class Vehicle {

  static final float nutritionGood = .33;
  static final float nutritionBad = -.82;

  float cloneChance = 0.004;

  PVector acceleration = new PVector(0, 0);
  PVector velocity;
  PVector position;
  float r = 4;
  float maxforce = .2;    // Maximum steering force
  float maxspeed = 2.5;    // Maximum speed

  float health = 1;
  float healthLoss = 0.0052;
  float mutationRate = .6;

  float[] dna = new float[6];
  int age = 0;

  Vehicle(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D().setMag(random(maxspeed/2, maxspeed));
    //velocity = new PVector(0, 0);

    for (int i = 0; i < dna.length; i++) {
      dna[i] = random(1);
    }

    /*Food weight
     dna[0] = random(-2, 2);
     poison weight
     dna[1] = random(-2, 2);
     food perception
     dna[2] = random(0, 200);
     poison perception
     dna[3] = random(0, 200);
     rocket weight
     dna[4]
     rocket perception
     dna[5]
     */
  }

  Vehicle(float x, float y, float[] dna_) {
    this(x, y);
    dna = mutation(dna_.clone());
  }

  private float[] mutation(float[] dna_) {
    for (int i = 0; i < dna_.length; i++) {
      if (random(1) < mutationRate) {
        dna_[i] += random(-.077, .077);
        if (dna_[i] < 0) {
          dna_[i] = 0;
        } else if (dna_[i] > 1) {
          dna_[i] = 1;
        }
      }
    }
    return dna_;
  }

  public float getFoodW() {
    return (dna[0] - .5) * 2;
  }

  public float getPoisonW() {
    return (dna[1] - .5) * 2;
  }

  public float getVehicleW() {
    return (dna[4] - .5) * 2;
  }

  public float getFoodP() {
    return (dna[2]) * 220;
  }

  public float getPoisonP() {
    return (dna[3]) * 220;
  }

  public float getVehicleP() {
    return (dna[5]) * 220;
  }

  // Method to update location
  void update() {
    age++;
    health -= healthLoss;
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void behaviors(ArrayList<PVector> good, ArrayList<PVector> bad, ArrayList<PVector> vehiclesPos) {
    eat(good, bad);

    PVector steerG = move(good, getFoodP());
    PVector steerB = move(bad, getPoisonP());
    PVector steerV = move(vehiclesPos, getVehicleP());

    steerG.mult(getFoodW());  //this makes maxforce a lie
    steerB.mult(getPoisonW());
    steerV.mult(getVehicleW());

    applyForce(steerG);
    applyForce(steerB);
    applyForce(steerV);
  }

  private void eat(ArrayList<PVector> good, ArrayList<PVector> bad) {  
    for (int i = good.size() - 1; i >= 0; i--) {
      float d = position.dist(good.get(i));
      if (d < maxspeed + 2) {
        good.remove(i);
        health += nutritionGood;
      }
    }

    for (int i = bad.size() - 1; i >= 0; i--) {
      float d = position.dist(bad.get(i));
      if (d < maxspeed + 2) {
        bad.remove(i);
        health += nutritionBad;
      }
    }

    if (health > 1) {
      health = 1;
    }
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED - VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.setMag(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }

  public Vehicle cloneMe() {
    if (random(1) < cloneChance * health) {
      return new Vehicle(position.x, position.y, dna);
    } else {
      return null;
    }
  }

  public PVector move(ArrayList<PVector> list, float perception) {
    float record = 100000000;
    PVector closest = null;
    for (int i = list.size() - 1; i >= 0; i--) {
      float d = position.dist(list.get(i));
      //list.get(i) != position  allows for the vehicle to not seek it's own position
      if (list.get(i) != position && d < record && d < perception) {
        record = d; 
        closest = list.get(i);
      }
    }

    if (closest != null) {
      return this.seek(closest);
    }

    return new PVector();
  }

  boolean dead() {
    return (health < 0);
  }

  void boundaries() {
    float d = 5;

    PVector desired = null;

    if (position.x < d) {
      desired = new PVector(maxspeed, velocity.y);
    } else if (position.x > width - d) {
      desired = new PVector(-maxspeed, velocity.y);
    }

    if (position.y < d) {
      desired = new PVector(velocity.x, maxspeed);
    } else if (position.y > height - d) {
      desired = new PVector(velocity.x, -maxspeed);
    }

    if (desired != null) {
      desired.setMag(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

  void drawDebug() {
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);  //allows to see both lines if overlapping
    line(0, 0, 0, -getFoodW() * 30);  
    strokeWeight(2);
    ellipse(0, 0, getFoodP() * 2, getFoodP() * 2);

    stroke(255, 0, 0);
    line(0, 0, 0, -getPoisonW() * 30);
    ellipse(0, 0, getPoisonP() * 2, getPoisonP() * 2);

    stroke(0, 0, 255);
    line(0, 0, 0, -getVehicleW() * 30);
    ellipse(0, 0, getVehicleP() * 2, getVehicleP() * 2);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + PI/2;

    color gr = color(0, 255, 0);
    color rd = color(255, 0, 0);
    color col = lerpColor(rd, gr, health);

    fill(col);
    noStroke();
    //stroke(0);
    //strokeWeight(1);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);

    if (debugBox.checked) {
      drawDebug();
    }

    popMatrix();
  }
}
