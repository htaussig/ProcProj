//myopic chess engine

public class Board{
  
  float boardW;
  Square[][] squares;

  public Board(float w_){
    boardW = w_;

    
    squares = new Square[8][8];
    boolean isWhite = true;
    for(int i = 0; i < 8; i++){
      for(int m = 0; m < 8; m++){
        int file = i;
        int rank = 7-m;
        squares[file][rank] = new Square((boardW / 8) * i, (boardW / 8) * m, file, rank, boardW / 8, isWhite);
        isWhite = !isWhite;
      }
      isWhite = !isWhite;
    }
    
    createPieces();
  }
  
  void createPieces(){ 
    for(int m = 0; m < 8; m++){
      //true means the pieces are white
      squares[m][1].movePieceHere(new Pawn(true, m, 1));
      squares[m][6].movePieceHere(new Pawn(false, m, 6));
      createHomeRow(0, true);
      createHomeRow(7, false);
    }
  }
  
  void createHomeRow(int colNum, boolean isWhite){
    squares[0][colNum].movePieceHere(new Rook(isWhite, 0, colNum));
    squares[7][colNum].movePieceHere(new Rook(isWhite, 7, colNum));
    
    squares[1][colNum].movePieceHere(new Knight(isWhite, 1, colNum));
    squares[6][colNum].movePieceHere(new Knight(isWhite, 6, colNum));
    
    squares[2][colNum].movePieceHere(new Bishop(isWhite, 2, colNum));
    squares[5][colNum].movePieceHere(new Bishop(isWhite, 5, colNum));
    
    squares[3][colNum].movePieceHere(new Queen(isWhite, 3, colNum));
    squares[4][colNum].movePieceHere(new King(isWhite, 4, colNum));
  }
  
  boolean hasPieceAt(int file, int rank){
    if(file > 7 || file < 0 || rank > 7 || rank < 0){
      return false;
    }
    return squares[file][rank].hasPiece();
  }
  
  Square getSquare(float x, float y, float screenW, float screenH){
    float xAdd = (screenW - boardW) / 2;
    float yAdd = (screenH - boardW) / 2;
    
    float sWidth = boardW / 8.0;
    
    x -= xAdd;
    y -= yAdd;
    
    if(x < 0 || x > boardW || y < 0 || y > boardW){
      return null;
    }
    
    int squareX = floor(x / sWidth);
    int squareY = 7 - floor(y / sWidth);
    
    return squares[squareX][squareY];
  }
  
  void displayMoves(Square s){
    Piece p = s.getPiece();
    if(p != null){
      for(Square m : p.getValidMoves(this)){
        m.setValidMove(true);
      }
    }
  }
  
  //stop displaying all moves
  void resetDisplay(){
    for(int i = 0; i < 8; i++){
      for(int m = 0; m < 8; m++){
        squares[i][m].isValidMove = false;
      }
    }
  }
  
  void display(){
    for(int i = 0; i < 8; i++){
      float sWidth = boardW / 8.0;
      
      text(8 - i, ((WIDTH - boardW) / 2.0) - sWidth - 20, (((WIDTH - boardW) / 2) + sWidth * i) - sWidth / 2);
      for(int m = 0; m < 8; m++){
        squares[i][m].display();
      }
    }
  }
}

boolean isOnBoard(int f, int r){
  if(f < 0 || f > 7 || r < 0 || r > 8){
    return false; 
  }
  return true;
}
