import peasy.*;

PeasyCam cam;

float[][] points;

//distance between adjacent points on point grid
float dist = 2;

float scale = 2;

float xyScale;

//linear right now with x and y
float m1 = 1;
float m2 = 1;
float c = 0;


void setup(){
  size(800, 800, P3D);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1500);
  
  int val =  (int) (800 / dist);
  points = new float[val][val];
  
  xyScale = 800 / val;
  
  calcPoints();
}

void draw(){
  background(0);
  
  //translate(width / 2, height / 2);
  //fill(180, 120);
  //noFill();
  stroke(123, 255);
  
  beginShape(TRIANGLE_STRIP);
  for(int i = 0; i < points.length; i++){
    for(int k = 0; k < points[0].length; k++){
      vertex(i * scale, k * scale, points[i][k] * scale);      
    }
  }
  endShape();
  
}

void calcPoints(){
  for(int i = 0; i < points.length; i++){
    for(int k = 0; k < points[0].length; k++){
      float x = (i - width / 2) * xyScale;
      float y = k - height / 2 * xyScale;
      points[i][k] = m1 * x + m2 * y;
    }
  }
}
