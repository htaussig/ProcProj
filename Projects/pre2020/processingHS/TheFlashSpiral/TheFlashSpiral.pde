ArrayList<Circle> circles;
int numRows = 21;
int numCols = 21;
float circleRadius;
float t;
float col;
float inc = radians(.58);
float diffDiv = 80;

boolean recording = false;

void setup(){
  colorMode(HSB, 2 * PI, 255, 255);
  frameRate(30);
  size(600, 600);
  background(0);
  smooth(8);
  noStroke();
  //strokeWeight(0);
  col = 2 * PI;
  circleRadius = (height / numRows) - 2;
  circles = new ArrayList<Circle>();
  for(int x = (-width / numCols) + (width / numCols) / 2; x <= width + (2 * width / numCols); x += width / numCols){
   for(int y = (-height / numRows) + (height / numRows) / 2; y <= height + (height / numRows); y += height / numRows){
     float xDiff = abs(x - (width / 2));
     float yDiff = abs(y - (height / 2));
     float diff = sqrt(xDiff * xDiff + yDiff * yDiff);
     diff /= diffDiv;
     circles.add(0, new Circle(x, y, circleRadius, color((abs(col) - diff) % (2 * PI), 255, 255)));
     circles.add(new Circle(x, y, circleRadius + 1, color(0)));
   }
  }
  t = 0;
}

void draw(){
  background(0);
  //COLORED CIRCLES
  for(int i = 0; i < circles.size() / 2; i++){
   //float xAdd = -sin(t) * circleRadius;
   Circle circle = circles.get(i);
   float xDiff = abs(circle.x - (width / 2));
   float yDiff = abs(circle.y - (height / 2));
   float diff = sqrt(xDiff * xDiff + yDiff * yDiff);
   diff /= diffDiv;
   circle.setColor(color((col - diff) % (2 * PI), 255, 255));
   //float yAdd = cos(4 * (t - diff / 400)) * (circleRadius + 1);
   //circle.display(0, yAdd);
   circle.display();
  }
  //BLACK CIRCLES (that move)
  for(int i = circles.size() / 2; i < circles.size(); i++){
    Circle circle = circles.get(i);
    float xDiff = abs(circle.x - (width / 2));
    float yDiff = abs(circle.y - (height / 2));
    float diff = sqrt(xDiff * xDiff + yDiff * yDiff);
    //float xAdd = sin(4 * (t - diff / 200)) * (circleRadius + 0);
    //float yAdd = cos(4 * (t - diff / 200)) * (circleRadius + 0);
    float xAdd = sin(4 * (t - diff / 122)) * (float) width / numCols;
    float yAdd = cos(4 * (t - diff / 122)) * (float) height / numRows;
    //circle.setColor(color((col - diff) % 255, 255, 255));
    circle.display(xAdd, yAdd); 
  }
  col += 2 * inc;
  t += inc;
  
  if(recording){
    saveFrame("f###.gif");
      if (t >= radians(360))
        exit();
  }
}