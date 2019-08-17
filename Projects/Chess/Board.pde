public class Board{
  
  float w;
  Square[][] squares;
  
  public Board(float w_){
    w = w_;
    
    squares = new Square[8][8];
    boolean isWhite = true;
    for(int i = 0; i < 8; i++){
      for(int m = 0; m < 8; m++){
        squares[i][m] = new Square((w / 8) * i, (w / 8) * m, w / 8, isWhite);
        isWhite = !isWhite;
      }
      isWhite = !isWhite;
    }
    
  }
  
  void display(){
    for(int i = 0; i < 8; i++){
      for(int m = 0; m < 8; m++){
        squares[i][m].display();
      }
    }
    
  }
}
