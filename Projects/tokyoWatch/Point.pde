public class Point{
  float x, y;
  Segment[] segments;
  public Point(float x, float y){
    this.x = x;
    this.y = y;
    segments = new Segment[4];
  }
  
  void display(){
    pushMatrix();
    translate(x, y);
    noStroke();
    fill(0);
    ellipse(0, 0, 1, 1);
    popMatrix();
  }
}
