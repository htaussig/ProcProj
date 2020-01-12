
//does this save?
Board board;
//int completeBoards = 0;
//int resets = 0;

void setup() {  
  size(800, 800);
  //frameRate(1200);
  textSize(24);
  fill(0);
  //background(#A2D331);
  board = new Board(50, 50, 700);
}

void draw() {
  background(158);
  
  if(!board.isComplete()){
    board.generateNextCell();
  }
  else{ 
    //board.initBoard();
    //completeBoards++;
  }

  board.display();
}

void mouseClicked(){
  if(!board.isComplete()){
    board.generateNextCell();
  }
  else{
    board.initBoard();
  }
}

void keyPressed(){
 /*if(key == 'q'){
   System.out.println("complete percentage of: " + (double) completeBoards / (resets + completeBoards));
 }*/
}
