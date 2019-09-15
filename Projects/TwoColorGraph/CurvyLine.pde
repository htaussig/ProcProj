public class CurvyLine{
  
  float ROTATEMAG = .05;
  float VMAG = 1;
  float AMAG = .1;
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  PVector pos;
  PVector v;
  PVector a;
  float startX, startY;
  float tAdd = random(-100000, 100000);
  
  public CurvyLine(float x, float y){
    startX = x;
    startY = y;
    this.pos = new PVector(x, y);
    
    gen();
  }
  
  //generate a curvy line
  public void gen(){
    points.add(pos.copy());
    float vMag = 1;
    float aMag = 0;
    
    if(startX == 0){
      aMag = 0;
    }
    else if(startX == width){
      aMag = PI;
    }
    else if(startY == 0){
      aMag = PI / 2;
    }
    else if(startY == height){
      aMag = 3 * PI / 2;
    }
    
    v = PVector.fromAngle(aMag).mult(vMag);
    a = PVector.fromAngle(aMag).mult(AMAG);
  }
  
  void update(){
    v.add(a);
    if(v.mag() > VMAG){
      v.setMag(VMAG);
    }   
    pos.add(v);
    edges();
    a.setMag(AMAG).rotate(getAngle());
    points.add(pos.copy());
  }
  
  float getAngle(){
    return map(noise(t + tAdd), 0, 1, -ROTATEMAG, ROTATEMAG);
  }
  
  void edges(){
    if(pos.x < 0){
      pos.x = width + pos.x;
      points.clear();
    }
    if(pos.x > width){
      pos.x -= width;
      points.clear();
    }
    if(pos.y < 0){
      pos.y = height + pos.y;
      points.clear();
    }
    if(pos.y > height){
      pos.y -= height;
      points.clear();
    }
  }
  
  void display(){
    //ellipse(pos.x, pos.y, 10, 10);
    update();
    
    //stroke(255);
    //strokeWeight(10);
    fill(255);
    beginShape();
    for(PVector p : points){
      vertex(p.x, p.y);
    }
    //vertex(points.get(0).x, points.get(0).y);
    endShape(CLOSE);
  }
}
