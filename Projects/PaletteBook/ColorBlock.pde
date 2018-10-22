public class ColorBlock{
  
  color col;
  int size;
  
  public ColorBlock(color col_, int size_){
    col = col_;
    size = size_;
  }
  
  void display(float w, float h){
    fill(col);
    noStroke();
    
    rect(0, 0, w, h);
  }
  
  void display(float x, float y, float w, float h){
    fill(col);
    noStroke();
    
    rect(x, y, w, h);
  }
}
