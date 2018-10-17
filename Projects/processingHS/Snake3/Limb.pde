class Limb{
   float x, y, z;
 float size;
 int red; //for gradient
 
 Limb(float xin, float yin, float zin, int rin){
  x = xin;
  y = yin;
  z = zin;
  red = rin;
  size = Snake.limbSize;
 }
  
  void setPos(float newX, float newY, float newZ){
   x = newX;
   y = newY;
   z = newZ;
  }
  
  void display(){
    pushMatrix();
   translate(x, y, z);
   fill(red, 0, 255); 
   box(size);
   popMatrix();
  }
  
}