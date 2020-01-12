int BOXSIZE = 25;

Point[][] points;
ArrayList<Segment> segments;

void setup() {
  size(1000, 1000);
  background(255);

  createPoints();
  createSegments();
}

void createPoints() {
  int w = width / BOXSIZE;
  int h = height / BOXSIZE;
  points = new Point[w + 1][h + 1];
  for (int i = 0; i <= w; i++) {
    for (int j = 0; j <= h; j++) {
      points[i][j] = new Point(i * BOXSIZE, j * BOXSIZE);
    }
  }

  createSegments(w, h);

  display();
}

void createSegments(float w, float h) {
  segments = new ArrayList<Segment>();
  
  for (int i = 0; i <= w; i++) {
    for (int j = 0; j <= h; j++) {
      points[i][j] = new Point(i * BOXSIZE, j * BOXSIZE);
      int x = i + 1;
      int y = j - 1;
      if(x <= w && y >= 0){
        segments.add(new Segment(points[i][j], points[x][y]));
      }
      
    }
  }
}

void display() {
  for (Point[] pArr : points) {
    for (Point p : pArr) {
      p.display();
      println("yeah");
    }
  }
}

void draw() {
}
