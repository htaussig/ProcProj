public class Triangle {

  Vertex v1, v2, v3; 
  Connect c12, c23, c13;

  public Triangle(Vertex v1_, Vertex v2_, Vertex v3_) {
    v1 = v1_;
    v2 = v2_;
    v3 = v3_;
    
    c12 = new Connect(v1, v2);
    c23 = new Connect(v2, v3);
    c13 = new Connect(v1, v3);
  }
  
  public Triangle(Connect c12_, Vertex v3_){
    this(c12_.v1, c12_.v2, v3_);
    c12 = c12_;
  }

  void doesIntersect() {
  }
  
  Connect[] getConnections(){
    Connect[] arr = {c12, c23, c12};
    return arr;
  }

  boolean equals(Triangle other) {
    //gonna need arrays of the connections or vertices to compare each possibility of them
    
    if (PVector.dist(v1.pos, other.v1.pos) == 0 && PVector.dist(v2.pos, other.v2.pos) == 0) {
      return true;
    } else if (PVector.dist(v2.pos, other.v1.pos) == 0 && PVector.dist(v1.pos, other.v2.pos) == 0) {
      return true;
    }
    return false;
  }

  void display(float tempCol) {
    colorMode(HSB);
    fill(tempCol % 255, 255, 255, 70);
    beginShape();
    vert(v1);
    vert(v2);
    vert(v3);
    endShape(CLOSE);
    colorMode(RGB);
  }

  void vert(Vertex v) {
    vertex(v.pos.x, v.pos.y, v.pos.z);
  }
}
