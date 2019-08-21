public class Knight extends Piece{
  
  public Knight(boolean isWhite_, int file_, int rank_){
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

    beginShape();
    vertex(-10, -30);
    vertex(10, -30);
    vertex(10, 20);
    //vertex(-10, 20);
    
    vertex(30, 10);
    vertex(30, 30);
    //vertex(20, 40);
    vertex(-30, 30);
    vertex(-30, 10);
    vertex(-10, 10);
    endShape(CLOSE);
  }
  
  public String toString(){
    return super.toString("knight");
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
