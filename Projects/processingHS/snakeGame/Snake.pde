class Snake{
  final int U = 0;
  final int R = 1;
  final int D = 2;
  final int L = 3;
  
  int x, y;
  ArrayList<Limb> limbs = new ArrayList<Limb>();
  float limbSize = 16;
  float limbSpacing = 2;
  int direction = R;
  int nextDirection = direction;
  int growing = 0;
  
  
  Snake(int xin, int yin, float lengthin){
    x = xin;
    y = yin;
   for(int i = 0; i < lengthin; i++){
     Limb limb = new Limb(x, y);
     limbs.add(0, limb);
     x += limbSize + limbSpacing;
   }
   x -= limbSize + limbSpacing;
  }
  
  void move(){
    direction = nextDirection;
    Limb backLimb = limbs.get(limbs.size() - 1);
    setNextPos(backLimb);
    Limb frontLimb = new Limb(x, y);
    frontLimb.setPos(x, y);
    if(growing == 0){
      limbs.remove(backLimb);
    }
    else{
     growing--;
    }
    limbs.add(0, frontLimb);
  }
  
  void setDirection(int newD){        //can miss the double quick turn
   if((newD - direction) % 2 == 0){
     return;
   }
   nextDirection = newD;
  }
  
  private void setNextPos(Limb backLimb){
    if(direction == R){
      x += limbSize + limbSpacing;
    }
    if(direction == L){
      x -= limbSize + limbSpacing;
    }
    if(direction == U){
      y -= limbSize + limbSpacing;
    }
    if(direction == D){
      y += limbSize + limbSpacing;
    }
    
  }
  
  void setGrowing(boolean temp){
    growing += 3;
  }
  
  void display(){
    fill(255);
    for(Limb limb : limbs){
     limb.display(); 
    }
  }
  
}