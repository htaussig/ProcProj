public class CurvyShape{
  
  PVector pos;
  float a = -19;
  
  public CurvyShape(float x_, float y_){
    pos = new PVector(x_, y_);
    gen();
  }
  
  //generate a curvy shape
  public void gen(){
    if(a == -19){
      a = PVector.sub(pos, new PVector(width / 2, height / 2)).heading();
    }
    
    pos.add(PVector.fromAngle(a));
    
  }
  
}
