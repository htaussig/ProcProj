ArrayList<KochLine> lines = new ArrayList<KochLine>();
boolean returning = false;
float buffer = 230;
float x = 0;

void setup() {
  size(800, 800);
  background(0);
  colorMode(HSB, 255);
  lines.add(new KochLine(new PVector(x + buffer, height - 100), new PVector(width - buffer + x, height - 100)));
}

void draw() {
  background(255);
  for (KochLine l : lines) {
    l.display();
  }

  if (returning) {
    for (KochLine l : lines) {
      l.goHome();
    }
  }
}

void mousePressed() {    
  generate();
}

void generate() {  
  ArrayList<KochLine> next = new ArrayList<KochLine>();
  
  for (KochLine l : lines) {
    ArrayList<PVector> children = l.getChildPoints();

    PVector p2 = children.get(0);
    PVector p1;
    for (int i = 1; i < children.size(); i++) {
      p1 = p2;
      p2 = children.get(i);
      next.add(new KochLine(p1, p2));
    }
  }
  lines = next;
  System.out.println(lines.size());
}

void keyPressed() {
  if (key == ' ') {
    for (KochLine l : lines) {
      l.wiggle();
    }
  } else if (key == 'g') {
    if (returning) {
      returning = false;
    } else {
      returning = true;
    }
  }
  if(key == 's'){
    saveFrame("Fractal-######.png");
    System.out.println("saved");
  }
}
