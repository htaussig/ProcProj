

Snake snake;
boolean alive = true;
int snakeLength = 5;
Food food;
PoisonRing poisonRing = null;

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

ArrayList<Poison> poisons;

float lastDiff = 0;
int leveling = 100;

//0 = title
//1 = game
int mode = 0;

//"15,-13,3|15,-11,3|15,-11,1|15,-9,1|15,-7,1|15,-7,3|15,-5,3|15,-5,5|15,-7,5|15,-9,5|15,-11,5|15,-13,5|13,-13,5|13,-13,7|13,-13,9|13,-13,11|13,-13,13|15,-13,13|15,-13,11|15,-13,9|15,-11,9|15,-11,11|15,-9,11|15,-9,9|15,-7,9|15,-5,9|15,-5,11|15,-5,13|15,-5,15|15,-7,15|13,-7,15|13,-9,15|15,-9,15|15,-11,15|15,-13,15|13,-13,15|11,-13,15|11,-11,15|11,-9,15|11,-7,15|11,-5,15|11,-5,13|11,-5,11|9,-5,11|7,-5,11|7,-5,13|7,-5,15|7,-7,15|7,-9,15|5,-9,15|3,-9,15|3,-11,15|3,-13,15|5,-13,15|7,-13,15|7,-11,15|7,-9,15|5,-9,15|3,-9,15|3,-7,15|3,-5,15|3,-5,13|3,-5,11|1,-5,11|-1,-5,11|-1,-7,11|-1,-9,11|-1,-11,11|-1,-13,11|-1,-13,13|-1,-13,15|-1,-11,15|-1,-9,15|-1,-7,15|-1,-5,15|-3,-5,15|-3,-7,15|-3,-9,15|-5,-9,15|-5,-11,15|-5,-13,15|-7,-13,15|-7,-11,15|-7,-9,15|-7,-7,15|-7,-5,15|-7,-5,13|-7,-5,11|-9,-5,11|-11,-5,11|-13,-5,11|-15,-5,11|-15,-5,13|-15,-5,15|-13,-5,15|-11,-5,15|-11,-7,15|-11,-9,15|-13,-9,15|-15,-9,15|-15,-11,15|-15,-13,15|-13,-13,15|-11,-13,15"
String str = "13,-13,3|15,-13,3|15,-13,1|15,-11,1|15,-11,-1|15,-9,-1|15,-7,-1|15,-7,1|15,-5,1|15,-5,3|15,-5,5|15,-7,5|15,-9,5|15,-11,5|15,-13,5|13,-13,5|13,-13,7|13,-13,9|13,-13,11|13,-13,13|15,-13,13|15,-13,11|15,-13,9|15,-11,9|15,-9,11|15,-9,9|15,-7,9|15,-5,9|15,-5,11|15,-5,13|15,-5,15|15,-7,15|13,-9,15|15,-11,15|15,-13,15|11,-13,15|11,-11,15|11,-9,15|11,-7,15|11,-5,15|11,-5,13|11,-5,11|9,-5,11|7,-5,11|7,-5,13|7,-5,15|7,-7,15|7,-9,15|5,-9,15|3,-9,15|3,-11,15|3,-13,15|5,-13,15|7,-13,15|7,-11,15|7,-9,15|5,-9,15|3,-9,15|3,-7,15|3,-5,15|3,-5,13|3,-5,11|1,-5,11|-1,-5,11|-1,-7,11|-1,-9,11|-1,-11,11|-1,-13,11|-1,-13,13|-1,-13,15|-1,-11,15|-1,-9,15|-1,-7,15|-1,-5,15|-3,-5,15|-3,-7,15|-3,-9,15|-5,-9,15|-5,-11,15|-7,-13,15|-7,-11,15|-7,-9,15|-7,-7,15|-7,-5,15|-7,-5,13|-7,-5,11|-9,-5,11|-11,-5,11|-13,-5,11|-15,-5,11|-15,-5,13|-15,-5,15|-13,-5,15|-11,-5,15|-11,-7,15|-11,-9,15|-13,-9,15|-15,-9,15|-15,-11,15|-15,-13,15|-13,-13,15|-11,-13,15";
Snake titleSnake = new Snake(str);

