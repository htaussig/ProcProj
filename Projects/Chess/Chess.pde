//sizes of the width and height of window
//must update size function with these
float WIDTH = 1000;
float HEIGHT = 1000;
//size of width and height of board
float bWIDTH = 800;

Board board;

void setup(){
  size(1000, 1000, P2D);
  
  board = new Board(bWIDTH);
  
  rectMode(CENTER);
}

void draw(){
  float margin = (WIDTH - bWIDTH) / 2;
  translate(margin, margin);
  background(120);
  board.display();
}

void mousePressed(){
  Square s = board.getSquare(mouseX, mouseY, WIDTH, HEIGHT);
  if(s != null){
    println(s.toString());
  }
  else{
    println("no");
  }
  board.displayMoves(s);
}
