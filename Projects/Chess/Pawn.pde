public class Pawn extends Piece{
  
  public Pawn(boolean isWhite_){
    super(isWhite_);
  }
  
  public void display(){
    strokeWeight(1);
    if(isWhite){
      stroke(0);
      fill(255);
    }
    else{
      stroke(255);
      fill(0);
    }

    ellipse(0, 0, 30, 30);
  }
  
  public String toString(){
    return super.toString("pawn");
  }
  
  public ArrayList<Square> getValidMoves(Board board){
    ArrayList<Square> moves = new ArrayList<Square>();
    int direction = 1;
    
    int numLoops = 1;
    
    if(!isWhite){
      direction = -1;
      if(getRank() == 6){
        //you can move forward two spaces with your first pawn move
        numLoops = 2;
      }
    }
    else{
      if(getRank() == 1){
        numLoops = 2;
      }
    }
    
    //noPieceAdd(moves, file, getRank() + direction, board);
    
    pieceAdd(moves, getFile() + 1, getRank() + direction, board);
    pieceAdd(moves, getFile() -1, getRank() + direction, board);
    
    
    recursiveNoPieceAdd(moves, getFile(), getRank(), 0, direction, numLoops);
    
    println("moves: " + getMovesString(moves));
    
    return moves;
  }
  
}