boolean RECORDING = false;

void setup() {
  size(800, 800, P3D);
  background(0);
  noStroke();
  frameRate(60);
  snake = new Snake(0, 0, 0, snakeLength);
  poisons = new ArrayList<Poison>();
  food = new Food();
  cameraList = new ArrayList<float[]>();

  //f = createFont("Comic Sans MS", 22);
  // Variable to store text currently being typed
  /*String typing = "";*/
}

void reInit() {
  mode = 1;
  background(0);
  noStroke();
  frameRate(60);
  snake = new Snake(0, 0, 0, snakeLength);
  food = new Food();
  poisons.clear();
  poisonRing = null;
  cameraList = new ArrayList<float[]>();
  lastDiff = 0;
  leveling = 100;
  //trying = 520;
}

void draw() {
  //drawAlways();
  background(0);

  if (mode == 0) {
    drawTitle();
  } else {
    drawGame();
  }
  
  if(RECORDING){
    saveFrame("movie/snak4-######.png");
  }
}

void drawAlways() {
  cameraStuff();
  noFill();
  drawAxes();
  drawGrid();
}

void drawTitle() {
  background(0);
  cameraStuff();
  noFill();
  rotateY(-.18);
  drawAxes();
  drawGrid();
  titleSnake.titleDisplay();
}

void drawGame() {

  //won't show up in processing
  if (leveling > 0) {
    //println("yeah");
    //println(leveling);
    pushMatrix();
    //translate(0, -boxSize / 2, boxSize / 2);
    noStroke();
    fill(0, 255, 0);
    String str = "Level: " + ((int) lastDiff + 1) + "!";
    text(str, trying + 400, 260, 400);
    popMatrix();
    leveling--;
  }

  drawAlways();

  stroke(255, 255, 255);
  noStroke();
  if (frameCount % 8 == 0 && alive) {
    snake.move();
    checkDeath();
    checkEat();  //not sure if it should be before or after snake.move
  }
  food.display();
  snake.display();
  for (Poison p : poisons) {
    p.display();
  }
  if (poisonRing != null) {
    poisonRing.display();
  }

  if (!alive) {
    cameraList.clear();
    if (isScoreMenu) {
      //drawNameScreen();
    } else {
      //drawClickAgain();
      drawNameScreen();
    }
  }
}

boolean isSamePos(PVector pos1, PVector pos2) {
  return (pos1.x == pos2.x && pos1.y == pos2.y && pos1.z == pos2.z);
}

void checkDeath() {
  PVector front = snake.limbs.get(0).pos;

  for (Limb limb : snake.limbs) {
    if (limb != snake.limbs.get(0) && isSamePos(limb.pos, front)) {
      die();
    }
  }


  for (Poison p : poisons) {
    if (isSamePos(front, p.pos)) {
      die();
    }
  }

  if (poisonRing != null) {
    for (Poison p2 : poisonRing.ring) {
      if (isSamePos(front, p2.pos)) {
        die();
      }
    }
  }


  float bound = (boxSize / 2);  //because the snake is centered and not on the edge

  if (front.x < -boxSize / 2 || front.y < -boxSize / 2 || front.z < -boxSize / 2 ||
    front.x > bound || front.y > bound || front.z > bound) {
    die();
  }
}

void die() {
  alive = false;
  //num = (int) snake.limbs.size();

  //document.getElementById('score').textContent = num;
  //document.getElementById('tries').value = num;
  //document.getElementById('submit').click();

  //doodoo();
  //isScoreMenu = true;
  cameraList.clear();
}


