//Harry Taussig, Generate Serendipity, 9/16/19 start,

float NUMPOINTS = 3000;
float GCONSTANT = .00000001;

ArrayList<Point> points;

void setup(){
  size(1000, 1000);
  
  genPoints();
  
}

void genPoints(){
  points = new ArrayList<Point>();
  
  for(int i = 0; i < NUMPOINTS; i++){
    float x = random(0, width);
    float y = random(0, height);
    
    addPoint(x, y);
  }
}

void addPoint(float x, float y){
  points.add(new Point(x, y));
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
}
