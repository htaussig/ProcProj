public class Palette{
  
  ArrayList<ColorBlock> colorBlocks;
  
  public Palette(){
    colorBlocks = new ArrayList<ColorBlock>();
  }
  
  //number in the string must be two digits
  public Palette(String code){
    colorBlocks = new ArrayList<ColorBlock>();
    precondition(code.length() % 9 == 0, "Palette constructor length");
    
    for(int i = 0; i < code.length() / 9; i++){
      String str9 = code.substring(i * 9, (i + 1) * 9);
      String strNum = str9.substring(0, 2);
      int num = Integer.parseInt(strNum);
      color col = hexToColor(str9.substring(3));
      addColor(new ColorBlock(col, num));
    }
    
    normalizeNums();
  }
  
  void normalizeNums(){
    float sum = 0;
    for(ColorBlock cBlock : colorBlocks){
      sum += cBlock.size;
    }
    for(ColorBlock cBlock : colorBlocks){
      cBlock.size *= 100 / sum;
    }
    
  }
  
  color hexToColor(String hex){
    int r = unhex(hex.substring(0, 2));
    int g = unhex(hex.substring(2, 4));
    int b = unhex(hex.substring(4));
    return color(r, g, b);
  }
  
  void addColor(ColorBlock cBlock){
    colorBlocks.add(cBlock);
    ////System.out.println(colorBlocks.size());
  }
  
  String toString(){
    String str = "";
    for(ColorBlock cBlock : colorBlocks){
      str += (int) cBlock.size + "#";
      str += hex(cBlock.col).substring(2);
    }  
    return "\"" + str + "\"";
  }
  
  color getColor(){
    float num = random(100);
    int i = 0;
    
    while(true){
      ColorBlock cBlock = colorBlocks.get(i);
      num -= cBlock.size;
      i++;
      if(num <= 0){
        return cBlock.col;
      }
    }
  }
  
  color getLightestColor(){
    float num = 99.99;    
    int i = 0;
    color bCol = colorBlocks.get(0).col;
    
    while(true){
      ColorBlock cBlock = colorBlocks.get(i);
      num -= cBlock.size;
      i++;
      if(brightness(cBlock.col) > brightness(bCol)){
        bCol = cBlock.col;
      }
      if(num <= 0){
        return bCol;
      }
    }
  }
  
}

public class ColorBlock{
  
  color col;
  float size;
  
  public ColorBlock(color col_, float size_){
    col = col_;
    size = size_;
  }

}

void precondition(boolean b, String text) {
  if (!b) {
    System.out.println(text + "precondition failed ");
    stop();
  }
}
