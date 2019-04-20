//-79941.5 with 12500 particles


int rows, cols;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowField;
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
float scl = 10;

//this value matters a lot
//how far apart each index is in the flowfield values
float density = .1;
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
float speedChange = .0002;

void setup() {
  size(1000, 1000, P3D);
  frameRate(60);
  colorMode(HSB, 255, 100, 100);
  background(0);
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1);
  flowField = new PVector[cols * rows];
  for (int i = 0; i < 1500; i++) {
    particles.add(new Particle());
  }
  /*for(int i = 0; i < NUMCOLS; i++){
   //colors.add(color(random(255), random(255), random(255), 2));
   colors.add(color(random(255), 125, 255, 2));
   }*/
  colors.add(color(117, 2, 242, 4));
  colors.add(color(176, 98, 94, 4));
  //smooth(8)

  if (seed == 0) {
    seed = (int) random(-1000000, 1000000);
  }
  randomSeed(seed);
  noiseSeed(seed);
}

void draw() {
  //if (lineMode) {
  background(0);
  //}

    lights();
    
  directionalLight(255, 255, 255, 1, 1, 1);
  //directionalLight(255, 255, 255, 1, 0, 0);
  //directionalLight(255, 255, 255, -1, 1, 0);
  //directionalLight(255, 255, 255, 0, -1, -1);

  //ortho();
  translate(width / 2, height / 2, -200);
  rotateX(frameCount / 300.0);
  rotateZ(frameCount / 300.0);
  rotateX(PI / 6);
  rotateY(PI / 7);


  
  //float yoff = 0;

  for (int y = 0; y < rows; y++) {
    //float xoff = 0;
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      float val = getNoiseValue((float) (x + moveDiffX) % (cols), (float) (y + moveDiffY) % (rows), zoffInit);
      //val = map(val, 0, 1, 100, 255);

      //multiply by 1.3 because the values don't get too close to 0 and 1
      float angle = map(val, .1, .8, 0, TWO_PI) * randomMulti;
      PVector v = PVector.fromAngle(angle);
      v.setMag(10);
      flowField[index] = v;
      //fill(val, 100, 100);
      //noStroke();
      //rect(x * scl, y * scl, scl, scl);
      //xoff += inc;

      if (lineMode) {
        stroke(255);
        pushMatrix();
        translate(x * scl, y * scl);
        rotate(v.heading());
        strokeWeight(1);
        stroke(255);
        line(0, 0, scl, 0);
        popMatrix();
      }
    }
    //yoff += inc;
  }
  moveDonut();

  for (Particle particle : particles) {
    particle.follow(flowField);
    particle.update();
    particle.display(); 
    particle.edges();
  }
  colIndex += COLINC;

  //moveDiffX += moveDiffDx;
  //moveDiffY += moveDiffDy;

  frames++;
  if (RECORDING && frames % 2 == 0) {
    saveFrame("movie/torusColored-######.png");
  }
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
  xoffInit += speedChange;

  //different on left and right sides
  yoffInit += speedChange;
  
  //moves stuff upwards
  zoffInit += speedChange;
}

float getNoiseValue(float x, float y, float zoff) {

  //float aMain = map(y, 0, rows - 1, 0, TWO_PI);
  //float aSub = map(x, 0, cols - 1, 0, TWO_PI);

  float aMain = map(x, 0, cols - 1, 0, TWO_PI);
  float aSub = map(y, 0, rows - 1, 0, TWO_PI);

  float xoff = 0;
  float yoff = 0;

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
  zoff += -sin(aSub) * subMag;

  return noise((xoff + xoffInit) * density, (yoff + yoffInit) * density, (zoff) * density);
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
