//Harry Taussig, Generate Serendipity, 9/16/19 start,
boolean RECORDING = false;


float NUMPOINTS = 2400;
float GCONSTANT = .00000001;

ArrayList<Point> points;


void setup(){
  size(1000, 1000, P2D);
  frameRate(60);
  
  colorMode(HSB, 256, 256, 256);
  
  genPoints();
  
}

void genPoints(){
  points = new ArrayList<Point>();
  
  for(int i = 0; i < NUMPOINTS; i++){
    float angle = random(0, TWO_PI);
    PVector p = PVector.fromAngle(angle).setMag(random(0, width / 2));
    //float x = random(0, width);
    //float y = random(0, height);
    
    float x = p.x + width / 2;
    float y = p.y + height / 2;
    
    color col = getColorFromDist(x, y);
    
    addPoint(x, y, col);
  }
}

//get the color of a point based on it's starting distance from the center
color getColorFromDist(float x, float y){
  float dx = (width / 2) - x;
  float dy = (height / 2) - y;
  
  float dist = sqrt((dx * dx) + (dy * dy));
  
  float num = map(dist, 0, width / 2, 70, 255);
  println(num);
  return color(num, 255, 255);
}

void addPoint(float x, float y){
  points.add(new Point(x, y));
}

void addPoint(float x, float y, color col){
  points.add(new Point(x, y, col));
}

void gravity(){
  for(int i = 0; i < points.size(); i++){
    for(int j = i+1; j < points.size(); j++){
      Point p1 = points.get(i);
      Point p2 = points.get(j);
      PVector force = getForce(p1, p2);
      
      p1.applyForce(force);
      p2.applyForce(force.mult(-1));      
    }
  }
}

//returns the force to be put on p1
//mult by -1 to get force on p2 (equal and opposite forces)
PVector getForce(Point p1, Point p2){
  float dx = p2.getX() - p1.getX();
  float dy = p2.getY() - p1.getY();
  
  float mag = ((dx * dx) + (dy * dy)) * GCONSTANT;
  
  return new PVector(dx, dy).setMag(mag);
}

void updatePoints(){
  for(Point p : points){
    p.update();
  }
}

void displayPoints(){
  for(Point p : points){
    p.display();
  }
}

void draw(){
  background(0);
  
  gravity();
  updatePoints();
  
  displayPoints();
  
  if (RECORDING) {
     println("recording!!");
     saveFrame("movie/f#####-rainbowFall.png");
  }
}