void drawAxes() {
  stroke(232, 25, 25);
  line(0, 0, 0, boxSize / 2, 0, 0);

  stroke(237, 123, 30);
  line(0, 0, 0, -boxSize / 2, 0, 0);

  stroke(18, 229, 39);
  line(0, 0, 0, 0, boxSize / 2, 0);

  stroke(246, 249, 24);
  line(0, 0, 0, 0, -boxSize / 2, 0);

  stroke(23, 23, 249);
  line(0, 0, 0, 0, 0, boxSize / 2);

  stroke(192, 23, 249);
  line(0, 0, 0, 0, 0, -boxSize / 2);
}

void drawGrid() {
  strokeWeight(2);
  stroke(254, 40);
  for (int k = 0; k < 3; k++) {
    pushMatrix();
    if (k == 1) {
      rotateZ(radians(90));
    } else if (k == 2) {
      rotateY(radians(90));
    }

    for (int i = 0; i <= gridSize; i += gridSpacing) {
      float y = (i - (gridSize / 2.0)) * gridBoxSize;

      for (int j = 0; j <= gridSize; j += gridSpacing) {
        float x = boxSize / 2;
        float z = (j - (gridSize / 2.0)) * gridBoxSize;

        line(x, y, z, -x, y, z);
      }
    }
    popMatrix();
  }
}

void cameraStuff() {

  camera(boxSize * CAMERA, -boxSize * CAMERA, DEPTH, 0, 0, 0, 0, 1, 0);

  translate(20, -30, 0);

  slowRotate();

  ambientLight(128, 128, 128);
  directionalLight(242, 181, 181, -2, 1, 3);
  directionalLight(186, 242, 241, 3, -1, -2);
}

void slowRotate() {

  nextCams[0] = snake.camX;
  nextCams[1] = snake.camY;
  nextCams[2] = snake.camZ;

  for (int i = 0; i < cams.length; i++) {
    float nextCam = nextCams[i];
    float cam = cams[i];

    float difference = nextCam - cam;

    if (abs(difference) >= PI) {
      if (difference < 0) {
        difference += PI * 2;
      } else {
        difference -= PI * 2;
      }
    }

    if (difference > radians(3)) {
      cam += radians(2);
    } else if (difference < -radians(3)) {
      cam -= radians(2);
    } else {
      cam = nextCam;
    }

    cams[i] = cam;
    nextCams[i] = nextCam;
  }

  for (float[] axisDegree : cameraList) {  //could make these their own object

    float axis = axisDegree[0];
    float degrees = axisDegree[1];
    float degreeTarget = axisDegree[2];
    float difference = degreeTarget - degrees;

    if (axisDegree[1] != degreeTarget) { //not a necessary line but lets most of the list skip this step quickly
      if (difference <= -threshold) {
        axisDegree[1] -= angleChange;
      } else if (difference >= threshold) {
        axisDegree[1] += angleChange;
      } else {
        axisDegree[1] = degreeTarget;
      }
    }

    if (axis == X) {
      rotateX(degrees);
    } else if (axis == Y) {
      rotateY(degrees);
    }
  }
}

void checkEat() {
  Limb front = snake.limbs.get(0);

  if (isSamePos(front.pos, food.pos)) {
    ate();
  }
}

void ate() {
  snake.addLimbs(4);
  food.newPosition();
  //System.out.println(food.getSafeDistance());
  //if (random(1) < (snake.getSize() - 5) / 100.0 && food.getSafeDistance() >= 2) {
  //  //makePoisonRing(food.pos);
  //  genPoisonOnFood();
  //  if (random(1) < (snake.getSize() - 5) / 200.0) {
  //    poisons.add(new Poison());
  //  }
  //} else {
  //  poisons.add(new Poison());
  //}
  lastDiff += .25;
  //println(lastDiff);
  if (lastDiff < 1) {
    poisons.add(new Poison());
  } else {
    if (lastDiff == floor(lastDiff)) {
      levelUp();
    }
    genPoisonOnFood(food.pos, Math.min((int) lastDiff, 4));
  }
  //println(difficulty);
}

