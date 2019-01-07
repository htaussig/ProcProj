import processing.svg.*;

int NUMSIDES = 4;
float DA = TWO_PI / NUMSIDES;
float cellD = 25;
float cellDist = cellD * sqrt(2);
ArrayList<Cell> maze = new ArrayList<Cell>();
ArrayList<Path> paths = new ArrayList<Path>();

void setup() {
  size(500, 500); 
  noStroke();
  rectMode(CENTER);
  fill(255);
  noLoop();
  beginRecord(SVG, "Maze" + (int) cellD + ".svg");
  setup1();
}

void setup1() {

  paths.clear();
  maze.clear();
  generateMazeCells(width / 2, height / 2);
  generatePaths();
}

void draw() {
  background(0);
  rectMode(CENTER);
  float xmax = getMaxX();
  float ymax = getMaxY();
  float xmin = getMinX();
  float ymin = getMinY();
  curveRect(xmin, xmax, ymin, ymax);
  for (Path path : paths) {
    path.display();
  }
  for (Cell cell : maze) {
    cell.display();
  }
  endRecord();
  //System.out.println(paths.size());
}

void curveRect(float xmin, float xmax, float ymin, float ymax) {
  noFill();
  ArrayList<Cell> cells = new ArrayList<Cell>();
  ArrayList<Path> paths = new ArrayList<Path>();

  for (int i = 0; i < 2; i++) {
    float y = ymin - cellDist;
    if (i == 1) {
      y = ymax + cellDist;
    }
    int counter = 0;
    for (float x = xmin - cellDist; x <= xmax + cellDist; x += cellDist / 2) {
      if (counter % 2 == 1) {
        paths.add(new Path(x, y, 0));
      } else {
        cells.add(new Cell(x, y));
      }
      counter++;
    }
  }

  for (int i = 0; i < 2; i++) {
    float x = xmin - cellDist;
    if (i == 1) {
      x = xmax + cellDist;
    }
    int counter = 0;
    for (float y = ymin - cellDist; y <= ymax + cellDist; y += cellDist / 2) {
      if (counter % 2 == 1) {
        paths.add(new Path(x, y, PI / 2));
      } else {
        cells.add(new Cell(x, y));
      }
      counter++;
    }
  }

  for (Cell cell : cells) {
    cell.display();
  } 
  for (Path path : paths) {
    path.display();
  }
}

float getMaxX() {
  float temp = width / 2;
  for (Cell cell : maze) {
    if (cell.x > temp) {
      temp = cell.x;
    }
  }
  return temp;
}

float getMinX() {
  float temp = width / 2;
  for (Cell cell : maze) {
    if (cell.x < temp) {
      temp = cell.x;
    }
  }
  return temp;
}

float getMaxY() {
  float temp = width / 2;
  for (Cell cell : maze) {
    if (cell.y > temp) {
      temp = cell.y;
    }
  }
  return temp;
}

float getMinY() {
  float temp = width / 2;
  for (Cell cell : maze) {
    if (cell.y < temp) {
      temp = cell.y;
    }
  }
  return temp;
}

void generatePaths() {
  int i = 0;
  while (i < maze.size()) {
    Cell cell = getPathableCell();
    if (!genPath(cell)) {
      i++;
    } else {
      i = 0;
    }
  }
  //go through and make a path for any unpathed celles
  for (Cell cell : maze) {
    genPath(cell);
  }
  //System.out.println(i + " " + paths.size());
  //System.out.println(numLoneLeft());
}

boolean genPath(Cell cell) {
  float ain = ((int) random(NUMSIDES)) * DA;
  //System.out.println("////////");
  for (float a = ain; a < TWO_PI + ain - .1; a += DA) {
    float newX = cell.x + (cos(a) * cellDist);
    float newY = cell.y + (sin(a) * cellDist);
    Cell neighbor = getCell(newX, newY);

    newX = cell.x + (cos(a) * cellDist / 2);
    newY = cell.y + (sin(a) * cellDist / 2);
    //System.out.println(neighbor != null);
    if (neighbor != null && (!isPath(newX, newY)) && isPathable(cell)) {
      //System.out.println(isPathable(neighbor));
      //System.out.println("new");
      //System.out.println(getNumPaths(neighbor));
      if (isPathable(neighbor)) {
        Path maybPath = new Path(newX, newY, a);
        if (causesNoLoops(neighbor, cell)) {
          //System.out.println("new path");
          cell.addConCell(neighbor);
          neighbor.addConCell(cell);
          addPath(maybPath);
          cell.pathed = true;
          return true;
        }
      }
    }
  }
  return false;
}

