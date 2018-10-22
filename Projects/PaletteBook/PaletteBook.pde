color backGCol;
ArrayList<Palette> palettes;

void setup(){
  size(600, 600);
  backGCol = color(255);
  palettes = new ArrayList<Palette>();
  
  Palette palette = new Palette(50, 50, 200, 100);
  palette.addColor(new ColorBlock(color(255, 0, 2), 40));
  palette.addColor(new ColorBlock(color(2, 0, 255), 60));
  
  palettes.add(palette);
  
}

void draw(){
  background(backGCol);
  for(Palette pal : palettes){
    pal.display();
  }
  instructionText();
}

void instructionText(){
  fill(#006EFA);
  text("space = toggle dark background", 10, 15);
} 

void keyPressed(){
  if(key == ' '){
    if(backGCol == color(255)){
      backGCol = (color(0));
    }
    else{
      backGCol = color(255);
    }
  }
}
