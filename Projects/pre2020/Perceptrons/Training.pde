float m = random(-1, 1);
float b = random(-1, 1);

float f(float x) {
  // y = mx + b
  return m * x + b;
}

class Point {
  float x; 
  float y;
  float bias = 1;
  int label;

  int size = 32;

  Point() {
    this(random(-1, 1), random(-1, 1));
  } 
  
  Point(float x_, float y_) {
    x = x_;
    y = y_;

    float lineY = f(x);
    if (y > lineY) {
      label = 1;
    } else {
      label = -1;
    }
  } 

  void show() {
    stroke(0);
    if (label == 1) {
      fill(255);
    } else {
      fill(0);
    }

    ellipse(getPX(), getPY(), size, size);
  }

  float getPX() {
    return map(x, -1, 1, 0, width);
  }

  float getPY() {
    return map(y, -1, 1, height, 0);
  }
}
