public class Curve {
  float x, y, w, h, a, angBetween;
  Curve(float x_, float y_, float w_, float h_, float a_, float angBetween_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    a = a_;
    angBetween = angBetween_;
  }

  void setA(float newA){
    a = newA;
  }
  
  //void rot(float numA){
    
  //}

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(a);
    
    PVector pos1 = new PVector(0, h);
    PVector pos2 = new PVector(0, 0);
    //float x1 = 0;
    //float y1 = h;
    //float x2 = 0;
    //float y2 = 0;
    PVector d1 = PVector.mult(pos1, -1).mult(1 / NUMLINES);
    PVector d2 = PVector.mult(pos1, 1).mult(1 / NUMLINES).rotate(angBetween);
    //PVector d2 = PVector.mult(pos1, 1);
    //d2.mult(1 / NUMTIMES);
    //float dx = (w / NUMTIMES) * sin(angBetween);
    //float dy = (h / NUMTIMES) * cos(angBetween);
    for (int i = 0; i <= NUMLINES; i++) {
      line(pos1.x, pos1.y, pos2.x, pos2.y);
      pos1.add(d1);
      pos2.add(d2);
    }
    popMatrix();
  }
}
