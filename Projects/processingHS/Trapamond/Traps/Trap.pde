public class Trap {

  //x and y define the top-middle of the trapezoid
  float x, y, z, h, b1, b2, zA;
  float rBL;
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();

  public Trap(float x_, float y_, float z_, float h_, float zA_) {
    x = x_;
    y = y_;
    z = z_;
    h = h_;
    b1 = h_ * 2 / sqrt(3);
    b2 = b1 * 2;
    zA = zA_;
    rBL = 0;
    initializeTris();
  }

  public Trap(float x_, float y_, float z_, float h_) {
    this(x_, y_, z_, h_, 0);
  }
  
  private void initializeTris() {
    for (int i = 0; i < 3; i++) {
      float a = radians(30);
      float theY = 0;
      if (i == 1) {
        theY = h / 3;
        a += radians(180);
      } else {
        theY = (h * 2 / 3.0);
      }
      float theX = ((i - 1) * b1 / 2);

      triangles.add(new Triangle(theX, theY, 0, h * 2 / 3, a));
    }
  }

  //For the future: all you need is a magnitude and an angle (or use PVECTORS)
  public ArrayList<Trap> get4Traps() {
    ArrayList<Trap> traps = new ArrayList<Trap>();

    float theX = x - (h / 2) * sin(zA);
    float theY = y + (h / 2) * cos(zA);

    traps.add(new Trap(theX, theY, 0, h / 2, zA));
    traps.add(new Trap(theX, theY, 0, h / 2, zA + PI));

    float bAvg = (b1 + b2) / 2;

    float a = zA - PI / 3.0;
    
    float mag = sqrt(pow(bAvg / 4, 2) + pow(h * 3.0 / 4, 2));

    theX = x - (mag * cos(a));
    theY = y - (mag * sin(a));

    float theZA = radians(120) + zA;

    traps.add(new Trap(theX, theY, 0, h / 2, theZA));
  
    a = zA + PI / 3.0 + PI;
    theX = x - (mag * cos(a));
    theY = y - (mag * sin(a));
    theZA = radians(240) + zA;
  
    traps.add(new Trap(theX, theY, 0, h / 2, theZA));

    return traps;
  }

  public void rBotLeft(float rot){
    rBL += rot;
  }
  
  private void translateToBotLeft(float mult){
    float mag = sqrt(h * h + (b2 / 2) * (b2 / 2));
    PVector start = new PVector(x, y);
    PVector botLeft = new PVector(x - (b2 / 2), y + h);
    botLeft.sub(start);
    float a = botLeft.heading();
    translate(mag * cos(a) * mult, mag * sin(a) * mult);
  }

  public void display() {
    pushMatrix();
    translate(x, y, z);
    rotateZ(zA);
    translateToBotLeft(1);
    fill(255);
    ellipse(0, 0, 5, 5);
    rotateZ(rBL);
    translateToBotLeft(-1);
    for (Triangle tri : triangles) {
      tri.display();
    }
    popMatrix();
  }
}