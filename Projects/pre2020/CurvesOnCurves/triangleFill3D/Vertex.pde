public class Vertex{
  
  PVector pos, vel; 
  float numConnections;
  float a = random(TWO_PI);
  float inc;
  float r;
  //ArrayList<Vertex> connections;
  
  public Vertex(PVector pos_, float d_){
    pos = pos_;
    r = d_;
    //vel = PVector.random2D().div(2);
    inc = ((int) random(3) + 1) * .006;
    if(random(1) > .9){
      inc *= -1;
    }
    //connections = new ArrayList<Vertex>();
  }
  
  public void addConnection(){
    numConnections++;
  }
  
  void update(){
    a += inc;
    pos.add(PVector.fromAngle(a).div(1.6));
  }
  
  void display(){
    noStroke();
    fill(255);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(r / 2);
    popMatrix();
  }
}
