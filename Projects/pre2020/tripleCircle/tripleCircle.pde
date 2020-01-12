//Harry Taussig, Generate Serendipity, 9/16/19 start,

boolean DISPLAYPOINTS = true;
boolean DISPLAYLINES = true;
boolean DISPLAYFLYERS = true;

//only drawing stuff based on circles?
boolean CIRCLEMODE = true;

float NUMPOINTS = 50;
//cannot exceed number of points
int NUMFLYERS = 20;

float GCONSTANT = 5;
//max force applied from one gravity pull
float MAXFORCE = .0025;
//Max distance that lines are drawn away from other points
float MAXDISTANCEFORLINES = 135;

//how far a point can go away from the screen before getting it's velocity set to 0 
float MAXDISTBOUNDS = 0;

//3 or 2 or maybe 6 is good
float LINESTROKEWEIGHT = 3;

//planets won't rotate very closely to eachother closer than this distance
float MINPULLDISTANCE = 0;

//max starting velocity for a point
float MAXSTARTINGVEL = 3;

//float MAXVEL = 3;

ArrayList<Point> points;
ArrayList<Flyer> flyers;
//right now this isn't actually separate
ArrayList<Circle> circles;
//ArrayList<Detector> detectors;

Circle traingleCircle;
Circle partCircle;
Circle lineCircle;

//-1 for random seed
long seed = -839603;

void setup() {
  size(1000, 1000, P2D);
  frameRate(60);
  
  //seeding not currently working, check pVectors random2d
  if(seed == -1){
     seed = (int) random(-1000000, 1000000);
  }
  randomSeed(seed);
  noiseSeed(seed);
  println(seed);

  colorMode(HSB, 256, 256, 256);
  

  genPoints();
  genFlyers();
  //genDetectors();
  genCircles();
}

void seedingStuff(){

}

void genCircles(){
  circles = new ArrayList<Circle>();
  
  traingleCircle = new Circle(width / 2.0, height / 2.0, width / 3.5);
  traingleCircle.type = "triangle";
  traingleCircle.mass = (random(3, 5));
  points.add(traingleCircle);
  
  partCircle = new Circle(width / 3.0, height / 3.0, width / 3.5);
  partCircle.type = "particle";
  traingleCircle.mass = (random(3, 5));
  points.add(partCircle);
  
  lineCircle = new Circle(width * 2.0 / 3, height * 2.0 / 3, width / 3.5);
  partCircle.type = "line";
  traingleCircle.mass = (random(3, 5));
  points.add(lineCircle);
}

void genPoints() {
  points = new ArrayList<Point>();

  for (int i = 0; i < NUMPOINTS; i++) {
    float x = random(0, width);
    float y = random(0, height);

    //color col = getColorFromDist(x, y);

    addPoint(x, y);
  }
}

void genFlyers() {
  flyers = new ArrayList<Flyer>();
  //just adding a flyer at a random point
  for (int i = 0; i < NUMFLYERS; i++) {
    flyers.add(new Flyer(points.get(i)));
  }
}

//void genDetectors(){
//  detectors = new ArrayList<Detector>();

//  for (int i = 0; i < NUMPOINTS; i++) {
//    float x = random(0, width);
//    float y = random(0, height);

//    //color col = getColorFromDist(x, y);

//    detectors.add(new Detector(x, y));
//  }
//}

//get the color of a point based on it's starting distance from the center
color getColorFromDist(float x, float y) {
  float dx = (width / 2) - x;
  float dy = (height / 2) - y;

  float dist = sqrt((dx * dx) + (dy * dy));

  float num = map(dist, 0, sqrt(2 * (width / 2) * (height / 2)), 0, 255);
  //println(num);
  return color(num);
}

void addPoint(float x, float y) {
  points.add(new Point(x, y));
}

void addPoint(float x, float y, color col) {
  points.add(new Point(x, y, col));
}

void gravity() {
  for (int i = 0; i < points.size(); i++) {
    for (int j = i+1; j < points.size(); j++) {
      Point p1 = points.get(i);
      Point p2 = points.get(j);
      PVector force = getForce(p1, p2);

      p1.applyForce(force);
      p2.applyForce(force.mult(-1));
    }
  }
}

void linesBetweenPoints(Point p1, Point p2) {
  //getting mag back to distance
  sendConnectPoints(PVector.dist(p1.pos, p2.pos), p1, p2);
}

void sendConnectPoints(float distance, Point p1, Point p2) {

  if (distance < MAXDISTANCEFORLINES) {
    float colNum = map(distance, 0, MAXDISTANCEFORLINES, 255, 0);
    //println(colNum);
    if(colNum < 0){
      println("why is colNum < 0?");
      colNum = 0;
    }
    else if(colNum > 255){
      colNum = 254;
      println("why is colNum > 255?");
    }
    color col = color(255, colNum);  

    p1.addConnectPoint(new Point(p2.getX(), p2.getY(), col));
  }
}

//returns the force to be put on p1
//mult by -1 to get force on p2 (equal and opposite forces)
PVector getForce(Point p1, Point p2) {
  float dx = p2.getX() - p1.getX();
  float dy = p2.getY() - p1.getY();

  float distSquared = ((dx * dx) + (dy * dy));
  distSquared = max(distSquared, MINPULLDISTANCE * MINPULLDISTANCE); 

  float mag =  p1.mass * p2.mass * (1 / distSquared) * GCONSTANT;

  mag = min(mag, MAXFORCE);

  return new PVector(dx, dy).setMag(mag);
}

//could return null
Point findNextPointForFlyer(Flyer fly) {
  Point p1 = fly.curPoint;

  Point p2 = getValidFlyerPoint(p1, 0);

  return p2;
}

Point getValidFlyerPoint(Point p1, int recurDepth) {
  Point p2 = points.get((int) random(points.size()));

  if (recurDepth == 100) {
    return null;
  }
  if (p1 == p2) {
    p2 = getValidFlyerPoint(p1, recurDepth++);
  }

  return p2;
}

void generateLines() {
  for (int i = 0; i < points.size(); i++) {
    for (int j = i+1; j < points.size(); j++) {
      Point p1 = points.get(i);
      Point p2 = points.get(j);

      linesBetweenPoints(p1, p2);
    }
  }
}

void updatePoints() {
  for (Point p : points) {
    p.update();
  }
}

void displayPoints() {
  for (Point p : points) {
    p.display(DISPLAYPOINTS);
  }
}

void displayLines() {
  for (Point p : points) {
    if(DISPLAYLINES){
       p.displayConnectPoints(lineCircle);
    }
  }
}


void updateAndDisplayFlyers() {
  if (DISPLAYFLYERS) {
    for (Flyer f : flyers) {
      f.update();
      if(CIRCLEMODE){
        f.display(partCircle);
      }else{
        f.display();
      }
    }
  }
}

void updateCircles(){
  for (Circle c : circles) {
    c.update();
  }
}

void draw() {
  background(0);

  gravity();
  updateCircles();
  updatePoints();
  
  displayPoints();
  
  traingleCircle.display();
  
  displayLines();
  generateLines();
  updateAndDisplayFlyers();
  partCircle.display();
  lineCircle.display();
  
  doIfRecording();
}

void keyPressed(){
  println("the seed is" + seed);
}
