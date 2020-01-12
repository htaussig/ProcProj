/**TODO:
en passant
check
  checkmate

draws
  3rd same position
  50 move
  stalemate
**/

//sizes of the width and height of window
//must update size function with these
float WIDTH = 1000;
float HEIGHT = 1000;
//size of width and height of board
float bWIDTH = 800;

Board board;
Square lastSquare;

boolean isWhiteTurn = true;

void setup() {
  size(1000, 1000);

  board = new Board(bWIDTH);

  rectMode(CENTER);
}

void draw() {
  float margin = (WIDTH - bWIDTH) / 2;
  translate(margin, margin);
  background(120);
  board.display();
}

void mousePressed() {

  Square s = board.getSquare(mouseX, mouseY, WIDTH, HEIGHT);
  

  //some whack stuff going here
  if (s != null) {
    if (s.isValidMove && lastSquare.hasPiece()) {
      if(lastSquare.piece.isWhite == isWhiteTurn){
        movePiece(s);
        isWhiteTurn = !isWhiteTurn;
      }
    } else {  
      lastSquare = s;

      board.resetDisplay();
      println(s.toString());
      if(s.hasPiece() && s.piece.isWhite == isWhiteTurn){
        board.displayMoves(s);
      }     
    }
  }
}

void movePiece(Square s){
    lastSquare.movePiece(s);
    board.resetDisplay();
    
    checkForCheck();
}

void checkForCheck(){
  for(int q = 0; q < 8; q++){
    for(int r = 0; r < 8; r++){
      Square s = board.getSquare(q, r);
      board.displayMoves(s);
      
      if(board.checkForTheCheck(isWhiteTurn)){
        println("check!");
      }
      else{
        //println("nocheck");
      }
    }
  } //<>//
  board.resetDisplay();
}
