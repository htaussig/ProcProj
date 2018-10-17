class Limb{
 float x, y;
 float size = 16;
 
 Limb(int xin, int yin){
  x = xin;
  y = yin;
 }
  
  void setPos(float newX, float newY){
   x = newX;
   y = newY;
  }
  
  void display(){
   rect(x, y, size, size);
  }
  
}