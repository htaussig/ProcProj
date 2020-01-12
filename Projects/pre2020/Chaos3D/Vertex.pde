public class Vertex{
  PVector pos;
  color col;
  
  public Vertex(PVector pos_, color col_){
    pos = pos_;
    col = col_;
  }
  
  public Vertex(float x, float y, float z, color col_){
    this(new PVector(x, y, z), col_);
  }
  
  public Vertex(float x, float y, float z){
    this(new PVector(x, y, z), color(random(255), random(255), random(255), opacity));
  }
  
  PVector getPos(){
   return pos; 
  }
  
  color getColor(){
   return col; 
  }
  
  void display(){
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(radians(45));
    if(DRAWMODE == drawCUBE){
      box(diam);
    }
    else if(DRAWMODE == drawSPHERE){
      sphere(diam);
    }
    popMatrix();
  }
}