void levelUp() {
  leveling = 100;
  poisons.clear();
}

void mousePressed() {
  if (!alive || mode == 0) {
    /*if(isScoreMenu){
     recordScore("3dw4rd");
     }*/
    reInit();
    alive = true;
  }
}

void keyPressed() {
  saveFrame();
  if (alive) {
    if (key == 'w' ||keyCode == UP) {
      snake.setDirection(W);
    } else if (key == 'd' || keyCode == RIGHT) {
      snake.setDirection(D);
    } else if (key == 's' || keyCode == DOWN) {
      snake.setDirection(S);
    } else if (key == 'a' || keyCode == LEFT) {
      snake.setDirection(A);
    }

    /*if(key == ' '){
     ate();
     }*/
  } else if (isScoreMenu && key == (int) '\n') {
    if (!typing.equals("")) {
      //recordScore(typing);        //need to get this to work in online version
      isScoreMenu = false;
    }
  } else if (key == 8) {
    int end = typing.length() - 1;

    if (end >= 0) {
      typing = typing.substring(0, typing.length() - 1);
    } else {
      typing = "";
    }
  } else if (key <= (int) 'z' && key >= (int) 'A' && key != (int) ':') { //a colon would mess up the leaderboards
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    //String keyChar = String.fromCharCode(key);
    char keyChar = key;
    typing = typing + keyChar;
  }
}


//END OF SNAKE3 CLASS

class Food {
  //float gridSize;
  PVector pos;
  final float size;
  final float limbSpacing;
  //Snake snake;

  Food() {

    size = Snake.limbSize;
    limbSpacing = Snake.limbSpacing;

    newPosition();
  }

  Food(PVector pos_) {

    size = Snake.limbSize;
    limbSpacing = Snake.limbSpacing;

    pos = pos_;
  }

  void newPosition() {
    setNewPos();

    for (Limb limb : snake.limbs) {
      if (isSamePos(limb.pos, pos)) {
        newPosition();
        return;
      }
    }
  }

  private void setNewPos() {
    float x = ((int) random(-gridSize / 2.0, gridSize / 2.0)) * (size + limbSpacing) + gridBoxSize / 2.0;
    float y = ((int) random(-gridSize / 2.0, gridSize / 2.0)) * (size + limbSpacing) + gridBoxSize / 2.0;
    float z = ((int) random(-gridSize / 2.0, gridSize / 2.0)) * (size + limbSpacing) + gridBoxSize / 2.0;

    pos = new PVector(x, y, z);

    for (Limb l : snake.limbs) {
      if (isSamePos(l.pos, pos)) {
        setNewPos();
        return;
      }
    }

    for (Poison p : poisons) {
      if (isSamePos(pos, p.pos)) {
        setNewPos();
        return;
      }
    }
  }

  void display() {
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(255, 255, 50);
    box(size);
    popMatrix();
  }

  //returns closest distance to snake
  int getSafeDistance() {
    float min = 10000;

    for (Limb l : snake.limbs) {
      min = Math.min(min, PVector.dist(pos, l.pos));
    }

    return (int) (min / gridSize);
  }
}

void makePoisonRing(PVector pos) {
  //System.out.println(pos);
  poisonRing = new PoisonRing(pos);
}

//END OF A FOOD CLASS

class Poison extends Food {
  Poison() {
    super();
  }

  Poison(PVector pos) {
    super(pos);
  }


  void display() {
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(255, 0, 0, 220);
    box(size);
    popMatrix();
  }
}

