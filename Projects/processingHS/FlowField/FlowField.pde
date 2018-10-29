float inc = 0.065;
float zoff = 0;
float scl = 10;
int rows, cols;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowField;
ArrayList<Integer> colors = new ArrayList<Integer>();
float colIndex = 0;
private static int NUMCOLS = 2;
private static float COLINC = .0015;

void setup(){
  size(1900, 1000, P2D);
  colorMode(HSB, 255, 100, 100);
  background(0);
  rows = (int) (height / scl + 1);
  cols = (int) (width / scl + 1);
  flowField = new PVector[cols * rows];
  for(int i = 0; i < 2500; i++){
    particles.add(new Particle());
  }
  /*for(int i = 0; i < NUMCOLS; i++){
    //colors.add(color(random(255), random(255), random(255), 2));
    colors.add(color(random(255), 125, 255, 2));
  }*/
  colors.add(color(117, 2, 242, 5));
  colors.add(color(176, 98, 94, 5));
  //smooth(8);
}

void draw(){
  //background(0);
  float yoff = 0;
  for(int y = 0; y < rows; y++){
    float xoff = 0;
    for(int x = 0; x < cols; x++){
      int index = (int) (x + (y * cols));
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 1.7;
      PVector v = PVector.fromAngle(angle);
      v.setMag(.07);
      flowField[index] = v;
      xoff += inc;
      /**stroke(0, 50);
      pushMatrix();
        translate(x * scl, y * scl);
        rotate(v.heading());
        strokeWeight(1);
        stroke(255);
        line(0, 0, scl, 0);
      popMatrix();**/
    }
    yoff += inc;
  }
  zoff += 0.00022;
  
  for(Particle particle : particles){
    particle.follow(flowField);
    particle.update();
    particle.display(); 
    particle.edges();
  }
  colIndex += COLINC;
  
}

void keyPressed(){
    if(key == 'S'){
      saveFrame("line-######.png");
      System.out.println("Frame saved");
    }
}
