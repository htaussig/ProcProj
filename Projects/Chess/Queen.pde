public class Queen extends Piece{
  
  public Queen(boolean isWhite_, int file_, int rank_){
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

    rectMode(CENTER);
    rect(0, 0, 20, 60);
  }
  
  public String toString(){
    return super.toString("queen");
  }
  
  public ArrayList<Square> getValidMoves(Board board){
    ArrayList<Square> moves = new ArrayList<Square>();
    int direction = 1;
    
    if(!isWhite){
      direction = -1;
    }
    
    noPieceAdd(moves, file, rank + direction, board);
    
    return moves;
  }
}