void genPoisonOnFood(PVector pos, int numPois) {
  if (numPois == 0) {
    return;
  }
  PVector[] offsets = new PVector[6];
  for (int i = 0; i < 3; i++) {
    for (int k = -1; k <= 1; k += 2) {
      float x = pos.x;
      float y = pos.y;
      float z = pos.z;
      if (i == 0) {
        x += k * gridBoxSize;
      } else if (i == 1) {
        y += k * gridBoxSize;
      } else {
        z += k * gridBoxSize;
      }


      float bound = (boxSize / 2.0);
      if (!(abs(x) > bound || abs(y) > bound || abs(z) > bound)) {
        PVector adj = new PVector(x, y, z);
        if (poisons.size() == 0) {
          offsets[i * 2 + ((k + 1) / 2)] = adj;
        } else {
          for (int m = 0; m < poisons.size(); m++) {
            Poison p = poisons.get(m);
            if (isSamePos(adj, p.pos)) {
              break;
            } else if (m == poisons.size() - 1) {
              offsets[i * 2 + ((k + 1) / 2)] = adj;
            }
          }
        }
      }
    }
  }

  int sum = 0;
  for (PVector n : offsets) {
    if (n == null) {
      sum++;
    }
  }
  //println(sum);

  if (sum < 4) {
    int index = (int) random(6);
    for (int n = index; n < index + 6; n++) {
      if (offsets[n % 6] != null) {
        Poison p = new Poison(offsets[n % 6]);
        if (p.getSafeDistance() >= 1) {
          poisons.add(p);
          numPois--;
          sum++;
        }
        if (numPois == 0 || sum == 4) {
          break;
        }
      }
    }
  }
}

//END of POISON CLASS

class PoisonRing {
  ArrayList<Poison> ring = new ArrayList<Poison>();

  PoisonRing(PVector pos) {
    float r = random(1);
    float zoff = 0;
    for (float x = -gridBoxSize; x <= gridBoxSize; x += gridBoxSize) {
      for (float y = -gridBoxSize; y <= gridBoxSize; y += gridBoxSize) {
        float xoff = x;
        float yoff = y;
        if (r < .33) {
          zoff = yoff;
          yoff = xoff;
          xoff = 0;
        } else if (r < .66) {
          zoff = xoff;
          xoff = yoff;
          yoff = 0;
        }
        PVector poisPos = new PVector(pos.x + xoff, pos.y + yoff, pos.z + zoff);
        if (!isSamePos(poisPos, pos)) {
          ring.add(new Poison(poisPos));
        }
      }
    }
  }

  void display() {
    for (Poison p : ring) {
      p.display();
    }
  }
}

//End of Poison Ring class

class Limb {
  PVector pos;
  float size;
  int red; //for gradient

  Limb(float xin, float yin, float zin, int rin) {
    pos = new PVector(xin, yin, zin);
    red = rin;
    size = Snake.limbSize;
  }

  void setPos(float newX, float newY, float newZ) {
    pos = new PVector(newX, newY, newZ);
  }


  void display() {
    strokeWeight(1);
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(red, 0, 255, 210);
    box(size);
    popMatrix();
  }
}

//END OF LIMB CLASS

class Snake {

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

  int titleCount = 0;

  ArrayList<Limb> limbs = new ArrayList<Limb>();

  Snake(int xin, int yin, int zin, int lengthin) {
    x = xin + gridBoxSize / 2.0;
    y = yin + gridBoxSize / 2.0;
    z = boxSize / 2.0 - gridBoxSize / 2.0;

    for (int i = 0; i < lengthin; i++) {
      Limb limb = new Limb(x, y, z, getRed());
      limbs.add(0, limb);
      z -= limbSize + limbSpacing;
    }
    z += limbSize + limbSpacing;
  }

  Snake(String str) {
    String[] poses = split(str, "|");
    for (String s : poses) {
      String[] coords = split(s, ",");
      float x = parseInt(coords[0]) * 14.5;
      float y = parseInt(coords[1]) * 14.5;
      float z = parseInt(coords[2]) * 14.5;
      limbs.add(new Limb(x, y, z, getRed()));
    }
    Limb front = limbs.get(0);
    x = front.pos.x;
    y = front.pos.y;
    z = front.pos.z;
  }

  int getSize() {
    return limbs.size();
  }

