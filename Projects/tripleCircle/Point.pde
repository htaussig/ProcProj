//effectively a planet (a point with gravity)
public class Point {
  PVector pos;
  PVector vel;
  PVector acc; 

  float mass;

  //current angle
  float angle;
  //angular velocity
  float rotateV;

  color col;

  //all the points to connect to if close enough for gravity
  ArrayList<Point> connectPoints;

  Point(float x, float y) {
    mass = random(1, 5);

    pos = new PVector(x, y);
    vel = PVector.fromAngle(random(TWO_PI)).setMag(random(MAXSTARTINGVEL) / mass);
    acc = new PVector(0, 0);

    rotateV = random(-radians(4), radians(4));

    col = color(255);

    connectPoints = new ArrayList<Point>();
  }

  Point(float x, float y, color col) {
    this(x, y);
    this.col = col;
  }

  float getX() {
    return pos.x;
  }

  float getY() {
    return pos.y;
  }

  void setColor(color newCol) {
    col = newCol;
  }

  void applyForce(PVector f) {
    f.mult(1 / mass);
    acc.add(f);
  }

  void addConnectPoint(Point otherPoint) {
    connectPoints.add(otherPoint);
  }

  void displayConnectPoints(Circle lineCircle) {
    //3 or 2 works quite well
    strokeWeight(LINESTROKEWEIGHT);
    //stroke(255, 100);
    for (Point p : connectPoints) {
      stroke(p.col);
      //println(p.col);
      float dist1 = PVector.dist(p.pos, lineCircle.pos);
      float dist2 = PVector.dist(pos, lineCircle.pos);

      float r = lineCircle.getRadius();

      float x1 = p.getX();
      float y1 = p.getY();
      float x2 = pos.x;
      float y2 = pos.y;

      if (dist1 <= r || dist2 <= r) {

        float dx = x2 - x1;
        float dy = y2 - y1;

        float m;
        if (dy == 0) {
          m = 9999999;
        } else {
          m = dy / dx;
        }
        if (dist1 > r || dist2 > r) {
          PVector realPoint = getRealPoint(p.pos, pos, r, lineCircle.pos);
          if (dist1 > r) {
            x1 = realPoint.x;
            y1 = realPoint.y;
            line(realPoint.x, realPoint.y, x2, y2);
          }
          else{
            x2 = realPoint.x;
            y2 = realPoint.y;
            line(x1, y1, realPoint.x, realPoint.y);
          }          
        }
        
        line(x1, y1, x2, y2);
      }
    }
    connectPoints.clear();
  }

  PVector getRealPoint(PVector p1, PVector p2, float r, PVector centerP) {
    
    float x1 = p1.x - centerP.x;
    float x2 = p2.x - centerP.x;
    float y1 = p1.y - centerP.y;
    float y2 = p2.y - centerP.y;

    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    
    float dr = sqrt((dx * dx) + (dy * dy));
    
    float bigD = (x1 * y2) - (x2 * y1);
    
    float discrim = sqrt(abs((r*r) * (dr * dr) - (bigD * bigD)));
    
    float xPart = getSign(dy) * dx * discrim;
    
    float newX1 = (bigD * dy + xPart) / (dr*dr);
    float newX2 = (bigD * dy - xPart) / (dr*dr);
    
    float yPart = abs(dy) * discrim;
    
    float newY1 = (-bigD * dx + yPart) / (dr*dr);
    float newY2 = (-bigD * dx - yPart) / (dr*dr);
    
    newX1 += centerP.x;
    newX2 += centerP.x;
    newY1 += centerP.y;
    newY2 += centerP.y;

    if(isOnSegment(p1.x, p1.y, p2.x, p2.y, newX1, newY1)){
      return new PVector(newX1, newY1);
    }
    else{
      return new PVector(newX2, newY2);
    }
    
    

    //float a = (m + 1);
    //float b = (-2 * m * m * x1) + (2 * m * y1);
    //float c = (m * m * x1 * x1) - (2 * m * y1 * x1) + (y1 * y1);

    //float determ = (b * b) - (4 * a * c);

    //float ansX1 = (-b + sqrt(abs(determ))) / (2 * a);
    //float ansX2 = (-b - sqrt(abs(determ))) / (2 * a);

    //float ansY1 = (r * r) - (ansX1 * ansX1);
    //float ansY2 = (r * r) - (ansX2 * ansX2);

    //noStroke();
    //fill(255, 240, 255);
    //print(ansX1, ansY1);
    //ellipse(ansX1, ansY1, 10, 10);
    //ellipse(ansX2, ansY2, 10, 10);
  }
  
  int getSign(float x){
    if(x < 0){
      return -1;
    }
    return 1;
  }

  boolean isOnSegment(float x1, float y1, float x2, float y2, float px, float py) {

    // get distance from the point to the two ends of the line
    float d1 = dist(px, py, x1, y1);
    float d2 = dist(px, py, x2, y2);

    // get the length of the line
    float lineLen = dist(x1, y1, x2, y2);

    // since floats are so minutely accurate, add
    // a little buffer zone that will give collision
    float buffer = 0.1;    // higher # = less accurate

    // if the two distances are equal to the line's 
    // length, the point is on the line!
    // note we use the buffer here to give a range, 
    // rather than one #
    if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
      return true;
    }
    return false;
  }


  PVector getIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));

    return new PVector(intersectionX, intersectionY);
  }

  void update() {
    vel.add(acc);
    //vel.setMag(min(vel.mag(), MAXVEL));
    pos.add(vel);
    acc.mult(0);

    edges();

    angle += rotateV;
  }

  void edges() {
    boolean hit = false;
    if (pos.x < -MAXDISTBOUNDS) {
      pos.x = MAXDISTBOUNDS + width;
      hit = true;
    }
    if (pos.x > width + MAXDISTBOUNDS) {
      pos.x = -MAXDISTBOUNDS;
      hit = true;
    }
    if (pos.y < -MAXDISTBOUNDS) {
      pos.y = MAXDISTBOUNDS + height;
      hit = true;
    }
    if (pos.y > height + MAXDISTBOUNDS) {
      pos.y = -MAXDISTBOUNDS;
      hit = true;
    }

    if (hit) {
      resetVelocity();
    }
  }

  void resetVelocity() {
    vel.setMag(vel.mag() / 10);
  }

  void drawTriangle(float r) {
    r *= 4;
    beginShape(TRIANGLE);
    vertex(r, 0);
    vertex(-r * 1 / 2, r * sqrt(3) / 2);
    vertex(-r * 1 / 2, -r * sqrt(3) / 2); 
    endShape(CLOSE);
  }

  void display(boolean displayPoint) {  
    if (displayPoint) {
      //noStroke();
      //strokeWeight(15);
      //stroke(col);
      //fill(col);
      ////ellipse(pos.x, pos.y, 10, 10);
      //point(pos.x, pos.y);
      rectMode(CENTER);
      noStroke();
      fill(col);

      float sideLength = sqrt(mass);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(angle);
      //rect(0, 0, 6 * sideLength, 6 * sideLength);
      drawTriangle(sideLength);      
      popMatrix();
    }
  }
}
