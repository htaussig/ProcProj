class Snake{
  
final int X = 1;
final int Y = 2;
final int Z = 3;
  
final int W = 4;
final int A = 5;
final int S = -4;
final int D = -5;
  
  
  float x, y, z;
  static final int limbSize = 24;
  static final int limbSpacing = 5;
  
  float camX, camY, camZ = 0;
  
  int direction = -Z;
  int upD = -Y;
  int rightD = X;
  int nextDirectionBut = 0;
  int growing = 0;
  
  int red;
  boolean redIncreasing;  //this are for the gradient
  
  ArrayList<Limb> limbs = new ArrayList<Limb>();
  
 Snake(int xin, int yin, int zin, int lengthin){
   x = xin + gridBoxSize / 2.0;
   y = yin + gridBoxSize / 2.0;
   z = boxSize / 2.0 - gridBoxSize / 2.0;
   
   for(int i = 0; i < lengthin; i++){
     Limb limb = new Limb(x, y, z, getRed());
     limbs.add(0, limb);
     z -= limbSize + limbSpacing;
   }
   z += limbSize + limbSpacing;
 }
 
 void setDirection(int newD){     
   nextDirectionBut = newD;
  }
  
  void getNextDirection(){
   
    if(nextDirectionBut == 0){
     return; 
    }
    
    int button = nextDirectionBut;
    
    shiftCamera(button, direction, upD, rightD);
    
    if(button == W){
     int temp = direction;
     direction = upD;
     upD = -temp;
    }
    else if(button == S){
      int temp = upD;
      upD = direction;
      direction = -temp;
    }
    else if(button == D){
      int temp = direction;
      direction = rightD;
      rightD = -temp;
    }
    else if(button == A){
      int temp = rightD;
      rightD = direction;
      direction = -temp;
    }
   
   
   
  }

  void shiftCamera(int button, int direction1, int upD1, int rightD1){
 
   float[] axisDegree = new float[3];
    
   axisDegree[1] = 0;
   int degrees = 90;
   
    if(button == D){
      axisDegree[0] = Y;
    }
    else if(button == A){
      axisDegree[0] = Y;
      degrees *= -1;    
    }
    else if(button == W){
      axisDegree[0] = X;
    }
    else if(button == S){
     axisDegree[0] = X;
      degrees *= -1;
    }
    
    axisDegree[2] = radians(degrees);   
    cameraList.add(0, axisDegree);  
  }
  
 int getRed(){
  if(red <= 0){
   redIncreasing = true;
  }
  else if(red >= 255){
   redIncreasing = false; 
  }
  if(redIncreasing){
   return red += 2; 
  }
  return red -= 2;
 }
 
 void move(){
   getNextDirection();
    Limb backLimb = limbs.get(limbs.size() - 1);
    setNextPos();
    Limb frontLimb = new Limb(x, y, z, getRed());
    frontLimb.setPos(x, y, z);
    if(growing == 0){
      limbs.remove(backLimb);
    }
    else{
     growing--;
    }
    limbs.add(0, frontLimb);
    
    nextDirectionBut = 0;
  }
  
  private void setNextPos(){
    if(direction == X){
      x += limbSize + limbSpacing;
    }
    else if(direction == -X){
      x -= limbSize + limbSpacing;
    }
    else if(direction == -Y){
      y -= limbSize + limbSpacing;
    }
    else if(direction == Y){
      y += limbSize + limbSpacing;
    }
    else if(direction == -Z){
      z -= limbSize + limbSpacing;
    }
    else if(direction == Z){
      z += limbSize + limbSpacing;
    }
  }
 
 void addLimbs(int temp){
    growing += temp;
  }
 
 void display(){
    for(Limb limb: limbs){
      limb.display();
    }
  }
 
}