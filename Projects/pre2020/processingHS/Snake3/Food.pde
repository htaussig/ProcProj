class Food{
  float gridSize; 
  float x, y, z;
 static final float size = Snake.limbSize;
 static final float limbSpacing = Snake.limbSpacing;
 Snake snake;
 
  Food(float boxSizein, Snake snakein){
    gridSize = boxSizein;
    snake = snakein;

    newPosition();
  }
  
  void newPosition(){
    setNewPos();
    
    for(Limb limb : snake.limbs){
      if(x == limb.x && y == limb.y && z == limb.z){
      newPosition();
      return;
      }
    }
    
  }
  
  private void setNewPos(){
    x = ((int) random(-gridSize / 2.0, gridSize / 2.0)) * (size + limbSpacing) + gridBoxSize / 2.0;
    y = ((int) random(-gridSize / 2.0, gridSize / 2.0)) * (size + limbSpacing) + gridBoxSize / 2.0;
    z = ((int) random(-gridSize / 2.0, gridSize / 2.0)) * (size + limbSpacing) + gridBoxSize / 2.0;
  }
  
  void display(){
    pushMatrix();
    translate(x, y, z);
    fill(255, 255, 50);
    box(size);
    popMatrix();
  }
  
}