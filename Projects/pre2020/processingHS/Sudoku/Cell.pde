public class Cell {

  int number;
  int row, col;
  ArrayList<Integer> possibles;
  //int checked = 0;

  public Cell(int row_, int col_) {
    row = row_;
    col = col_;
    number = -1;
    possibles = new ArrayList<Integer>();
    for (int i = 1; i <= 9; i++) {
      possibles.add(i);
    }
  }

  public void removePoss(int removeNum) {
    int index = possibles.indexOf(removeNum);
    if (index != -1) {
      possibles.remove(index);
    }
  }

  public boolean assignRandom() {
    printPossibles();
    if (possibles.size() == 0) {
      number = -1;
      return false;
      //delay(10000);
    } else {
      number = possibles.get((int) random(0, possibles.size()));
      System.out.println("picked: " + number);
    }
    possibles.clear();
    return true;
  }
  
  public void printPossibles(){
   for(Integer num : possibles){
    System.out.print("possible: " + num + ", "); 
   }
  }

  public int getNum() {
    return number;
  }
  
  public int getTheRow(){
   return row;
  }
  
  public int getTheCol(){
    return col;
  }
  
  public int getNumPoss(){
    return possibles.size();
  }
  
  public boolean isFilled(){
   return number != -1; 
  }
}
