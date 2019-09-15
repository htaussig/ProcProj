public class Square{
  
  float w,x, y;
  int file, rank;
  boolean isWhite;
  //null when no piece on this square
  Piece piece = null;
  boolean isValidMove = false;
  
  public Square(float x_, float y_, int file_, int rank_, float w_, boolean isWhite_){
    x = x_;
    y = y_;
    file = file_;
    rank = rank_;
    w = w_;
    isWhite = isWhite_;
  }
  
  void setValidMove(boolean b){
    isValidMove = b;
  }
  
  boolean hasPiece(){
    return piece != null;
  }
  
  void movePiece(Square newSquare){    
    newSquare.movePieceHere(piece);
    
    movePieceAway();
  }
  
  void movePieceHere(Piece movingPiece){
    if(piece != null){
      piece.getCaptured();
    }
    piece = movingPiece;
    piece.setSquare(this);
  }
  
  void movePieceAway(){
    piece = null;
  }
  
  String toString(){
    if(piece == null){
      return "I am an empty Square";
    }
    else{
      return piece.toString();
    }
  }
  
  String moveToString(){
    return getMoveString(file, rank);
  }
  
  Piece getPiece(){
    return piece;
  }
  
  boolean getPieceTeam(){
    return piece.isWhite;
  }
  
  void display(){
    noStroke();
    
    if(isWhite){
      fill(245);
    }
    else{
      fill(135, 201, 149);
    }
    
    pushMatrix();
      translate(x, y);
      rectMode(CORNER);
      rect(0, 0, w, w);
      
      
      translate(w / 2, w / 2);
      
      if(isValidMove){
         fill(0, 35);
         ellipse(0, 0, 45, 45);
      }   
      
      if(piece != null){
        //translate(w / 2, w / 2);
        piece.display();
      }
      
      
    popMatrix();
    
  }
}
