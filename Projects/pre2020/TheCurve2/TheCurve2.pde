import processing.svg.*;

float SPEED = 2.5 * (30 / 24.0);

float NUMTIMES = 6.0;
float NUMLINES = 6.0;
ArrayList<Curve> curves = new ArrayList<Curve>();
float w = 200;
float h = 200;

boolean RECORDING = false;

void setup() {
  size(600, 600);
  curves.clear();
  frameRate(30);
  float x = width / 2;
  float y = height / 2;
  float dA = radians(360 / NUMTIMES);
  for (float a = 0; a < TWO_PI - .01; a += dA) {    
   curves.add(new Curve (x, y, w, h, 0, 0));
    
    //float mag = sqrt(w * w + h * h);
    
    //x += cos(a + PI / 4) * mag;
    //y += sin(a + PI / 4) * mag;
    //curves.add(new Curve (x, y, w, h, PI + a));
  }
  //curves.add(new Curve(x, y, w, h, 0, 0));
  //noLoop();
  //beginRecord(SVG, "RegCurveCut" + NUMTIMES + ".svg");
}

void draw() {
  background(0);
  strokeWeight(1.5);
  stroke(255);
  
  //NUMTIMES += .01;
  
  for (int i = 0; i < curves.size(); i++) {
    Curve curve = curves.get(i);
    
    //if(i != curves.size() - 1){
      //all the other curves
      //remove an equal amount to add to the other curve
      //angle forward by the amount added to the first curve
      
      float dA = SPEED / (curves.size());
      
      curve.angBetween -= radians(dA);
      curve.a += radians(-(i * dA));
      
    //}
    //else{
    //  //with the most recent curve
    //  //add forward by the amount, don't change angle
    //  curve.angBetween += radians(SPEED);
    //}
    //curve.a -= radians(.4);
    //curve.angBetween += radians(.8);
    
    curve.display();
   
     if(i == 0){
       if(curve.angBetween <= -TWO_PI){
         stop();
       }
     }
     
     if(RECORDING){
       saveFrame("theCurve-######.png");
     }   
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
    saveFrame("theCurve-######.png");
    System.out.println("saved");
  }
}
