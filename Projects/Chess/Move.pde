public class Move{
  //
  int rank;
  int file;
  
  public Move(int file_, int rank_){
    rank = rank_;
    file = file_;
  }
  
  int getRank(){
   return rank; 
  }
  
  int getFile(){
    return file;
  }
  
  String toString(){
    return getMoveString(file, rank);
  }
}

public String getMoveString(int file, int rank){
  String str = "";
    
  char fileChar = char('a' + file);
  int rankInt = rank + 1;
  
  str += fileChar;
  str += rankInt;
  
  return str;
}
