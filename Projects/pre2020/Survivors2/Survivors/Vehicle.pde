// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>

// The "Vehicle" class

class Vehicle {

  static final float d = 60;
  static final int numTeams = 2;
  /*static final float nutritionGood = .33;
   static final float nutritionBad = -.82;*/

  //float cloneChance = 0.0033;
  float cloneChance = 0;

  PVector acceleration = new PVector(0, 0);
  PVector velocity;
  PVector position;
  float r = 5;
  float maxforce = .1;    // Maximum steering force
  float maxspeed = 2.5;    // Maximum speed

  float health = 1;
  //float healthLoss = 0.0052;
  float healthLoss = 0;
  float damage = .04;
  float mutationRate = .6;

  float[] dna = new float[4];
  int age = 0;
  int team = 0;
  int killCounter = 0;

  Vehicle(float x, float y) {
    position = new PVector(x, y);
    velocity = getRandom2D().setMag(random(maxspeed/2, maxspeed));
    //velocity = new PVector(0, 0);

    for (int i = 0; i < dna.length; i++) {
      dna[i] = random(1);
    }

    team = (int) random(numTeams);

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

  Vehicle(float x, float y, float[] dna_, int teamNum) {
    this(x, y, dna_);
    team = teamNum;
  }

  Vehicle(float x, float y, int teamNum) {
    this(x, y);
    team = teamNum;
  }

  //this allows us to seed this method (same on each seeded run)
  private PVector getRandom2D() {
    return new PVector(random(-1, 1), random(-1, 1));
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

  /*public float getFoodW() {
   return (dna[0] - .5) * 2;
   }
   
   public float getPoisonW() {
   return (dna[1] - .5) * 2;
   }*/

  public float getTeamW() {
    return (dna[0] - .5) * 2;
  }

  public float getEnemyW() {
    return (dna[1] - .5) * 2;
  }

  /*public float getFoodP() {
   return (dna[2]) * 220;
   }
   
   public float getPoisonP() {
   return (dna[3]) * 220;
   }*/

  public float getTeamP() {
    return (dna[2]) * 220;
  }

  public float getEnemyP() {
    return (dna[3]) * 220;
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

  void behaviors(ArrayList<Vehicle> vehicles) {
    ArrayList<PVector> teamPos = new ArrayList<PVector>();
    ArrayList<PVector> enemyPos = new ArrayList<PVector>();
    for (int i = 0; i  < vehicles.size(); i++) {
      Vehicle v = vehicles.get(i);
      if (v.team == team) {
        teamPos.add(v.position);
      } else {
        enemyPos.add(v.position);
      }
    }

    kill();

    //only need to eat if there is food
    //eat(good, bad);

    PVector steerT = move(teamPos, getTeamP());
    PVector steerE = move(enemyPos, getEnemyP());

    steerT.mult(getTeamW());
    steerE.mult(getEnemyW());

    applyForce(steerT);
    applyForce(steerE);
  }


  //returns whether or not it is a killing blow
  public boolean takeDamage(float damageTaken) {
    if (health < 0) {
      return false;
    }
    health -= damageTaken;
    if (health < 0) {
      return true;
    }
    return false;
  }

  private void kill() {      
    ArrayList<Vehicle> enemies = new ArrayList<Vehicle>();
    for (int i = 0; i < vehicles.size(); i++) {
      if (vehicles.get(i).team != team) {
        enemies.add(vehicles.get(i));
      }
    }

    for (int i = enemies.size() - 1; i >= 0; i--) {
      Vehicle enemy = enemies.get(i);
      float d = position.dist(enemies.get(i).position);
      PVector diff = PVector.sub(enemies.get(i).position, position);
      if (d < maxspeed + r * 3.15) {
        //if the enemy dies, add to this vehicles kill counter
        float diffDirection = abs(velocity.heading() - diff.heading());
        if (diffDirection > PI) {
          diffDirection -= TWO_PI;
          diffDirection = abs(diffDirection);
        }
        if (diffDirection < radians(90)) {
          if (enemy.takeDamage(damage)) {
            killCounter++;
          }
        }
      }
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

  public Vehicle cloneMeChance() {
    //capped at 700
    float tempChance;

    //A kill is a guarenteed clone
    if (killCounter > 0) {
      killCounter--;
      tempChance = 1;
    } else {
      tempChance = cloneChance * health;
    }

    if (random(1) < tempChance) {
      return new Vehicle(position.x, position.y, dna, team);
    } else {
      return null;
    }
  }

  public Vehicle cloneMe() {
    return new Vehicle(position.x, position.y, dna, team);
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

    PVector desired = null;

    if (position.x < d) {
      desired = new PVector(maxspeed, velocity.y);
    } else if (position.x > arenaWidth - d) {
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

    /*line(0, 0, 0, -getFoodW() * 30);  
     strokeWeight(2);
     ellipse(0, 0, getFoodP() * 2, getFoodP() * 2);
     
     stroke(255, 0, 0);
     line(0, 0, 0, -getPoisonW() * 30);
     ellipse(0, 0, getPoisonP() * 2, getPoisonP() * 2);*/

    stroke(getColor(team));
    line(0, 0, 0, -getTeamW() * 30);
    ellipse(0, 0, getTeamP() * 2, getTeamP() * 2);


    strokeWeight(2);

    stroke(getColor((team + 1) % numTeams));
    line(0, 0, 0, -getEnemyW() * 30);
    ellipse(0, 0, getEnemyP() * 2, getEnemyP() * 2);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + PI/2;

    fill(getColor(team), health * 255);
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

public color getColor(float teamNum) {
  pushStyle();
  colorMode(HSB, 1000, 100, 100, 100);
  color col = color(1000 * teamNum / numTeams, 100, 100);
  popStyle();
  return col;
  
}
