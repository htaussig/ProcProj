Snake snake;
float length = 5;
final int U = 0;
final int R = 1;
final int D = 2;
final int L = 3;

int gridWidth;
int gridHeight;

int frameR = 8;

Food food;

void setup(){
 size(578, 578);
 translate(2, 2);
 gridWidth = width / (16 + 2);
 gridHeight = height / (16 + 2);
 background(0);
 frameRate(frameR);
 noStroke();
 snake = new Snake(0, 0, length);
 food = new Food(gridWidth, gridHeight, snake);
}


void draw(){
  translate(2, 2);
  background(0);
  checkDeath();
  checkEat();
  food.display();
  snake.move();
  snake.display();
}

void die(){
  println(snake.limbs.size());
  stop();
}

void checkDeath(){
  Limb front = snake.limbs.get(0);
  
  for(Limb limb : snake.limbs){
    if(limb != front && limb.x == front.x && limb.y == front.y){
     die(); 
    }
  }
  
  if(front.x < 0 || front.y < 0 || front.x > width || front.y > height){
    die();
  }
}

void checkEat(){
  if(snake.limbs.get(0).x == food.x && snake.limbs.get(0).y == food.y){
    ate();
  }
}

void ate(){
  snake.setGrowing(true); 
  food.newPosition();
  frameR++;
  frameRate(frameR);
}

void keyPressed(){
 if(key == 'w'){
  snake.setDirection(U); 
 }
 else if(key == 'd'){
  snake.setDirection(R); 
 }
 else if(key == 's'){
  snake.setDirection(D); 
 }
 else if(key == 'a'){
  snake.setDirection(L); 
 }
}