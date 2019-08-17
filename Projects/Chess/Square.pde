public class Square{
  
  float w,x, y;
  boolean isWhite;
  
  public Square(float x_, float y_, float w_, boolean isWhite_){
    x = x_;
    y = y_;
    w = w_;
    isWhite = isWhite_;
  }
  
  void display(){
    noStroke();
    
    if(isWhite){
      fill(245);
    }
    else{
      fill(135, 201, 149);
    }
    
    rect(x, y, w, w);
  }
}
