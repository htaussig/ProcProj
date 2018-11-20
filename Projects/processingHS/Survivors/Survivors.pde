// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>
// Nature of Code, Spring 2011

// Two "vehicles" follow the mouse position

// Implements Craig Reynold's autonomous steering behaviors
// One vehicle "seeks"
// One vehicle "arrives"
// See: http://www.red3d.com/cwr/

float arenaWidth = 800;
boolean gameOver = false;
int numTeams = 2;
int numVehicles = 400;

CheckBox debugBox = new CheckBox(4, 4);
CheckBox fastBox = new CheckBox(4, 28);
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
//ArrayList<PVector> vehiclesPos = new ArrayList<PVector>();
/*ArrayList<PVector> food = new ArrayList<PVector>();
 ArrayList<PVector> poison = new ArrayList<PVector>();*/
ArrayList<Integer> lifeSpans = new ArrayList<Integer>();
ArrayList<ArrayList<Float>> pops = new ArrayList<ArrayList<Float>>();
Float[] popsNow = new Float[numTeams];
Graph popGraph;

//this seed does not work on the PVector.random2D() calls
long seed;

boolean RECORDING = false;
int initialFrame = 0;

//4-player = -831283456

void setup() {
  size(1200, 800);
  frameRate(60);
  seed = (long) random(-1000000000, 1000000000);
  //randomSeed(-831283456);
  for (int i = 0; i < popsNow.length; i++) {
    popsNow[i] = 0.0;
  }
  generateVehicles();
  smooth();

  popGraph = new Graph(arenaWidth + 10, 10.0, width - arenaWidth - 40, width - arenaWidth - 40, pops);

  for (int i = 0; i < numTeams; i++) {
    pops.add(new ArrayList<Float>());
    popGraph.setColor(i, getColor(i));
  }

  /*createFood();
   createPoison();*/
}

void generateVehicles() {
  //this assumes the arena is a square
  float maxMag = arenaWidth * sqrt(2);
  float angle1 = 0;
  for (int teamNum = 0; teamNum < numTeams; teamNum++) {
    float angle2 = TWO_PI * (teamNum + 1) / numTeams;
    for (int j = 0; j < numVehicles / numTeams; j++) {
      //float x = random(arenaWidth * (teamNum) / numTeams ,arenaWidth * (teamNum + 1) / numTeams);
      PVector pos = getRandomPos(angle1, angle2, maxMag); 
      vehicles.add(new Vehicle(arenaWidth / 2 + pos.x, height / 2 + pos.y, teamNum));
      popsNow[teamNum]++;
    }
    angle1 = angle2;
  }
}

PVector getRandomPos(float angle1, float angle2, float maxMag) {
  PVector pos = PVector.fromAngle(random(angle1, angle2));
  pos.setMag(random(50, maxMag));
  if(abs(pos.x) > arenaWidth / 2 || abs(pos.y) > height / 2){
    return getRandomPos(angle1, angle2, maxMag - 1);
  }
  return pos;
}

/*void createPoison() {  
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
 float x = random(arenaWidth);
 float y = random(height);
 food.add(new PVector(x, y));
 }
 
 void addOnePoison() {
 float x = random(arenaWidth);
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
 }*/

//return the average lifespan over the last 
int getAvgLifeSpan() {
  int sum = 0;
  while (lifeSpans.size() > 100) {
    lifeSpans.remove(0);
  }
  for (int age : lifeSpans) {
    sum += age;
  }
  if (lifeSpans.size() > 0) {
    return sum / lifeSpans.size();
  } else {
    return -1;
  }
}

void draw() {
  background(42);

  /*if (random(1) < .16) {
   addOneFood();
   }
   
   if (random(1) < .032) {
   addOnePoison();
   }
   
   drawFood();
   drawPoison();*/

  /*vehiclesPos.clear();
   for (int j = 0; j < vehicles.size(); j++) {
   vehiclesPos.add(vehicles.get(j).position);
   }*/

  // Call the appropriate steering behaviors for our agents
  for (int i = vehicles.size() - 1; i >= 0; i--) {
    Vehicle v = vehicles.get(i);
    v.boundaries();
    v.behaviors(vehicles);
    v.update();
    v.display();

    if (v.killCounter > 0) {
      vehicles.add(v.cloneMe());
      popsNow[v.team]++; 
      v.killCounter--;
    }

    if (v.dead()) {
      lifeSpans.add(v.age);
      popsNow[v.team]--;
      //food.add(new PVector(random(arenaWidth), random(height)));
      vehicles.remove(i);
    }/* else {
     //move one percent chance here from the cloneMe function
     for (int j = 0; j < v.killCounter; j++) {
     vehicles.add(v.cloneMe());
     popsNow[v.team]++;
     }
     v.killCounter = 0;
     }*/
  }

  //updates the population graph data
  if (!gameOver) {
    for (int i = 0; i < numTeams; i++) {
      pops.get(i).add(popsNow[i]);
    }
    int sum = 0;
    for (int i = 0; i < numTeams; i++) {
      if (popsNow[i] == 0) {
        sum++;
      }
      if(sum == numTeams - 1){
       gameOver = true; 
      }
    }
  }


  strokeWeight(2);
  fill(255);
  text("Year: " + frameCount / 60, 30, 25);
  text("Average last 100 LifeSpan: " + getAvgLifeSpan(), 30, 12);

  fastBox.display();
  debugBox.display();
  //System.out.println(vehicles.size());

  stroke(255);
  fill(74);
  rect(arenaWidth, -1, width - arenaWidth, height);

  popGraph.display();
  
  if (RECORDING) {
    saveFrame("movie/WaveCirclesFlow-######.png");
    fill(255, 0, 0);
    textSize(20);
    text("seconds: " + ((frameCount - initialFrame) / frameRate), 15, 15);
  }
}

void mouseDragged() {
  if(mouseX < arenaWidth){
    Vehicle v = new Vehicle(mouseX, mouseY);
    popsNow[v.team]++;
    vehicles.add(new Vehicle(mouseX, mouseY));
  }  
}

void mouseClicked() {
  if (debugBox.isOver()) {
    debugBox.click();
  } else if (fastBox.isOver()) {
    fastBox.click();
    if (fastBox.checked) {
      frameRate(2000);
    } else {
      frameRate(60);
    }
  }
}

void keyPressed() {
  System.out.println("The seed for this run was: " + seed);
  if (key == 'r') {
    RECORDING = !RECORDING;
    initialFrame = frameCount;
  }
}