  void titleDisplay() {
    for (int i = titleCount; i < titleCount + limbs.size() - 6; i++) {
      //println("loopin");
      Limb limb = limbs.get((limbs.size() - 1) - (i % limbs.size()));
      limb.display();
    }
    if (frameCount % 6 == 0 && alive) {
      titleCount++;
    }
  }

  void setDirection(int newD) {
    nextDirectionBut = newD;
  }

  void getNextDirection() {

    if (nextDirectionBut == 0) {
      return;
    }

    int button = nextDirectionBut;

    shiftCamera(button, direction, upD, rightD);

    if (button == W) {
      int temp = direction;
      direction = upD;
      upD = -temp;
    } else if (button == S) {
      int temp = upD;
      upD = direction;
      direction = -temp;
    } else if (button == D) {
      int temp = direction;
      direction = rightD;
      rightD = -temp;
    } else if (button == A) {
      int temp = rightD;
      rightD = direction;
      direction = -temp;
    }
  }

  void shiftCamera(int button, int direction1, int upD1, int rightD1) {

    float[] axisDegree = new float[3];

    axisDegree[1] = 0;
    int degrees = 90;

    if (button == D) {
      axisDegree[0] = Y;
    } else if (button == A) {
      axisDegree[0] = Y;
      degrees *= -1;
    } else if (button == W) {
      axisDegree[0] = X;
    } else if (button == S) {
      axisDegree[0] = X;
      degrees *= -1;
    }

    axisDegree[2] = radians(degrees);
    cameraList.add(0, axisDegree);
  }

  int getRed() {
    if (red <= 0) {
      redIncreasing = true;
    } else if (red >= 255) {
      redIncreasing = false;
    }
    if (redIncreasing) {
      return red += 2;
    }
    return red -= 2;
  }

  void move() {
    getNextDirection();
    Limb backLimb = limbs.get(limbs.size() - 1);
    setNextPos();
    Limb frontLimb = new Limb(x, y, z, getRed());
    frontLimb.setPos(x, y, z);
    if (growing == 0) {
      limbs.remove(backLimb);
    } else {
      growing--;
    }
    limbs.add(0, frontLimb);

    nextDirectionBut = 0;
  }

  private void setNextPos() {
    if (direction == X) {
      x += limbSize + limbSpacing;
    } else if (direction == -X) {
      x -= limbSize + limbSpacing;
    } else if (direction == -Y) {
      y -= limbSize + limbSpacing;
    } else if (direction == Y) {
      y += limbSize + limbSpacing;
    } else if (direction == -Z) {
      z -= limbSize + limbSpacing;
    } else if (direction == Z) {
      z += limbSize + limbSpacing;
    }
  }

  void addLimbs(int temp) {
    growing += temp;
  }

  void display() {
    //println(snake.limbs.get(0).pos);
    for (Limb limb : limbs) {
      limb.display();
    }
  }
}

//END OF SNAKE CLASS

String typing = "";
int score;
boolean isScoreMenu = false;
//PFont f;
int trying = 115;

ArrayList<String> highScores= new ArrayList<String>();

private String fileName = "LeaderBoard.txt";
private String helperFile = "helper.txt";

void drawNameScreen() {

  int indent = (int) (-boxSize / 2) + 25;

  // Set the font and fill for text
  //textFont(f);
  fill(13, 232, 17);

  // Display everything
  translate(0, -boxSize / 2, boxSize / 2);
  text("You got a score of " + score + "!", indent, 40);
  text("Enter your name to save your high score! \nHit enter to save. ", indent, 80);
  text("Name: " + typing, indent, 170);
}

void drawClickAgain() {

  //textFont(createFont("", 32));
  noStroke();
  fill(255);
  translate(0, -boxSize / 2, boxSize / 2);
  text("You got a score of " + snake.limbs.size(), trying, 60);
  text("Click to play again!", trying, 40);
  //trying++;
}


//END OF LEADERBOARD CLASS
