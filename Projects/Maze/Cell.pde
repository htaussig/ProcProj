public class Cell {
  float x, y;
  boolean pathed;
  boolean checked;
  ArrayList<Cell> connectedCells;
  public Cell(float x_, float y_) {
    x = x_;
    y = y_;
    pathed = false;
    connectedCells = new ArrayList<Cell>();
  }

  public void addConCell(Cell cell){
    connectedCells.add(cell);
  }

  public void display() {
    //fill(255);
    stroke(255);
    if(checked){
      //stroke(255, 0, 0);
    }
    pushMatrix();
    translate(x, y);
    for (float a = 0; a < TWO_PI - .1; a += DA) {
      float newX = x + (cos(a) * cellDist / 2);
      float newY = y + (sin(a) * cellDist / 2);
      Path path = getPath(newX, newY);
      if(path == null){
        float temp = NUMSIDES;
        arc(0, 0, cellD, cellD, a - (PI / temp), a + (PI / temp));
      }  
    }
    //ellipse(0, 0, cellD, cellD);
    popMatrix();
    
    drawPaths();
  }
  
  void drawPaths(){
    
  }
}
