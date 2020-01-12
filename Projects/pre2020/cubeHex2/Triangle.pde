public class Triangle {
  float triR, x, y, a;
  
  //rotation around a particular point of the triangle
  float specialA;
  float specialDA;
  
  //the position of the vertex we are currently rotating around
  PVector vertPos = null;

  public Triangle(float x_, float y_, float triR_, float a_) {
    x = x_;
    y = y_;
    triR = triR_;
    //this a is the initial rotation of the triangle
    a = a_;
    
    specialDA = radians(-1);
    
    setVertPos(a);
  }
  
  public Triangle(float x_, float y_, float triR_, float a_, float specDA) {
    this(x_, y_, triR_, a_);
    specialDA = radians(-specDA);
  }

  //get the next vertex to rotate based on an angle
  public void setVertPos(float thisA) {
    thisA += radians(30);
    vertPos = new PVector(cos(thisA) * r, sin(thisA) * r);
  }
  
  //rotate around the set vertex
  void vertRot(){
    if(vertPos == null){
     setVertPos(a); 
    }
    
    if(abs(specialA) >= radians(60)){
      a += radians(60);
      setVertPos(a);
      specialA = 0;
      //print("twist");
    }
    
    translate(vertPos.x, vertPos.y);
    rotate(specialA);

    specialA += specialDA;
  }

  void display() {
    pushMatrix();
    vertRot();
    //fill(255, 0, 0);
    //ellipse(0, 0, 20, 20);

    drawTriangle();
    popMatrix();
  }
  
  void drawTriangle(){
    
    noStroke();
    fill(white);    
    
    float otherA = a + radians(-60);
    
    beginShape();
    vertex(0, 0);
    vertex(sin(a) * r, -cos(a) * r);
    vertex(sin(otherA) * r, -cos(otherA) * r);
    endShape(CLOSE);
  }
}
