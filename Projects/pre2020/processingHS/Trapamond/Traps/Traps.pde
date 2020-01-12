ArrayList<Trap> traps = new ArrayList<Trap>();
float zA = 0;
boolean rotating2Traps = false;

void setup() {
  size(600, 600, P3D);
  traps.add(new Trap(0, 0, 0, 160, 0));
}

void draw() {
  translate(width / 2, height / 2);
  rotateZ(zA);
  background(0);
  lights();
  if(rotating2Traps){
   rotate2Traps(); 
  }
  for (Trap trap : traps) {
    //trap.zA += radians(1);
    trap.display();
  }
  //zA += radians(1);
}

void rotate2Traps(){
 Trap trap0 = traps.get(0);
 Trap trap2 = traps.get(2); 
 Trap trap3 = traps.get(3);
 //something wrong with this if statement, right side doesnt matter
 if(abs((trap2.zA + trap2.rBL) % (2 * PI) - trap0.zA % (2 * PI)) > radians(1.01)){
   trap2.rBotLeft(radians(1));
 }
 else{
  trap2.rBL = trap0.zA - trap2.zA;
 }
 
}

void mouseClicked() {
  if (traps.size() == 1) {
    ArrayList<Trap> next = new ArrayList<Trap>();
    for (Trap trap : traps) {
      for (Trap nextTrap : trap.get4Traps()) {
        next.add(nextTrap);
      }
    }
    traps = next;
  }
  else{
   rotating2Traps = true;
  }
}

void keyPressed() {
  int num = key - '0';
  System.out.println(num);
  traps.get(0).zA = num * 2 * PI / 10.0;
  rotating2Traps = false;
  for (int i = traps.size() - 1; i > 0; i--) {
    traps.remove(i);
  }
}