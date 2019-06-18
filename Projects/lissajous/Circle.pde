public class Circle {
  float x, y, r, a;
  boolean vert;
  color col;

  public Circle(float x_, float y_, float r_, float a_, boolean vert_) {
    x = x_;
    y = y_;
    r = r_;
    a = a_;
    vert = vert_;

    col = setColor();
  }

  void rot(float i) {
    a += i;
  }

  float getPointX() {
    return x + r * cos(a);
  }

  float getPointY() {
    return y + r * sin(a);
  }

  color setColor() {
    float v = 120;
    if (vert) {
      v = map(x, 0, width, 155, 215);
    } else {
      v = map(y, 0, height, 185, 85);
    }   

    return color(v, 255, 255);
  }
  
  color getColor(){
   return col; 
  }

  void display() {
    pushMatrix();
    stroke(col);
    noFill();
    strokeWeight(2);
    translate(x, y);
    ellipse(0, 0, d, d);

    translate(r * cos(a), r * sin(a));
    fill(255);
    ellipse(0, 0, 10, 10);

    stroke(255, 100);
    if (vert) {
      line(0, 0, 0, height);
    } else {
      line(0, 0, width, 0);
    }    
    popMatrix();
  }
}
