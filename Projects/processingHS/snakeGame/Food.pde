class Food{
  float gridWidth, gridHeight, x, y;
 float size = 16;
 Snake snake;
 
  Food(float gridWidthin, float gridHeightin, Snake snakein){
    gridWidth = gridWidthin;
    gridHeight = gridHeightin;
    snake = snakein;
    
    newPosition();
    
  }
  
  void newPosition(){
    x = getNewX();
    y = getNewY();
    
    for(Limb limb : snake.limbs){
      if(x == limb.x && y == limb.y){
      newPosition();
      return;
      }
    }
    
  }
  
  private float getNewX(){
    return (int) random(gridWidth) * (size + 2);
  }
  
  private float getNewY(){
    return (int) random(gridHeight) * (size + 2);
  }
  
  void display(){
    fill(255, 255, 50);
   rect(x, y, size, size); 
  }
  
}