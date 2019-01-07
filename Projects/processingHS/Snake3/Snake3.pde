

Snake snake;
boolean alive = true;
int snakeLength = 5;
Food food;

final int X = 1;
final int Y = 2;
final int Z = 3;

final int W = 4;
final int A = 5;
final int S = -4;
final int D = -5;


final float gridSize = 16;
final float gridBoxSize = Snake.limbSize + Snake.limbSpacing;
final float boxSize = (gridBoxSize) * gridSize;

float angle = 0;

final float CAMERA = 3.1 / 4;
final float DEPTH = 596;

ArrayList<float[]> cameraList;

final static float threshold = radians(3);
final static float angleChange = radians(2.2);

final static float gridSpacing = 8; //how many rows the grid skips before creating a line

float[] cams = new float[3];
float[] nextCams = new float[3];


void setup(){
 size(800, 800, P3D);
 background(0);
 noStroke();
 frameRate(60);
 snake = new Snake(0, 0, 0, snakeLength);
 food = new Food(gridSize, snake);
 cameraList = new ArrayList<float[]>();

 //f = createFont("Comic Sans MS", 22);
 // Variable to store text currently being typed
  /*String typing = "";*/
}

void reInit(){
  background(0);
 noStroke();
 frameRate(60);
 snake = new Snake(0, 0, 0, snakeLength);
 food = new Food(gridSize, snake);
 cameraList = new ArrayList<float[]>();
 trying = -20;
}

void draw(){
    background(0);

    cameraStuff();
    noFill();
    drawAxes();
    drawGrid();
    stroke(255,255,255);
    noStroke();
    if(frameCount % 8 == 0 && alive){
      snake.move();
      checkDeath();
      checkEat();  //not sure if it should be before or after snake.move
    }
    food.display();
    snake.display();

  if(!alive){
    cameraList.clear();
    if(isScoreMenu){
      //drawNameScreen();
    }
    else{
      drawClickAgain();
    }
  }

}

void checkDeath(){
  Limb front = snake.limbs.get(0);

  for(Limb limb : snake.limbs){
    if(limb != front && limb.x == front.x && limb.y == front.y && limb.z == front.z){
     die();
    }
  }

  float bound = (boxSize / 2);  //because the snake is centered and not on the edge

  if(front.x < -boxSize / 2 || front.y < -boxSize / 2 || front.z < -boxSize / 2 ||
  front.x > bound || front.y > bound || front.z > bound){
    die();
  }
}

void die(){
  alive = false;
  /*score = snake.limbs.size();
  isScoreMenu = true;*/
  cameraList.clear();
}

void drawAxes(){
  stroke(232, 25, 25);
  line(0,0,0, boxSize / 2, 0, 0);

  stroke(237, 123, 30);
  line(0,0,0, -boxSize / 2, 0, 0);

  stroke(18, 229, 39);
  line(0,0,0, 0, boxSize / 2, 0);

  stroke(246, 249, 24);
  line(0,0,0, 0, -boxSize / 2, 0);

  stroke(23, 23, 249);
  line(0,0,0, 0, 0, boxSize / 2);

  stroke(192, 23, 249);
  line(0,0,0, 0, 0, -boxSize / 2);
}

void drawGrid(){
  stroke(254, 40);
  for(int k = 0; k < 3; k++){
    pushMatrix();
    if(k == 1){
      rotateZ(radians(90));
    }
    else if(k == 2){
      rotateY(radians(90));
    }

    for(int i = 0; i <= gridSize; i += gridSpacing){
      float y = (i - (gridSize / 2.0)) * gridBoxSize;

      for(int j = 0; j <= gridSize; j += gridSpacing){
        float x = boxSize / 2;
        float z = (j - (gridSize / 2.0)) * gridBoxSize;

        line(x, y, z, -x, y, z);

      }
    }
    popMatrix();
  }
}

void cameraStuff(){

  camera(boxSize * CAMERA, -boxSize * CAMERA, DEPTH, 0, 0, 0, 0, 1, 0);

  translate(20, -30, 0);

  slowRotate();

  ambientLight(128, 128, 128);
  directionalLight(242, 181, 181, -2, 1, 3);
  directionalLight(186, 242, 241, 3, -1, -2);
}

void slowRotate(){

  nextCams[0] = snake.camX;
  nextCams[1] = snake.camY;
  nextCams[2] = snake.camZ;

  for(int i = 0; i < cams.length; i++){
    float nextCam = nextCams[i];
    float cam = cams[i];

    float difference = nextCam - cam;

    if(abs(difference) >= PI){
     if(difference < 0){
       difference += PI * 2;
     }
     else{
      difference -= PI * 2;
     }
    }

     if(difference > radians(3)){
        cam += radians(2);
      }
      else if(difference < -radians(3)){
        cam -= radians(2);
      }
      else{
       cam = nextCam;
      }

    cams[i] = cam;
     nextCams[i] = nextCam;
  }

  for(float[] axisDegree : cameraList){  //could make these their own object

    float axis = axisDegree[0];
    float degrees = axisDegree[1];
    float degreeTarget = axisDegree[2];
    float difference = degreeTarget - degrees;

    if(axisDegree[1] != degreeTarget){ //not a necessary line but lets most of the list skip this step quickly
      if(difference <= -threshold){
        axisDegree[1] -= angleChange;
      }
      else if(difference >= threshold){
        axisDegree[1] += angleChange;
      }
      else{
       axisDegree[1] = degreeTarget;
      }
    }

    if(axis == X){
      rotateX(degrees);
    }
    else if(axis == Y){
      rotateY(degrees);
    }
  }
}

void checkEat(){
  Limb front = snake.limbs.get(0);

  if(front.x == food.x && front.y == food.y && front.z == food.z){
    ate();
  }
}

void ate(){
  snake.addLimbs(4);
  food.newPosition();
}

void mousePressed(){
  if(!alive){
    /*if(isScoreMenu){
     recordScore("3dw4rd");
    }*/
    reInit();
    alive = true;
  }
}

void keyPressed(){

  if(alive){
      if(key == 'w'){
    snake.setDirection(W);
     }
     else if(key == 'd'){
      snake.setDirection(D);
     }
     else if(key == 's'){
      snake.setDirection(S);
     }
     else if(key == 'a'){
      snake.setDirection(A);
      }

       /*if(key == ' '){
        ate();
       }*/
  }
  else if(isScoreMenu && key == (int) '\n') {
    if(!typing.equals("")){
      //recordScore(typing);        //need to get this to work in online version
      isScoreMenu = false;
    }
  }
  else if(key == 8){
    int end = typing.length() - 1;

    if(end >= 0){
      typing = typing.substring(0, typing.length() - 1);
    }
    else{
     typing = "";
    }

  }
  else if(key <= (int) 'z' && key >= (int) 'A' && key != (int) ':'){ //a colon would mess up the leaderboards
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key;
  }
}
