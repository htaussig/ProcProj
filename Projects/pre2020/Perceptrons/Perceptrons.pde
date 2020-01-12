Perceptron brain;

Point[] points = new Point[1000];

void setup() {
  size(800, 800);
  brain = new Perceptron(3);

  for (int i =  0; i < points.length; i++) {
    points[i] = new Point();
  }

  /**float[] inputs = {-1, .5};
   int guess = brain.guess(inputs);
   println(guess);**/
}


void draw() {
  background(255);
  stroke(0);
  Point p1 = new Point(-1, f(-1));
  Point p2 = new Point(1, f(1));
  line(p1.getPX(), p1.getPY(), p2.getPX(), p2.getPY());

  Point p3 = new Point(-1, brain.guessY(-1));
  Point p4 = new Point(1, brain.guessY(1));

  line(p3.getPX(), p3.getPY(), p4.getPX(), p4.getPY());

  //don't need two loops
  for (Point pt : points) {
    pt.show();
  }

  for (Point pt : points) {
    float [] inputs = {pt.x, pt.y, pt.bias};
    int target = pt.label;
    brain.train(inputs, target);

    int guess = brain.guess(inputs);
    noStroke();
    if (guess == target) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    ellipse(pt.getPX(), pt.getPY(), 12, 12);
  }
}

void train(Point pt) {
  float [] inputs = {pt.x, pt.y, pt.bias};
  int target = pt.label;
  brain.train(inputs, target);
}

//trains on a mouseClick
void mousePressed() {
  for (Point pt : points) {
    train(pt);
  }
}
