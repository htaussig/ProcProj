float pointD = 5;
float col = 0;
float border = 105;

float minCircRadius = 5;
float maxCircRadius = 20;
float minDistance = 3;

ArrayList<Vertex> points;
ArrayList<Connect> cnctions;
boolean showVertex;

int numConnections = 3;
//float num = 0;

void setup() {
  size(800, 800);
  strokeWeight(2);
  showVertex = false;
  initi();
}

void initi() {
  points = new ArrayList<Vertex>();
  cnctions = new ArrayList<Connect>();

  createPoints();

  genConnections();
}

void draw() {
  col += .06;

  background(0);
  display();
}

void display() {
  fill(255);
  //cnctions.clear();
  //genConnections();
  //displayConnections();
  float tempCol = col;
  for (Connect c : cnctions) {
    tempCol += .123;
    c.display(tempCol);
  }
  for (Vertex v : points) {
    //v.update();
    if (showVertex) {
      v.display();
    }
  }
}

void createPoints() {
  while (nextPoint(0)) {
  }
}

boolean nextPoint(int num) {
  if (num >= 100) {
    return false;
  }

  float x = random(border, width - border); 
  float y = random(border, height - border);
  float r = random(minCircRadius, maxCircRadius);
  Vertex v1 = new Vertex(new PVector(x, y), r);

  for (Vertex v : points) {
    if (circlesOverlap(v1, v)) {
      return nextPoint(num + 1);
    }
  }

  points.add(v1);
  return true;
}

boolean circlesOverlap(Vertex circ1, Vertex circ2) {
  return distance(circ1, circ2) <= circ1.r + circ2.r + minDistance;
}

void genConnections() {
  int size = 0;
  boolean b = true;


  //ensures each point is connected to everything it can be
  //connectToRest(v);
  while (b) {
    size = cnctions.size();
    for (Vertex v1 : points) {
      connectLoop(v1);
      //connectToRest(v1);
    }
    if (size == cnctions.size()) {
      b = false;
    } else {
      size = cnctions.size();
    }
  }

  for (Vertex v1 : points) {
    //connectToRest(v1);
  }
}

void connectLoop(Vertex v) {
  while (v != null) {
    Vertex v2 = getClosestValidV(v);
    if (v2 != null) {
      cnctions.add(new Connect(v, v2));
    }
    v = v2;
  }
}

void connectToRest(Vertex v1) {
  while (true) {
    Vertex v2 = getClosestValidV(v1);
    if (v2 != null) {
      cnctions.add(new Connect(v1, v2));
    } else {
      break;
    }
  }
}

Vertex getClosestValidV(Vertex v1) {
  Vertex minV = null;

  float minDist = width + height;
  for (int i = 0; i < points.size(); i++) {
    Vertex v2 = points.get(i);
    float dist = distance(v1, v2);
    Connect tempC = new Connect(v1, v2);
    if (dist < minDist && !contains(tempC, cnctions) && !intrsctCnct(tempC)) {
      minV = v2;
      minDist = dist;
    }
  }

  return minV;
}

boolean intrsctCnct(Connect c1) {
  for (Connect c2 : cnctions) {
    if (c1.doesIntersect(c2)) {
      return true;
    }
  }
  return false;
}

boolean contains(Vertex v1, Vertex[] vArr) {
  for (Vertex v2 : vArr) {
    if (v2 != null && v1 == v2) {
      return true;
    }
  }
  return false;
}

boolean contains(Connect v1, ArrayList<Connect> vArr) {
  for (Connect v2 : vArr) {
    if (v2 != null && v1.equals(v2)) {
      return true;
    }
  }
  return false;
}

float distance(Vertex v1, Vertex v2) {
  return PVector.dist(v1.pos, v2.pos);
}

void keyPressed() {
  if (key == 'g') {
    cnctions.clear();
    genConnections();
  } else if (key == 'v') {
    showVertex = !showVertex;
  } else if (key == 's') {
    saveFrame("traingleFill2-######.png");
    System.out.println("saved");
  } else {
    initi();
  }
}

void postcondition(String msg, boolean b) {
  if (!b) {
    System.out.println("ERROR!" + msg);
  }
}
