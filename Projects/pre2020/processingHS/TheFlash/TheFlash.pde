ArrayList<Circle> circles;
int numRows = 19;
int numCols = 19;
float circleRadius = 30;
float t;

void setup(){
  size(600, 600);
  background(0);
  smooth(8);
  //noStroke();
  strokeWeight(0);
  circles = new ArrayList<Circle>();
  for(int x = (-width / numCols) + (width / numCols) / 2; x <= width + (2 * width / numCols); x += width / numCols){
   for(int y = (height / numRows) / 2; y <= height; y += height / numRows){
     circles.add(0, new Circle(x, y, circleRadius, color(255)));
     circles.add(new Circle(x, y, circleRadius + 1, color(0)));
   }
  }
  t = 0;
}

void draw(){
  background(0);
  //WHITE CIRCLES
  for(int i = 0; i < circles.size() / 2; i++){
   //float xAdd = -sin(t) * circleRadius;
   circles.get(i).display(); 
  }
  //BLACK CIRCLES (that move)
  for(int i = circles.size() / 2; i < circles.size(); i++){
    Circle circle = circles.get(i);
    float xDiff = abs(circle.getX() - (width / 2));
    float yDiff = abs(circle.getY() - (height / 2));
    float diff = sqrt(xDiff * xDiff + yDiff * yDiff);
    float xAdd = sin(t - diff/70) * (circleRadius + 1);
    circle.display(xAdd); 
  }
   t += radians(.7);
  
}