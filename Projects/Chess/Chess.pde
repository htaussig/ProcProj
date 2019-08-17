//sizes of the width and height of window
float WIDTH = 1000;
float HEIGHT = 1000;
//size of width and height of board
float bWIDTH = 800;

Board board;

void setup(){
  size(1000, 1000);
  
  board = new Board(bWIDTH);
}

void draw(){
  float margin = (WIDTH - bWIDTH) / 2;
  translate(margin, margin);
  background(0);
  board.display();
}
