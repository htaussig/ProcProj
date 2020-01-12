Walker walker;
ArrayList<Walker> walkers = new ArrayList<Walker>();
float time;

void setup(){
  frameRate(144);
  background(0);
  size(800, 800);
  
  /*for(int i = 35; i < 66; i += 60){
    for(int j = 234; j < 235; j += 10){
      for(int k = 35; k < 234; k += 10){
          walkers.add(new Walker(color(i, j, k, 60)));
      }
    }
  }*/
  
  for(int i = 0; i < 5; i++){
    walkers.add(new Walker(color(random(255), random(255), random(255), 10)));
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
  for(int i = 0; i < 20; i++){
    for(Walker walker: walkers){
      walker.walk(time);
      walker.display();  
    } 
    time += .0005;
  }  
 }
 
void keyPressed(){
    if(key == 'S'){
      saveFrame("line-######.png");
      System.out.println("Frame saved");
    }
}