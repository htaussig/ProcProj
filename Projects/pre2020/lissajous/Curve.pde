public class Curve {

  Circle xCirc, yCirc;

  ArrayList<PVector> points;

  public Curve(Circle xCirc_, Circle yCirc_) {
    xCirc = xCirc_;
    yCirc = yCirc_;
    points = new ArrayList<PVector>();
  }

  void addPoint() {
    points.add(new PVector(xCirc.getPointX(), yCirc.getPointY()));
  }
     
  void cut(){
    points.remove(0);
  }

  void display() {
    strokeWeight(2);
    stroke(getCol());
    noFill();

    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    endShape();

    strokeWeight(5);
    PVector p = points.get(points.size() - 1);
    point(p.x, p.y);
  }
  
  color getCol(){
    color c1 = xCirc.getColor();
    color c2 = yCirc.getColor();
    
    colorMode(RGB);
    
    float v1 = map(xCirc.x, 0, width, 0, 1);
    float v2 = map(yCirc.y, 0, height, 0, 1);
    
    
    return lerpColor(c1, c2, v1);
  }
}
