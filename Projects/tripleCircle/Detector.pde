//public class Detector{
//  PVector pos;
//  color col;
//  float closestDist = width + height;
  
//  public Detector(float x, float y){
//    pos = new PVector(x, y);
//  }
  
//  void getClosestDistance(ArrayList<Point> points){
//    float closestDist = width + height;
//    for(Point p : points){
//      closestDist = min(closestDist, PVector.dist(p.pos, pos));
//    }
//  }
  
//  void setColor(){
//    fill(color(map(closestDist, 10, width / 10, 255, 0)));    
//  }
  
//  void display(){
//    pushMatrix();
//    translate(pos.x, pos.y);
    
//    setColor();
    
//    ellipse(0, 0, 10, 10);
      
//    popMatrix();
//  }
//}
