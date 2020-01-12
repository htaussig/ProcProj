// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>
// Nature of Code, Spring 2011

// Two "vehicles" follow the mouse position

// Implements Craig Reynold's autonomous steering behaviors
// One vehicle "seeks"
// One vehicle "arrives"
// See: http://www.red3d.com/cwr/

CheckBox debugBox = new CheckBox(4, 4);
CheckBox fastBox = new CheckBox(4, 28);
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
ArrayList<PVector> vehiclesPos = new ArrayList<PVector>();
ArrayList<PVector> food = new ArrayList<PVector>();
ArrayList<PVector> poison = new ArrayList<PVector>();
ArrayList<Integer> lifeSpans = new ArrayList<Integer>();

void setup() {
  size(800, 800);
  frameRate(60);
  for (int i = 0; i < 70; i++) {
    vehicles.add(new Vehicle(random(width), random(height)));
  }
  smooth();

  createFood();
  createPoison();
}

void createPoison() {  
  for (int i = 0; i < 90; i++) {
    addOnePoison();
  }
}


void createFood() { 
  for (int i = 0; i < 70; i++) {
    addOneFood();
  }
}

void addOneFood() {
  float x = random(width);
  float y = random(height);
  food.add(new PVector(x, y));
}

void addOnePoison() {
  float x = random(width);
  float y = random(height);
  poison.add(new PVector(x, y));
}

void drawFood() {
  for (int i = 0; i < food.size(); i++) {
    PVector tempFood = food.get(i);
    fill(0, 255, 0);
    noStroke();
    ellipse(tempFood.x, tempFood.y, 6, 6);
  }
}

void drawPoison() { 
  for (int i = 0; i < poison.size(); i++) {
    PVector tempP = poison.get(i);
    fill(255, 0, 0);
    noStroke();
    ellipse(tempP.x, tempP.y, 6, 6);
  }
}

//65

//return the average lifespan over the last 
int getAvgLifeSpan() {
  int sum = 0;
  while (lifeSpans.size() > 100) {
    lifeSpans.remove(0);
  }
  for(int age : lifeSpans){
   sum += age; 
  }
  if(lifeSpans.size() > 0){
    return sum / lifeSpans.size();
  }
  else{
   return -1; 
  }
}

void draw() {
  background(42);

  if (random(1) < .16) {
    addOneFood();
  }

  if (random(1) < .032) {
    addOnePoison();
  }

  drawFood();
  drawPoison();

  vehiclesPos.clear();
  for (int j = 0; j < vehicles.size(); j++) {
    vehiclesPos.add(vehicles.get(j).position);
  }

  // Call the appropriate steering behaviors for our agents
  for (int i = vehicles.size() - 1; i >= 0; i--) {
    Vehicle v = vehicles.get(i);
    v.boundaries();
    v.behaviors(food, poison, vehiclesPos);
    //v.eat(food);
    //v.seek(food);
    v.update();
    v.display();

    //move one percent chance here from the cloneMe function
    Vehicle newVehicle = vehicles.get(i).cloneMe();
    if (newVehicle != null) {
      vehicles.add(newVehicle);
    }

    if (v.dead()) {
      lifeSpans.add(v.age);
      food.add(new PVector(random(width), random(height)));
      vehicles.remove(i);
    }
  }

  strokeWeight(2);
  fill(255);
  text("Year: " + frameCount / 120, 30, 25);
  text("Average last 100 LifeSpan: " + getAvgLifeSpan(), 30, 12);

  fastBox.display();
  debugBox.display();
}

void mouseDragged() {
  vehicles.add(new Vehicle(mouseX, mouseY));
}

void mouseClicked() {
  if (debugBox.isOver()) {
    debugBox.click();
  }
  else if(fastBox.isOver()){
    fastBox.click();
    if(fastBox.checked){
      frameRate(2000);
    }
    else{
      frameRate(60);
    }
  }
}
