import processing.svg.*;

float NUMTIMES = 8.0;
float NUMLINES = 4.0;
ArrayList<Curve> curves = new ArrayList<Curve>();
float w = 200;
float h = 200;

void setup() {
  size(600, 600);
  curves.clear();
  frameRate(30);
  for (float a = 0; a < TWO_PI - .01; a += radians(360 / NUMTIMES)) {
    float x = width / 2;
    float y = height / 2;
    curves.add(new Curve (x, y, w, h, a, radians(180)));
    
    //float mag = sqrt(w * w + h * h);
    
    //x += cos(a + PI / 4) * mag;
    //y += sin(a + PI / 4) * mag;
    //curves.add(new Curve (x, y, w, h, PI + a));
  }
  //noLoop();
  //beginRecord(SVG, "RegCurveCut" + NUMTIMES + ".svg");
}

void draw() {
  background(255);
  strokeWeight(1);
  
  //NUMTIMES += .01;
  
  for (Curve curve : curves) {
    
    curve.a -= radians(.4);
    curve.angBetween += radians(.8);
    curve.display();
   
  }
  //setup();
  //endRecord();
}

void keyPressed(){
  if(key == 'w'){
    NUMTIMES++;
  }
  else if(key == 's'){
    NUMTIMES--;
  }
  if(key == 'p'){
    saveFrame("RectCut-######.png");
    System.out.println("saved");
  }
}
