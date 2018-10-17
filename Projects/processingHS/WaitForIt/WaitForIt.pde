ArrayList<DotCircle> circles = new ArrayList<DotCircle>();
float numCircles = 30;

void setup(){
  size(600, 600);
  for(int i = 0; i < numCircles; i++){
    circles.add(new DotCircle(0, 0, 500 * ((i + 1) / numCircles), color(159, 116, 240)));
  }
}

void draw(){
   background(255);
   translate(width / 2, height / 2);
   for(int i = 0; i < circles.size(); i++){
      DotCircle circle = circles.get(i);
      circle.display();
      circle.addPercent(2 * (circles.size() - i + 0));
   }
}