boolean causesNoLoops(Cell end, Cell start) {
  for (Cell cell : maze) {
    cell.pathed = false;
  }
  start.pathed = true;
  return theLoop(start.connectedCells, end);
}


boolean theLoop(ArrayList<Cell> children, Cell end) {
  for (Cell cell : children) {
    if (cell == end) {
      //System.out.println("yeah");
      return false;
    }
    if (cell.pathed == false) {
      cell.pathed = true;
      return theLoop(cell.connectedCells, end);
    }
  }
  return true;
}

void addPath(Path path) {
  paths.add(path);
}

int numLoneLeft() {
  int i = 0;
  for (Cell cell : maze) {
    if (getNumPaths(cell) == 0) {
      i++;
    }
  }
  return i;
}

Cell getPathableCell() {
  int startNum = (int) random(maze.size());
  for (int i = startNum; i <= maze.size() + startNum; i++) {
    int index = i % maze.size();
    Cell cell = maze.get(index);
    if (cell.pathed == false) {
      return cell;
    }
  }
  return null;
}

boolean isPathable(Cell cell) {
  if (cell == null) {
    //System.out.println("null cell passed to isPathable");
  }
  //return random(1) < .6;
  return getNumPaths(cell) < NUMSIDES / 2 ;
}

int getNumPaths(Cell cell) {
  int num = 0;
  for (float a = 0; a < TWO_PI - .1; a += DA) {
    float newX = cell.x + (cos(a) * cellDist / 2);
    float newY = cell.y + (sin(a) * cellDist / 2);
    if (isPath(newX, newY)) {
      num++;
    }
  }
  return num;
}

boolean isPath(Cell cell, float a) {
  float newX = cell.x + (cos(a) * cellDist / 2);
  float newY = cell.y + (sin(a) * cellDist / 2);

  for (Path path : paths) {
    if (dist(path.x, path.y, newX, newY) < 1) {
      return true;
    }
  }
  return false;
}

boolean isPath(float x, float y) {
  for (Path path : paths) {
    if (dist(path.x, path.y, x, y) < 1) {
      return true;
    }
  }
  return false;
}

void generateMazeCells(float x, float y) {
  maze.add(new Cell(x, y));

  for (float a = 0; a < TWO_PI - .1; a += TWO_PI / NUMSIDES) {
    //System.out.println(a);
    float newX = x + (cos(a) * cellDist);
    float newY = y + (sin(a) * cellDist);
    if (validPosition(newX, newY)) {
      generateMazeCells(newX, newY);
    }
  }
  //System.out.println(maze.size());
}

boolean validPosition(float x, float y) {
  boolean b = !cellHere(x, y);
  if (x < cellD || x > width - cellD || y < cellD || y > height - cellD) {
    //System.out.println("out");
    return false;
  }
  //System.out.println("out1");
  return b;
}

Path getPath(float x, float y) {
  for (Path path : paths) {
    if (dist(x, y, path.x, path.y) < cellD / 2) {
      return path;
    }
  }
  return null;
}

Cell getCell(float x, float y) {
  for (Cell cell : maze) {
    if (dist(x, y, cell.x, cell.y) < cellD / 2) {
      return cell;
    }
  }
  return null;
}

boolean cellHere(float x, float y) {
  return getCell(x, y) != null;
}

void keyPressed() {
  setup1();
}

void mousePressed() {
  Cell cell = getCell(mouseX, mouseY);
  if (cell != null) {
    //System.out.println("genPath");
    genPath(cell);
  }

  //System.out.println("ya");
}
