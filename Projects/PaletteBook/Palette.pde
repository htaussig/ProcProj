public class Palette{
  
  ArrayList<ColorBlock> colorBlocks;
  float x, y;
  float w, h;
  
  public Palette(float x_, float y_, float w_, float h_){
    colorBlocks = new ArrayList<ColorBlock>();
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  void addColor(ColorBlock cBlock){
    colorBlocks.add(cBlock);
  }
  
  void display(){
    pushMatrix();
    translate(x, y);
    for(ColorBlock cBlock : colorBlocks){
      translate((cBlock.size) * (w / 100), 0);
      cBlock.display(w, h);
    }
    popMatrix();
  }
  
}
