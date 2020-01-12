public class King extends Piece{
  
  public King(boolean isWhite_){
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

    beginShape();
    vertex(-10, 20);
    vertex(10, 20);
    vertex(10, 10);
    vertex(20, 10);
    vertex(20, -10);
    vertex(10,-10);
    vertex(10, -20);
    vertex(-10, -20);
    vertex(-10, -10);
    vertex(-20, -10);
    vertex(-20, 10);
    vertex(-10, 10);
    endShape(CLOSE);
  }
  
  public String toString(){
    return super.toString("king");
  }
  
  public ArrayList<Square> getValidMoves(Board board){
    ArrayList<Square> moves = new ArrayList<Square>();
    
    //king is a rook and bishop combined for one loop
    //rook
    kingPieceAdd(moves, getFile(), getRank(), 0, 1);
    kingPieceAdd(moves, getFile(), getRank(), 0, -1);
    kingPieceAdd(moves, getFile(), getRank(), 1, 0);
    kingPieceAdd(moves, getFile(), getRank(), -1, 0);
    //bishop
    kingPieceAdd(moves, getFile(), getRank(), -1, -1);
    kingPieceAdd(moves, getFile(), getRank(), -1, 1);
    kingPieceAdd(moves, getFile(), getRank(), 1, -1);
    kingPieceAdd(moves, getFile(), getRank(), 1, 1);
    
    return moves;
  }
}
