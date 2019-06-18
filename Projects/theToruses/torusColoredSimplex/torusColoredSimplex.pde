
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
//19498   .1
//-1861    .2
int seed = 0;

/// things to change for fun//////////////////////////////////////////////////////////////////////////////

//difference between each pixel in distances (currently off using torus mode)
//float inc = 0.065;

//how fast the field changes (currently off if using BigCircR)
//float zinc = 0.01262;

//size of one pixel
float scl = 2;

//how far apart each index is in the flowfield values
//.85
float density = 1.3;

//these two just slide the picture in each direction
float moveDiffDx = 0; //-1
float moveDiffDy = 0; //1

//size of the big Circle that the torus is rotating around
float bigCircR = .9;

//main radius of torus
float mainMag = 1.1;

//sub radius of torus
float subMag = .1;

float aSpeed = radians(3);
float changeSpeed = .03;

float minColor = 100;
float maxColor = 225;

//color c1 = color(155, 8, 255);
//color c2 = color(8, 255, 236);
//colors.add(color(117, 2, 242, 5));
  //colors.add(color(176, 98, 94, 5));

boolean RECORDING = false;

int totalFrames = 360;
int counter = 0;

OpenSimplexNoise noise;
void setup() {
  size(500, 400);

  if (seed == 0) {
    seed = (int) random(-100000, 100000);
  }
  randomSeed(seed);
  noiseSeed(seed);
  noise = new OpenSimplexNoise(seed);

  //colorMode(HSB, 255, 100, 100);
  background(0);
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1);
  flowField = new Float[cols * rows];
  for (int i = 0; i < 2500; i++) {
    //particles.add(new Particle());
  }
  colors.add(color(255));
  colors.add(color(8, 255, 236));
  colors.add(color(0));
  colors.add(color(252, 23, 249));
  colors.add(color(255));
  //colors.add(color(5, 8, 157));
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
      //println(val);
      val = mapValue(val);
      //PVector v = PVector.fromAngle(angle);
      //v.setMag(.07);
      flowField[index] = val;
      
      //new in this version, lerping colors
      color c = getColor(val);
      fill(c);
      //fill(val, 100, 100);
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

  if (RECORDING && a <= TWO_PI + aSpeed + .1) {
    saveFrame("movie/torusColoredSimplex######.gif");
  }
}

//do whatever you gotta to the -1, to 1 value
float mapValue(float v){
  //map(v, -1, 1, minColor, maxColor);
  
  return map(v, -.8, .8, 0, colors.size() - 1);
  
}

//moving the torus around in a circle to change how it changes
//the torus opens to the z direction
//this means we want to travel along a circle in the zy plane?
void moveDonut() {
  a += aSpeed;
  yoffInit = cos(a) * bigCircR;
  zoffInit = sin(a) * bigCircR;
  xoffInit = -cos(a) * bigCircR;


  //different combinations down here has weird effects

  //moves stuff towards middle
  //xoffInit += changeSpeed;

  //different on left and right sides
  //yoffInit += changeSpeed;

  //moves stuff upwards
  //zoffInit += changeSpeed;
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
  //ayVal = abs(ayVal);
  float axyVal = cos(aSub);
  xoff += (axVal)  * subMag * axyVal;
  yoff += (ayVal)  * subMag * axyVal;
  zoff += -sin(aSub) * subMag;

  return (float) noise.eval((xoff + xoffInit) * density, (yoff + yoffInit) * density, (zoff) * density);
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
