float t;
ArrayList<Swing> swings = new ArrayList<Swing>();

void setup(){
  size(600, 1000, P2D);
  smooth(8);
  for(int i = 0; i < 10; i++){
    swings.add(new Swing(0, 0, 50, i + 1));
  }
  /*for(int i = 9; i > 0; i--){
    swings.add(new Swing(0, 0, 50, i + 1));
  }*/
}

void draw(){
  background(255);
  translate(width / 2, height / 16);
  for(int i = 0; i < swings.size(); i++){
    Swing swing = swings.get(i);
    if(i != 0){
      Swing lastSwing = swings.get(i - 1);
      swing.x = lastSwing.getX2();
      swing.y = lastSwing.getY2();
    }
    swing.t += .01;
    swing.display(); 
  }
  
}