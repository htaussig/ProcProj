public class Bishop extends Piece{

  public Bishop(boolean isWhite_){
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
    vertex(0, -20);
    vertex(10, 20);
    vertex(-10, 20);
    endShape(CLOSE);
    //ellipse(0, 0, 20, 20);
  }
  
  public String toString(){
    return super.toString("bishop");
  }
  
  public ArrayList<Square> getValidMoves(Board board){
    ArrayList<Square> moves = new ArrayList<Square>();
    
    recursivePieceAdd(moves, getFile(), getRank(), -1, -1);
    recursivePieceAdd(moves, getFile(), getRank(), -1, 1);
    recursivePieceAdd(moves, getFile(), getRank(), 1, -1);
    recursivePieceAdd(moves, getFile(), getRank(), 1, 1);
    
    
    return moves;
  }
}
