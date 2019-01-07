public class Triangle{
  float x, y, r, ain;
  float da = TWO_PI / 3;
  boolean needsRec = true;
  
  Triangle(float x_, float y_, float r_, float ain_){
    x = x_;
    y = y_;
    r = r_;
    ain = ain_;
  }
  
  ArrayList<Triangle> getChildrenTri(){
    needsRec = false;
    ArrayList<Triangle> tris = new ArrayList<Triangle>();
    
    float a = ain - PI / 6;
    for(int i = 0; i < 3; i++){
      float newX = x + cos(a) * r;
      float newY = y + sin(a) * r;
      
      Triangle babTri = new Triangle(newX, newY, r / 2, ain);
      tris.add(babTri);
      
      a += da;
    } 
    return tris;
  }
  
  void display(){
    float val = map(r, 0, 200, 2.5, 7);
    float drawR = r - (val); 
    stroke(0);
    //noFill();
    pushMatrix();
    translate(x, y);
    float ang = PI / 6 + ain;
    beginShape();
    for(int i = 0; i < 3; i++){
      vertex(cos(ang) * drawR, sin(ang) * drawR);
      ang += da;
    }
    endShape(CLOSE);
    popMatrix();
  }
}
