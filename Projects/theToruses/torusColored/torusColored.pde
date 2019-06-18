
int rows, cols;
ArrayList<Particle> particles = new ArrayList<Particle>();
Float[] flowField;
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
int seed = 19498;

/// things to change for fun//////////////////////////////////////////////////////////////////////////////

//difference between each pixel in distances (currently off using torus mode)
//float inc = 0.065;

//how fast the field changes (currently off if using BigCircR)
//float zinc = 0.01262;

//size of one pixel
float scl = 4;

//how far apart each index is in the flowfield values
float density = 0.85 / 1.5;

//these two just slide the picture in each direction
float moveDiffDx = 0; //-1
float moveDiffDy = 0; //1

//size of the big Circle that the torus is rotating around
float bigCircR = .9;

//main radius of torus
float mainMag = 1.1;

//sub radius of torus
float subMag = .5;

float aSpeed = radians(4);

boolean RECORDING = false;

void setup() {
  size(1920, 1080, P2D);

  if (seed == 0) {
    seed = (int) random(-100000, 100000);
  }
  randomSeed(seed);
  noiseSeed(seed);

  colorMode(HSB, 255, 100, 100);
  background(0);
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1);
  flowField = new Float[cols * rows];
  for (int i = 0; i < 2500; i++) {
    //particles.add(new Particle());
  }
  /*for(int i = 0; i < NUMCOLS; i++){
   //colors.add(color(random(255), random(255), random(255), 2));
   colors.add(color(random(255), 125, 255, 2));
   }*/
  colors.add(color(117, 2, 242, 5));
  colors.add(color(176, 98, 94, 5));
  //smooth(8);
}

void draw() {
  //background(0);
  //float yoff = 0;

  for (int y = 0; y < rows; y++) {
    //float xoff = 0;
    for (int x = 0; x < cols; x++) {
      int index = (int) (x + (y * cols));
      float val = getNoiseValue((float) (x + moveDiffX) % (cols), (float) (y + moveDiffY) % (rows), zoffInit);
      val = map(val, .1, .8, 100, 255);
      //PVector v = PVector.fromAngle(angle);
      //v.setMag(.07);
      flowField[index] = val;
      fill(val, 100, 100);
      noStroke();
      rect(x * scl, y * scl, scl, scl);
      //xoff += inc;

      //stroke(255);
      //pushMatrix();
      //  translate(x * scl, y * scl);
      //  rotate(v.heading());
      //  strokeWeight(1);
      //  stroke(255);
      //  line(0, 0, scl, 0);
      //popMatrix();
    }
    //yoff += inc;
  }
  moveDonut();

  //for(Particle particle : particles){
  //  particle.follow(flowField);
  //  particle.update();
  //  particle.display(); 
  //  particle.edges();
  //}
  colIndex += COLINC;

  moveDiffX += moveDiffDx;
  moveDiffY += moveDiffDy;

  if (RECORDING && a <= TWO_PI) {
    saveFrame("movie/torusColored######.gif");
  }
}

//moving the torus around in a circle to change how it changes
//the torus opens to the z direction
//this means we want to travel along a circle in the zy plane?
void moveDonut() {
  a += aSpeed;

  yoffInit = cos(a) * bigCircR;
  zoffInit = sin(a + PI / 3) * bigCircR;
  xoffInit = -cos(a + TWO_PI / 3) * bigCircR;


  //different combinations down here has weird effects

  //moves stuff towards middle
  //xoffInit += .05;

  //different on left and right sides
  //yoffInit += .05;

  //moves stuff upwards
  //zoffInit += .05;
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

  noStroke();
  fill(255, 0, 0);
  //sphere(15);

  //axVal = abs(axVal); //not sure what this line does
  //this line below is incorrect but makes the thing look color
  ayVal = abs(ayVal);
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
    print(seed);
  }
}
