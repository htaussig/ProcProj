public class Shape{
  float x, y, r, ain, size;
  int NUMSIDES = 4;
  float da = TWO_PI / NUMSIDES;
  float extraTilt = PI / 4;
  boolean needsRec = true;
  
  
  Shape(float x_, float y_, float ain_, float size_){
    x = x_;
    y = y_;
    r = getThisR(size_);
    ain = ain_;
    size = size_;
  }
  
  ArrayList<Shape> getChildrens(){
    needsRec = false;
    ArrayList<Shape> tris = new ArrayList<Shape>();
    
    float a = ain - extraTilt;
    for(int i = 0; i < NUMSIDES; i++){
      float newX = x + cos(a) * r;
      float newY = y + sin(a) * r;
      
      Shape babTri = new Shape(newX, newY, ain, size / 2.2);
      tris.add(babTri);
      
      a += da;
    } 
    return tris;
  }
  
  float getThisR(float num){
    return num * sqrt(2) / 4;
  }
  
  void display(){
    stroke(0);
    //strokeWeight(.001);
    noFill();
    
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    //rect(0, 0, size, size);
    popMatrix();
    drawDesign();
  }
  
  void drawDesign(){
    float lDiv = map(size, 780, 0, 0, 1);
    lDiv = pow(lDiv, 3);
    lDiv = map(lDiv, 0, 1, 2.4, 4);
    float drawR = size / 4; 
    
    pushMatrix();
    translate(x, y);
    float ang = 0 + ain;
    //beginShape();
    for(int i = 0; i < NUMSIDES; i++){
      float x = cos(ang) * drawR;
      float y = sin(ang) * drawR;
      float w = size / lDiv;
      float h = w / 7;
      rect(x, y, w, h);
      //vertex(x, y);
      rotate(da);
    }
    //endShape(CLOSE);
    popMatrix();
  }
}
