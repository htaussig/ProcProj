float allow = .01;

public class Connect {

  Vertex v1, v2; 
  
  public Connect(Vertex v1_, Vertex v2_) {
    v1 = v1_;
    v2 = v2_;
  }

  boolean doesIntersect(Connect other) {
    float x1 = v1.pos.x;
    float x2 = v2.pos.x;
    float y1 = v1.pos.y;
    float y2 = v2.pos.y;
    float x3 = other.v1.pos.x;
    float y3 = other.v1.pos.y;
    float x4 = other.v2.pos.x;
    float y4 = other.v2.pos.y;

    float x = findIntersectX(x1, y1, getSlope(x1, y1, x2, y2), x3, y3, getSlope(x3, y3, x4, y4));

    return isInRange(x, x1, x2) && isInRange(x, x3, x4);
  }

  float getSlope(float x1, float y1, float x2, float y2) {
    if (x1 == x2) {
      return 100001;
    }
    return (y2 - y1) / (x2 - x1);
  }

  float findIntersectX(float x1, float y1, float m1, float x3, float y3, float m3) {
    return (getB(x1, y1, m1) - getB(x3, y3, m3)) / (m3 - m1);
  }

  float getB(float x, float y, float m) {
    return (m * -x) + y;
  }

  boolean isInRange(float x, float x1, float x2) {

    float minX = min(x1, x2);
    float maxX = max(x1, x2);

    if (maxX - x > allow && x - minX > allow) {
      return true;
    } else {
      return false;
    }
  }

  /**boolean equals(Connect other) {
    if (PVector.dist(v1.pos, other.v1.pos) == 0 && PVector.dist(v2.pos, other.v2.pos) == 0) {
      return true;
    } else if (PVector.dist(v2.pos, other.v1.pos) == 0 && PVector.dist(v1.pos, other.v2.pos) == 0) {
      return true;
    }
    return false;
  }**/

  void display(float tempCol) {
    colorMode(HSB);
    stroke(color(tempCol % 255, 255, 255));
    line(v1.pos.x, v1.pos.y, v1.pos.z, v2.pos.x, v2.pos.y, v2.pos.z);
    colorMode(RGB);
  }
}
