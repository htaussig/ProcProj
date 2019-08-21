public class Rook extends Piece{
  
  public Rook(boolean isWhite_, int file_, int rank_){
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
    
    //translate(-10, -10);
    rectMode(CENTER);
    rect(0, 0, 40, 40);
    rect(0, 0, 20, 20);
  }
  
  public String toString(){
    return super.toString("rook");
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
