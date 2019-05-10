//-79941.5 with 12500 particles
//Take @shiffman's flowfield, map x and y to the two angles of a torus, and turn the particles into pyramids that point inwards. Code here: https://bit.ly/2VkigJ0   #processing #generative.

int rows, cols;
PVector[][] points;
Float[][] flowField;
ArrayList<Integer> colors = new ArrayList<Integer>();
float colIndex = 0;
private static int NUMCOLS = 2;
private static float COLINC = .0015;

int moveDiffX = 0;
int moveDiffY = 0;

float a = 0;

float zoffInit = 0;
float xoffInit = 0;
float yoffInit = 0;

//if seed is set to 0, random seed, otherwise this value gets used
//329140
//79721
//553172  (really good spiral) .4
//(-)? 712113(weird close together) .45 is sick
//-146031 two things //.0001 change
//837790  //.1 density //.0002 change
//326881
//video seed = -112030
int seed = 0;

//changes the way the field generally moves
float randomMulti = 1;

/// things to change for fun//////////////////////////////////////////////////////////////////////////////

//difference between each pixel in distances (currently off using torus mode)
//float inc = 0.065;

//how fast the field changes (currently off if using BigCircR)
//float zinc = 0.01262;

//size of one pixel
//lowering this gets the lines way closer together
float scl = 5;

//this value matters a lot!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//how far apart each index is in the flowfield values
//.5 <-> .1
float density = 2;
//1.3

//these two just slide the picture in each direction
//float moveDiffDx = 0; //-1
//float moveDiffDy = 0; //1

//size of the big Circle that the torus is rotating around
float bigCircR = 1;

//main radius of torus
float mainMag = 1.1;

//sub radius of torus
float subMag = .5;

float drawMag = 300;

//float aSpeed = .001;

boolean RECORDING = false;
float frames = 0;
boolean lineMode = false;


//how fast the flow field changes
///.0001
float speedChange = .01;


float particleSize = 15;

//camera stuff
float camRotSpeed = 1/100.0;

int mainRows = 100;
int subCols = 100;
float aMainChange, aSubChange;

float pixelDX, pixelDY;

float circumfY;
float baseY;

Pixel[][] torusPixels;

OpenSimplexNoise noise;

//percentage of the transformation
float dP = 0.01;
float p = dP;

void setup() {

  size(1000, 1000, P3D);
  frameRate(60);
  //colorMode(HSB, 255, 100, 100);
  background(0);

  calculateChanges();

  points = new PVector[mainRows][subCols];
  for (int x = 0; x < mainRows; x++) {
    for (int y = 0; y < subCols; y++) {
      float i = x * pixelDX;
      float j = y * pixelDY;
      points[x][y] = getPVectorTorus(i, j);
    }
  }

  initTorusPixels();

  if (seed == 0) {
    seed = (int) random(-1000000, 1000000);
  }
  randomSeed(seed);
  noiseSeed(seed);
  noise = new OpenSimplexNoise(seed);

  //rows = (int) (height / scl + 1);
  //cols = (int) (width / scl + 1);
  flowField = new Float[mainRows][subCols];

  /*for(int i = 0; i < NUMCOLS; i++){
   //colors.add(color(random(255), random(255), random(255), 2));
   colors.add(color(random(255), 125, 255, 2));
   }*/

  addColors();

  //smooth(8)
}

void draw() {
  //if (lineMode) {
  background(0);
  //}

  lightsCamerasAction();

  recalculateNoise();
  moveDonut();

  for (int i = 0; i < mainRows; i++) {
    for (int j = 0; j < subCols; j++) {
      torusPixels[i][j].display();
    }
  }

  //for (PVector[] ptArr : points) {
  //  for (PVector p : ptArr) {
  //    //println(i++);
  //    //println(p.x, p.y, p.z);
  //    pushMatrix();

  //    translate(p.x, p.y, p.z);

  //    fill(255);
  //    //stroke(255);
  //    noStroke();
  //    sphere(15); 

  //    popMatrix();
  //  }
  //}
  colIndex += COLINC;

  //moveDiffX += moveDiffDx;
  //moveDiffY += moveDiffDy;

  frames++;
  if (RECORDING && frames % 2 == 0) {
    saveFrame("movie/torusColored-######.png");
  }

  movePoints();
}

void movePoints() {
  if (p < 1 && p > 0) {
    p += dP;
  } else {
    dP *= -1;
    p += dP;
  }
  
  //println(p, dP);



  for (int x = 0; x < mainRows; x++) {
    for (int y = 0; y < subCols; y++) {
      float i = x * pixelDX;
      float j = y * pixelDY;
      PVector p1 = getPVectorTorus(i, j);
      PVector p2 = getPVectorSphere(i, j);
      float x3 = p1.x * (p - 1) + p2.x * p;
      float y3 = p1.y * (p - 1) + p2.y * p;
      float z3 = p1.z * (p - 1) + p2.z * p;
      points[x][y].set(x3, y3, z3);
      // getPVectorSphere(i, j)
    }
  }
}

