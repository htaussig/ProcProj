public class Triangle {
  float x;
  float y;
  float r;
  float z;
  color col1;
  color col2;
  ArrayList<PVector> innerTriMids;
  float zA;
  float sizeInc = .2;

  public Triangle(float x_, float y_, float z_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    z = z_;
    col1 = #CD4BE8;
    col2 = #2C16F7;
    innerTriMids = new ArrayList<PVector>();
  }

  public void setZ(float newZ) {
    z = newZ;
  }

  public ArrayList<Triangle> get4Tri() {
    ArrayList<Triangle> fourTri = new ArrayList<Triangle>();
    pushStyle();
    colorMode(HSB, 100, 255, 255);
    color nextCol2 = color(random(100), 255, 255);
    popStyle();
    Triangle midTri = new Triangle(x, y, z, r / 2);
    midTri.zA = zA + PI;
    midTri.col1 = col1;
    midTri.col2 = col2;
    fourTri.add(midTri);
    for (int i = 0; i < 3; i++) {
      float a = i * 2 * PI / 3;
      a += zA;
      Triangle triangle = new EdgeTri(x + cos(a) * r / 4, y + sin(a) * r / 4, z, r / 2, new PVector(0, 0)); 
      triangle.zA = a;
      triangle.col1 = col1;
      triangle.col2 = nextCol2;
      fourTri.add(triangle);
    }
    return fourTri;
  }

  public boolean isCenter() {
    return false;
  }

  public void enlarge() {
    r += sizeInc;
    PVector me = new PVector(x, y);
    PVector center = new PVector(0, 0);
    PVector diff = PVector.sub(me, center).normalize();
    diff.mult(r);
    x = 0 + diff.x;
    y = 0 + diff.y;
  }

  /*public void displayInner(){
   stroke(color(0));
   fill(col);
   pushMatrix();
   translate(x, y, z);
   beginShape();
   for(PVector mPoint : innerTriMids){
   vertex(mPoint.x, mPoint.y); 
   }
   endShape(CLOSE);
   popMatrix();
   }*/

  public void display() {
    noStroke();
    //stroke(color(255));
    fill(col1);
    pushMatrix();
    translate(x, y, z);
    rotateZ(zA);
    beginShape(TRIANGLE);
    for(int j = 0; j < 2; j++){
      if(j == 0){
       fill(col1); 
      }
      else{
       fill(col2); 
      }
      for (int i = 0; i < 3; i++) {
        float a = i * 2 * PI / 3;
        vertex(cos(a) * r, sin(a) * r, .005 - (j * .01));
        /*a += PI / 3;
         innerTriMids.add(new PVector(cos(a) * r / 2, sin(a) * r / 2, z));*/
      }
    }  
    endShape();
    popMatrix();
  }
}