public abstract class Piece{
  
  int file, rank;
  Square mySquare;
  
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
  
  //stops when you get to the first piece, or meet the numLoops length
  //for pawns
  public void recursiveNoPieceAdd(ArrayList<Square> moves, int newFile, int newRank, int dx, int dy, int numLoops){
    newFile += dx;
    newRank += dy;
    if(!board.hasPieceAt(newFile, newRank)){
      moves.add(board.squares[newFile][newRank]);
    }
    else{
      return;
    }
    
    numLoops--;
    if(numLoops == 0){
      return;
    }
    else{
      recursiveNoPieceAdd(moves, newFile, newRank,dx, dy, numLoops);
    }
  }
  
  //for all pieces other than pawns
  public void recursivePieceAdd(ArrayList<Square> moves, int newFile, int newRank, int dx, int dy){
    newFile += dx;
    newRank += dy;
    
    if(!isOnBoard(newFile, newRank)){
      return;
    }
    
    if(!board.hasPieceAt(newFile, newRank)){
      moves.add(board.squares[newFile][newRank]);
    }
    else{
      moves.add(board.squares[newFile][newRank]);
      return;
    }
    
    recursivePieceAdd(moves, newFile, newRank, dx, dy);
  }
  
  public void setSquare(Square s){
    mySquare = s; 
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
