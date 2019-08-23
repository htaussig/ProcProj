public class Queen extends Piece{
  
  public Queen(boolean isWhite_){
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

    rectMode(CENTER);
    rect(0, 0, 20, 60);
  }
  
  public String toString(){
    return super.toString("queen");
  }
  
  public ArrayList<Square> getValidMoves(Board board){
    ArrayList<Square> moves = new ArrayList<Square>();

    //queen is a rook and bishop combined
    //rook
    recursivePieceAdd(moves, getFile(), getRank(), 0, 1);
    recursivePieceAdd(moves, getFile(), getRank(), 0, -1);
    recursivePieceAdd(moves, getFile(), getRank(), 1, 0);
    recursivePieceAdd(moves, getFile(), getRank(), -1, 0);
    
    //bishop
    recursivePieceAdd(moves, getFile(), getRank(), -1, -1);
    recursivePieceAdd(moves, getFile(), getRank(), -1, 1);
    recursivePieceAdd(moves, getFile(), getRank(), 1, -1);
    recursivePieceAdd(moves, getFile(), getRank(), 1, 1);
    
    return moves;
  }
}
