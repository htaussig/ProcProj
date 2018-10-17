public class Swing{
 
  float x, y;
  float l;
  float t;
  float f;
  
  public Swing(float x_, float y_, float l_, float f_){
    x = x_;
    y = y_;
    l = l_;
    f = f_;
    t = 0;
  }
  
  public float getA(){
    return (PI / 4) * sin(t * f);
  }
  
  public float getX2(){
    float a = getA();
    return x + sin(a) * l;
  }
  
  public float getY2(){
    float a = getA();
    return y + cos(a) * l;
  }
  
  void display(){
   stroke(0);
   pushMatrix();
   translate(x, y);
   line(0, 0, sin(getA()) * l, cos(getA()) * l);
   ellipse(sin(getA()) * l, cos(getA()) * l, 10, 10);
   popMatrix();
  }
  
}