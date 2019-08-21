public abstract class Piece{
  
  int file, rank;
  
  public Piece(){
    
  }
  
  public Piece(boolean isWhite_, int file_, int rank_){
    isWhite = isWhite_;
    file = file_;
    rank = rank_;
  }
  
  boolean isWhite;
  
  abstract void display();
  
  abstract ArrayList<Square> getValidMoves(Board board);
  
  void getCaptured(){
    return;
  }
  
  //only valid if there is no piece on this square
  public void noPieceAdd(ArrayList<Square> moves, int newFile, int newRank, Board board){
    if(!board.hasPieceAt(newFile, newRank)){
      moves.add(board.squares[newFile][newRank]);
    }
  }
  
  //only valid if there is a piece on this square
  public void pieceAdd(ArrayList<Square> moves, int newFile, int newRank, Board board){
    if(board.hasPieceAt(newFile, newRank)){
      moves.add(board.squares[newFile][newRank]);
    }
  }
  
  
  public String getMovesString(ArrayList<Square> moves){
    String str = "";
    
    for(Square m : moves){
      str += m.moveToString();
    }
    
    return str;
  }
  
  public String toString(String pieceString){
    return "I am a " + pieceString + " on " + getMoveString(file, rank);
  }
  
}
