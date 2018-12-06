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
    sphere(sphereD);
    popMatrix();
  }
}
