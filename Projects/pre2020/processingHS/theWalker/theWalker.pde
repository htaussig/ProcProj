Walker walker;
ArrayList<Walker> walkers = new ArrayList<Walker>();

void setup(){
  frameRate(144);
  background(0);
  size(1920, 1080);
  
  /*for(int i = 35; i < 66; i += 60){
    for(int j = 234; j < 235; j += 10){
      for(int k = 35; k < 234; k += 10){
          walkers.add(new Walker(color(i, j, k, 10)));
      }
    }
  }*/
  
  for(int i = 0; i < 50; i++){
    walkers.add(new Walker(color(random(255), random(255), random(255), 40)));
  }
  
  /*color Color = color(35, 255, 247, 50);
  
  for(int i = 0; i < 20; i++){
    walkers.add(new Walker(Color));
  }
  
  Color = color(255, 251, 30, 50);
  for(int i = 0; i < 20; i++){
    walkers.add(new Walker(Color));
  }*/
}

void draw(){ 
  for(Walker walker: walkers){
    for(int i = 0; i < 180; i++){
      walker.walk();
      walker.display();
    }
  } 
 }
 
void keyPressed(){
    if(key == 'S'){
      saveFrame("line-######.png");
      System.out.println("Frame saved");
    }
}