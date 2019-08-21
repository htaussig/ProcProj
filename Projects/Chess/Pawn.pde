public class Pawn extends Piece{
  
  public Pawn(boolean isWhite_, int file_, int rank_){
    super(isWhite_, file_, rank_);
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
    
    if(!isWhite){
      direction = -1;
    }
    
    noPieceAdd(moves, file, rank + direction, board);
    pieceAdd(moves, file + 1, rank + direction, board);
    pieceAdd(moves, file -1, rank + direction, board);
    
    println("moves: " + getMovesString(moves));
    
    return moves;
  }
  
}
