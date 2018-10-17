public class Board {

  int NUMROWS = 9;
  float xOff, yOff, s;
  boolean complete = false;
  
  ArrayList<Cell> unfilledList = new ArrayList<Cell>();

  Cell[][] cells = new Cell[NUMROWS][NUMROWS];

  public Board(float x_, float y_, float s_) {  
    xOff = x_;
    yOff = y_;
    s = s_;
    initBoard();
  }

  public void initBoard() {
    unfilledList.clear();
    for (int i = 0; i < NUMROWS; i++) {
      for (int j = 0; j < NUMROWS; j++) {
        cells[i][j] = new Cell(i, j);
        unfilledList.add(cells[i][j]);
      }
    }
  }

  public void generateNextCell() {
    Cell minPossCell = getMinPossCell();
    if (!minPossCell.assignRandom()) {
      backTrack();
    }
    else{
      unfilledList.remove(minPossCell);
    }
    board.updatePossibles(minPossCell);
  }

  //find the cell with the fewest possibilities not filled in yet
  public Cell getMinPossCell() { 
    //shouldn't get called if there is no unfilled cell left
    Cell minPossCell = null;
    int minPoss = 10;
    for (int i = 0; i < NUMROWS; i++) {
      for (int j = 0; j < NUMROWS; j++) {
        Cell cell = unfilledList.get((int) random(unfilledList.size()));
        if (!cell.isFilled()) {
          int numPoss = cell.getNumPoss();
          if (numPoss < minPoss) {
            minPoss = numPoss;
            minPossCell = cell;
          }
        }
      }
    }
    if (minPossCell == null) {
      System.out.println("The board was filled in when you called \"getMinPossCell\"");
    }
    return minPossCell;
  }

  public void backTrack() {
    initBoard();
    //resets++;
  }

  public void updatePossibles(Cell cell) {
    int removeNum = cell.getNum();
    int cellRow = cell.getTheRow();
    int cellCol = cell.getTheCol();

    //checking rows
    for (int colIndex = 0; colIndex < NUMROWS; colIndex++) {
      //System.out.println("j: " + colIndex);
      //System.out.println("cellRow: " + i);
      cells[cellRow][colIndex].removePoss(removeNum);
    }

    //checking columns
    for (int rowIndex = 0; rowIndex < NUMROWS; rowIndex++) {
      //System.out.println("i: " + rowIndex);
      //System.out.println("cellCol: " + j);
      cells[rowIndex][cellCol].removePoss(removeNum);
    }

    //checking 3x3s
    check3x3s(cell, removeNum);
  }

  public void check3x3s(Cell cell, int removeNum) {
    int boxI = (cell.getTheRow() / 3) * 3;
    int boxJ = (cell.getTheCol() / 3) * 3;
    for (int rowIndex = 0; rowIndex < 3; rowIndex++) {
      for (int colIndex = 0; colIndex < 3; colIndex++) {
        cells[rowIndex + boxI][colIndex + boxJ].removePoss(removeNum);
        //cells[rowIndex + boxI][colIndex + boxJ].checked++;
      }
    }
  }

  public void display() {
    displayGrid();
    displayNums();
  }


  public void displayGrid() {
    float curX = xOff;
    float curY = yOff;
    //float nextX, nextY;
    float endX = xOff + s;
    float endY = yOff + s;
    strokeWeight(3);
    for (int i = 0; i <= NUMROWS; i++) {
      if (i % 3 == 0) {
        strokeWeight(3);
      } else {
        strokeWeight(1);
      }
      //horizontal
      line(xOff, curY, endX, curY);
      //vertical
      line(curX, yOff, curX, endY);
      curX += s / NUMROWS;
      curY += s / NUMROWS;
    }
  }

  public void displayNums() {
    for (int i = 0; i < NUMROWS; i++) {
      for (int j = 0; j < NUMROWS; j++) {
        Cell cell = cells[i][j];
        int num = cell.getNum();
        if (num != -1) {
          float x = (s / (2 * NUMROWS)) + xOff + ((float) j / NUMROWS) * s;
          float y = (s / (2 * NUMROWS)) + yOff + ((float) i / NUMROWS) * s;
          //fill((255 + cell.checked) % 255);
          text(num, x, y);
        }
      }
    }
  }

  public boolean isComplete() {  
    for (int i = 0; i < NUMROWS; i++) {
      for (int j = 0; j < NUMROWS; j++) {
        if (!cells[i][j].isFilled()) {
          return false;
        }
      }
    }
    return true;
  }
}
