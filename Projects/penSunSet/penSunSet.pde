import processing.svg.*;

boolean RECORDING = false;

int NUMSTROKES = 1;
int STROKEWEIGHT = 2;
color THECOLOR = color(50, 50);

ArrayList<PaintStroke> strokes;

void setup(){
  size(600, 600);
  //strokes = new ArrayList<PaintStroke>();
  ////strokes.add(new PaintStroke());
  
  //for (int i = 0; i < NUMSTROKES; i++) {
  //  //strokes.add(new PaintStroke());
  //  //strokes.add(new PaintCurve());
  //}
  
  background(255);
  
  if(RECORDING){
    beginRecord(SVG, "penSunSet" + NUMSTROKES + ".svg");
  }
  //for (PaintStroke stroke : strokes) {
  //  stroke.display();
  //}
  translate(width / 2, height / 2);
  drawTheSun(200);
  
  if(RECORDING){
    endRecord();
  }
  //println(strokes.size());
}

void draw(){
  
}

void drawTheSun(float radius){
  //wider between rects towards bottom
  //more heavily shaded (more lines) towards bottom
  pushMatrix();
  translate(0, -radius);
  
  float rectThickness = .06 * radius; //thickness of each rect thingy
  float distBetweenRectsInc = .003 * radius;
  float emptyDist = distBetweenRectsInc;
  
  float pixPerLine = 2; //how many pixels to pass before drawing another line
  
  strokeWeight(STROKEWEIGHT);
  stroke(0);
  
  float circleYpos = 0;
  while(circleYpos <= radius * 2){
    
    drawRectInCirc(circleYpos, rectThickness, pixPerLine, radius);
    
    circleYpos += rectThickness;
    circleYpos += emptyDist;
    emptyDist += distBetweenRectsInc;
  }
  
  popMatrix();
}

void drawRectInCirc(float circleYpos, float rectThickness, float pixPerLine, float radius){
  for(float i = circleYpos; i < circleYpos + rectThickness; i += pixPerLine){
   
    float distFromCenter = Math.abs(i - radius); //this should work
    
    //sqrt(r^2 - y^2) = x  ;  from the equation of a circle
    float drawX = sqrt(pow(radius, 2) - pow(distFromCenter, 2));
    
    pushMatrix();
    translate(0, i);
    
    line(-drawX, 0, drawX, 0);
       
    popMatrix();
    
  }
}
