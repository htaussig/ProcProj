public class DotCircle{
  
  float total;
  float x, y, d, percent;
  color col;
  
  public DotCircle(float x_, float y_, float d_, color col_){
    col = col_;
    x = x_;
    y = y_;
    d = d_;
    total = 720 * 2;
    percent = 0;
  }
  
  void addPercent(float add){
    percent += add;
  }
  
  void display(){
   noFill();
   stroke(col);
   ellipse(x, y, d, d);
   PVector dotPos = PVector.fromAngle((percent * 2 * PI / total) - PI / 2).mult(d / 2);
   float dotX = x + dotPos.x;
   float dotY = y + dotPos.y;
   noStroke();
   fill(color(0));
   ellipse(dotX, dotY, 9, 9);
  }
}