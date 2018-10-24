public class ColorBlock{
  
  color col;
  float size;
  
  public ColorBlock(color col_, float size_){
    col = col_;
    size = size_;
  }
  
  void display(float w, float h){
    fill(col);
    noStroke();
    //stroke(1);
    //System.out.println(hex(col));
    rect(0, 0, w * size / 100, h);
  }

}
