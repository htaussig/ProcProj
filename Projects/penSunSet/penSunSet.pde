import processing.svg.*;

boolean RECORDING = false;

int NUMSTROKES = 3;
int STROKEWEIGHT = 2;
color THECOLOR = color(50, 50);

float MOUNTAMP = 170;
float MOUNTSHARP = 10;
int NUM_MOUNTS = 2;
float MOUNT_HEIGHT_DEC = 20;
float MOUNT_START_Y = 400;

ArrayList<PaintStroke> strokes;

void setup(){
  size(800, 800);
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
  
  pushMatrix();
  translate(width / 2, height / 2.8);
  drawTheSun(200);
  popMatrix();
  
  pushMatrix();
  translate(0, MOUNT_START_Y);
  for(int i = 0; i < NUM_MOUNTS; i++){
     translate(0, MOUNT_HEIGHT_DEC);
     drawMountains(MOUNTAMP);
  }
  popMatrix();
  
  drawGrid();
  
  
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
  float distBetweenRectsInc = .0042 * radius;
  float emptyDist = distBetweenRectsInc * 3;
  
  //float pixPerLine = 3; //how many pixels to pass before drawing another line
  //vary from 1 to 3
  
  strokeWeight(STROKEWEIGHT);
  stroke(0);
  
  float circleYpos = 0;
  circleYpos += distBetweenRectsInc;
  while(circleYpos <= radius * 2){
    
    float pixPerLine = map(circleYpos, 0, radius * 2, 4, 1);
    //println(pixPerLine);
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

void drawMountains(float amplitude){
  
  beginShape();
  vertex(0, 50);
  
  float numPoints = 35.0;
  float noiseAdd = random(-1000000, 1000000);
  for(float i = 0; i <= 1.01; i += 1.0 / numPoints){
    vertex(i * width, - noise((i * MOUNTSHARP) + noiseAdd) * amplitude);
  }
  
  vertex(width, 50);
  endShape();
}

void drawGrid(){
  float yVal = (MOUNT_HEIGHT_DEC * NUM_MOUNTS) + MOUNT_START_Y;
 
  float heightInc = 0; 
  
  while(yVal < height){
    line(0, yVal, width, yVal);
    yVal += ++heightInc;
  }
}
