public abstract class Piece{
  
  Square mySquare;
  
  public Piece(){
    
  }
  
  public Piece(boolean isWhite_){
    isWhite = isWhite_;
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
    if(board.hasPieceAt(newFile, newRank) && !isSameColor(board.getPiece(newFile, newRank))){
      moves.add(board.squares[newFile][newRank]);
    }
  }
  
  //stops when you get to the first piece, or meet the numLoops length
  //for pawns
  public void recursiveNoPieceAdd(ArrayList<Square> moves, int newFile, int newRank, int dx, int dy, int numLoops){
    newFile += dx;
    newRank += dy;
    
    if(!isOnBoard(newFile, newRank)){
      return;
    }
    
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
  //loops of one for the king
  public void kingPieceAdd(ArrayList<Square> moves, int newFile, int newRank, int dx, int dy){
    newFile += dx;
    newRank += dy;
    
    if(!isOnBoard(newFile, newRank)){
      return;
    }
    
    if(!board.hasPieceAt(newFile, newRank)){
      moves.add(board.squares[newFile][newRank]);
    }
    else{
      if(!isSameColor(board.getPiece(newFile, newRank))){
        moves.add(board.squares[newFile][newRank]);  
      }

      return;
    }
    return;
  }
  
  //for all pieces other than pawns
  //goes forever
  //used by all except king
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
      if(!isSameColor(board.getPiece(newFile, newRank))){
        moves.add(board.squares[newFile][newRank]);  
      }

      return;
    }
    recursivePieceAdd(moves, newFile, newRank, dx, dy);
  }
  
  boolean isSameColor(Piece p){
    return p.isWhite == isWhite;
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
    return "I am a " + pieceString + " on " + getMoveString(getFile(), getRank());
  }
  
  public int getFile(){
    return mySquare.file;
  }
  
  public int getRank(){
    return mySquare.rank;
  }
  
}
