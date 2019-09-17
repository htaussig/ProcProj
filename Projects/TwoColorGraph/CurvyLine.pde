public class CurvyLine {

  float ROTATEMAG = .05;
  float VMAG = 1;
  float AMAG = .1;

  ArrayList<PVector> points = new ArrayList<PVector>();
  PVector pos;
  PVector v;
  PVector a;
  float startX, startY;
  float tAdd = random(-100000, 100000);

  boolean done = false;

  public CurvyLine(float x, float y) {
    startX = x;
    startY = y;
    this.pos = new PVector(x, y);

    gen();
  }

  //generate a curvy line
  public void gen() {
    points.add(new PVector(startX, startY));
    float vMag = 1;
    float aMag = 0;

    if (startX == 0) {
      aMag = 0;
    } else if (startX == width) {
      aMag = PI;
    } else if (startY == 0) {
      aMag = PI / 2;
    } else if (startY == height) {
      aMag = 3 * PI / 2;
    }

    v = PVector.fromAngle(aMag).mult(vMag);
    a = PVector.fromAngle(aMag).mult(AMAG);
  }

  void update() {
    v.add(a);
    if (v.mag() > VMAG) {
      v.setMag(VMAG);
    }   
    pos.add(v);
    a.setMag(AMAG).rotate(getAngle());
    
    edges();
    points.add(pos.copy());
  }

  float getAngle() {
    return map(noise(t + tAdd), 0, 1, -ROTATEMAG, ROTATEMAG);
  }

  void edges() {
    boolean hit = false;
    if (pos.x < 0) {
      pos.x = 0;
      hit = true;
    }
    if (pos.x > width) {
      pos.x = width;
      hit = true;
    }
    if (pos.y < 0) {
      pos.y = 0;
      hit = true;
    }
    if (pos.y > height) {
      pos.y = height;
      hit = true;
    }

    if (hit) {
      if (points.size() > 500) {
        done = true;
        points.add(new PVector(pos.x, pos.y));
        calcLastPoint();
      } else {
        points.clear();
      }
    }
  }
  
  //find the corner between the two edges
  void calcLastPoint(){
    PVector p1 = points.get(0);
    PVector p2 = points.get(points.size() - 1);
    
    float x = -1;
    float y = -1;
    
    if(p1.x == 0 || p1.x == width){
      x = p1.x;
      y = p2.y;
    }
    else{
      if(!(p1.y == 0 || p1.y == width)){
        println("no good coordinate for first point");
        println(p1.x, p1.y);
      }
      y = p1.y;
      x = p2.x;
    }
    
    points.add(new PVector(x, y));  
  }

  void display() {
    //ellipse(pos.x, pos.y, 10, 10);
    if (!done) {
      update();
    }

    //stroke(255);
    //strokeWeight(10);
    fill(255);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    //vertex(points.get(0).x, points.get(0).y);
    endShape(CLOSE);
  }
}
