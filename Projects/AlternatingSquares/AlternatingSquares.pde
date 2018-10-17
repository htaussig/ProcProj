float numSquares = 12;
ArrayList<Square> squares;
float angle;
color backCol;

void setup() {
  size(900, 900);
  background(255);
  angle = 0;
  backCol = color(255);
  squares = new ArrayList<Square>();
  float w = width / numSquares;
  float h = height / numSquares;
  float x = -2 * w;
  float y = -2 * h;
  while (y <= height) {
    squares.add(new Square(x, y, w, h, color(0)));
    x += 2 * w;
    if (!(x <= width)) {
      y += h;
      x = w * ((y / h) % 2) - (2 * w);
    }
  }
}

void draw() {
  float w = width / numSquares;
  float h = height / numSquares;
  background(backCol);
  if (squares.get(0).col == color(0)) {
    angle += radians(1);
  } else {
    angle += radians(1);
  }

  for (Square square : squares) {
    square.angle = angle;
    square.display();
  }

  if (abs(angle) % radians(90) < radians(1)) {
    //System.out.print("|");
    if (random(1) <= .5) {
      angle = 0;
      for (Square square : squares) {
        if (square.col == color(255)) {
          //System.out.println("black squares");
          square.x -= w;
          square.col = color(0);
          backCol = color(255);
        } else if (square.col == color(0)) {
          //System.out.println("white squares");
          square.x += w;
          square.col = color(255);
          backCol = color(0);
        }
      }
    }
  }
}