void addColors() {
  //colors.add(color(0));
  ////colors.add(color(8, 255, 236));
  ////colors.add(color(0));
  //colors.add(color(252, 23, 249));
  //colors.add(color(255));

  //colors.add(color(0));

  //colors.add(color(0));
  //colors.add(color(#2A28C6));
  //colors.add(color(#048618)); 
  colors.add(color(#2B2A48));

  //colors.add(color(#31482A));

  colors.add(color(255));

  //colors.add(color(255));
}

void lightsCamerasAction() {

  //lights();

  directionalLight(230, 230, 230, 1, 1, 1);
  directionalLight(220, 220, 220, 1, 0, 0);
  directionalLight(255, 255, 255, -1, 1, 0);
  directionalLight(240, 240, 240, 0, -1, -1);

  //ortho();
  translate(width / 2, height / 2, -200);
  rotateX(frameCount * camRotSpeed);
  rotateZ(frameCount * camRotSpeed);
  //rotateX(PI / 6);
  //rotateY(PI / 7);
}

void recalculateNoise() {
  for (int y = 0; y < mainRows; y++) {
    //float xoff = 0;
    for (int x = 0; x < subCols; x++) {
      int index = (int) (x + (y * cols));
      float val = getNoiseValue((float) (x + moveDiffX) % (cols), (float) (y + moveDiffY) % (rows), 0);
      //val = map(val, 0, 1, 100, 255);

      //multiply by 1.3 because the values don't get too close to 0 and 1
      //float val = map(val, -.8, .8, 0, TWO_PI) * randomMulti;
      //PVector v = PVector.fromAngle(angle);
      //v.setMag(10);
      flowField[y][x] = val;
      //fill(val, 100, 100);
      //noStroke();
      //rect(x * scl, y * scl, scl, scl);
      //xoff += inc;
    }
    //yoff += inc;
  }
}

//mainRows, subCols
void initTorusPixels() {
  torusPixels = new Pixel[mainRows][subCols];

  //PVector topLeft = points[0][0];
  //PVector topRight = points[0][1];
  float row = 0;
  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[0].length; j++) {
      int r = (i + 1) % mainRows;
      int c = (j + 1) % subCols;
      PVector topLeft = points[i][j];
      PVector topRight = points[i][c];
      PVector botLeft = points[r][j];
      PVector botRight = points[r][c];
      //could change the first index to where the value actually is but shouldn't matter too much
      PVector[] pix = {topLeft, topLeft, topRight, botRight, botLeft};
      torusPixels[i][j] = new Pixel(pix);
      //points[1][1] = new PVector(1, 1,1);
    }
  }
}

void calculateChanges() {
  aMainChange = TWO_PI / mainRows;
  aSubChange = TWO_PI / subCols; 
  pixelDX = width / mainRows;
  pixelDY = height / subCols;

  //could calculate this more exactly considering the fact that these are
  //chords across a circle and not actually curved
  circumfY = TWO_PI * subMag * drawMag;
  baseY = circumfY / subCols;
  baseY /= 2;
}

//moving the torus around in a circle to change how it changes
//the torus opens to the z direction
//this means we want to travel along a circle in the zy plane?
void moveDonut() {
  //a += aSpeed;

  //yoffInit = cos(a) * bigCircR;
  //zoffInit = sin(a + PI / 3) * bigCircR;
  //xoffInit = -cos(a + TWO_PI / 3) * bigCircR;


  //different combinations down here has weird effects

  //moves stuff towards middle
  //xoffInit += speedChange;

  //different on left and right sides
  //yoffInit += speedChange;

  //moves stuff upwards
  zoffInit += speedChange;
}

PVector getPVectorSphere(float x, float y) {
  float aMain = map(x, 0, width, 0, TWO_PI);

  //should be just to PI but I think we might need TWO_PI for the torus conversion
  float aSub = map(y, 0, height, 0, TWO_PI);
  
  float mag = drawMag;
  if(sin(aSub) * sin(aMain) < 0){
    mag -= 1;
  }

  float xoff = sin(aSub) * cos(aMain) * mag;
  float yoff = sin(aSub) * sin(aMain) * mag;
  float zoff = cos(aSub) * mag;
  

  PVector p = new PVector(xoff, yoff, zoff);

  return p;
}

PVector getPVectorTorus(float x, float y) {

  float aMain = map(x, 0, width, 0, TWO_PI);
  float aSub = map(y, 0, height, 0, TWO_PI);

  float xoff = 0;
  float yoff = 0;

  float axVal = cos(aMain);
  float ayVal = sin(aMain);

  xoff = mainMag * axVal;
  yoff = mainMag * ayVal;

  float axyVal = cos(aSub);
  xoff += (axVal)  * subMag * axyVal;
  yoff += (ayVal)  * subMag * axyVal;

  //zoff used to have a preset value, will this get messed up? don't think so
  float zoff = -sin(aSub) * subMag;

  PVector p = new PVector(xoff  * drawMag, yoff  * drawMag, zoff  * drawMag);

  return p;
}

float getNoiseValue(float x, float y, float z) {

  //float aMain = map(y, 0, rows - 1, 0, TWO_PI);
  //float aSub = map(x, 0, cols - 1, 0, TWO_PI);

  float aMain = map(x, 0, cols - 1, 0, TWO_PI);
  float aSub = map(y, 0, rows - 1, 0, TWO_PI);

  float xoff = x;
  float yoff = x;

  float axVal = cos(aMain);
  float ayVal = sin(aMain);

  xoff = mainMag * axVal;
  yoff = mainMag * ayVal;
  //translate(xoff, yoff, zoff);

  //sphere(15);

  //axVal = abs(axVal); //not sure what this line does
  //ayVal = abs(ayVal);
  float axyVal = cos(aSub);
  xoff += (axVal)  * subMag * axyVal;
  yoff += (ayVal)  * subMag * axyVal;
  float zoff = -sin(aSub) * subMag;

  return (float) noise.eval((xoff + xoffInit) * density, (yoff + yoffInit) * density, (zoff + zoffInit) * density);
}

float getNoiseValueBasic(float x, float y, float z) {

  return (float) noise.eval((x + xoffInit) * density, (y + yoffInit) * density, (z + zoffInit) * density);
}

void keyPressed() {
  if (key == 's') {
    saveFrame("line-######.png");
    System.out.println("Frame saved");
  } else if (key == 'r') {
    a = 0;
    RECORDING = true;
  } else if (key == 'p') {
    println(seed);
  }
}
