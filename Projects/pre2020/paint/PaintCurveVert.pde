class PaintCurveVert extends PaintStroke {
  
  int numPoints = 3;
  
  ArrayList<PVector> points;
  
  public PaintCurveVert(){
    points = new ArrayList<PVector>();
    genPoints();
    init();
  }
  
  public PaintCurveVert(ArrayList<PVector> points_){   
    points = points_;
    init();
  }
  
  void init(){
    col = color(pal.getColor());
    inwards = getAverageSlope().rotate(radians(90)).setMag(1);
    numLines = (int) random(70, 120);
  }
  
  //first and last points get added twice to align the control points
  void genPoints(){
    PVector p = new PVector(random(width), random(height));
    points.add(p);
    points.add(p);
    
    for(int i = 0; i < numPoints - 2; i++){
     PVector temp = new PVector(random(width), random(height));
     points.add(temp);
    }
    
    PVector temp = new PVector(random(width), random(height));
    points.add(temp);
    points.add(temp);
  }
  
  //returns a PVector with the change in x and y 
  //using a pvector makes it so an undefined slope can be handled
  PVector getAverageSlope(){
    PVector p1 = points.get(0);
    PVector p2 = points.get(points.size() - 1);
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    
    return new PVector(dy, dx);
  }
  
  //don't know how to create a PShape using the vertex method
  //so just drawing it in this instance
  void drawShape(){
    beginShape();
    for(int i = 0; i < points.size(); i++){
      PVector p = points.get(i);
     curveVertex(p.x, p.y); 
    }
    endShape();

  }
  
  void display(){
    colorMode(HSB, 99, 99, 99);
    noFill();
    strokeWeight(random(1.7, 3.5));
    //stroke(col);
    
    pushMatrix();
    for (int i = 0; i < numLines / 2; i++) {
      //strokeWeight(random(1.7, 3));
      stroke(color(h, s, b + random(-MAXBCHANGE, MAXBCHANGE)));
      drawShape();
      
      translate(inwards.x, inwards.y);  
    }
    popMatrix();
  }
}
