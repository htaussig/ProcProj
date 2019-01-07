float pointD = 5;
float col = 0;
float border = 105;

float minCircRadius = 5;
float maxCircRadius = 13;
float minDistance = 5;

ArrayList<Vertex> points;
ArrayList<Connect> cnctions;
ArrayList<Connect> cnctionsToCheck;
ArrayList<Triangle> triangles;
boolean showVertex = true;

int numConnections = 3;
//float num = 0;

float zRot = 0;
float depth = 1500;


//spiral stuff
float x = 0;
float y = 0;
float a = 0;
float da = radians(.5);
float r;
float MINR = 20;

void setup() {
  size(800, 800, P3D);
  //ortho();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0) + depth, width/2.0, height/2.0, 0, 0, 1, 0);
  strokeWeight(2);
  initi();
}

void initi() {
  points = new ArrayList<Vertex>();
  cnctions = new ArrayList<Connect>();
  cnctionsToCheck = new ArrayList<Connect>();
  triangles = new ArrayList<Triangle>();

  //could subtract by border
  r = width * 1.2;

  createPoints();

  //genConnections();
}

void draw() {
  lights();

  translate(width / 2, height / 2);
  col += .12;

  rotateY(zRot);
  zRot += .005;

  background(0);
  display();
}

void display() {
  fill(255);
  //cnctions.clear();
  //genConnections();
  //displayConnections();
  float tempCol = col;
  for (Triangle t : triangles) {
    tempCol += .123;
    t.display(tempCol);
  }
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

//spiral stuff
void decreaseR() {
  //exact angle you want to go in
  float exactA = ((int) (a / (PI / 2))) * PI / 2;

  float num = 1 - (1 / 1.612);

  x += cos(exactA) * r * num;
  y += sin(exactA) * r * num;

  //golden ratio
  r /= 1.612;
}

void createPoints() {

  while (nextPoint(0) && r > MINR) {
    if (a % radians(90) <= da && !(a <= da)) {
      decreaseR();
    }
    a += da;
  }
}

boolean nextPoint(int num) {
  if (num >= 100) {
    //a += da;
    return false;
  }

  //float x = random(-(width - border) / 2, (width - border) / 2); 
 // float y = random(-(height - border) / 2, (height - border) / 2);
  //float z = random(-(depth - border) / 2, (depth - border) / 2);
  
  float theA = random(TWO_PI);
  
  //this r is for deciding how far the circles are away
  float theR = random(r - MINR);
  
  float z = sin(theA) * theR;
  
  float theX = x + cos(a) * r;
  float theY = y + sin(a) * r;
  
  theX += cos(theA) * theR * cos(a);
  theY += cos(theA) * theR * sin(a);
  
  float size = random(minCircRadius, maxCircRadius);
  Vertex v1 = new Vertex(new PVector(theX, theY, z), size);

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

/**void genConnections() {
  genFirstTriangle((int) random(points.size()));

  Triangle t = triangles.get(0);

  for (Connect c : t.getConnections()) {
    safeAddC(c, cnctionsToCheck);
  }

  for (int i = 0; i < 1000; i++) {
    genNextTriangles();
  }
}

void genNextTriangles() {
  ArrayList<Connect> next = new ArrayList<Connect>();
  for (Connect c : cnctionsToCheck) {
    Vertex v3 = getClosestVtoC(c);

    Triangle t = new Triangle(c, v3);
    triangles.add(t);

    for (Connect c2 : t.getConnections()) {
      safeAddC(c2, next);
    }
  }

  cnctionsToCheck = next;
}**/


void safeAddC(Connect c, ArrayList<Connect> cList) {
  if (!contains(c, cnctions) && !contains(c, cList)) {
    cList.add(c);
  }
}

void genFirstTriangle(int num) {
  Vertex v1 = points.get(num);
  Vertex v2 = getClosestValidV(v1);
  Vertex v3 = getClosestVtoC(new Connect(v1, v2));

  Triangle t = new Triangle(v1, v2, v3);
  triangles.add(t);

  //cnctions.add();
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

Vertex getClosestVtoC(Connect c) {
  Vertex minV = null;

  Vertex v1 = c.v1;
  Vertex v2 = c.v2;

  float minDist = width + height + depth;
  for (int i = 0; i < points.size(); i++) {
    Vertex v3 = points.get(i);
    if (v3 != v1 && v3 != v2) {
      float dist13 = distance(v1, v3);
      float dist23 = distance(v2, v3);
      float dist = dist13 + dist23;
      Triangle tempT = new Triangle(v1, v2, v3);
      if (dist < minDist && !contains(tempT, triangles) &&!intrsctTri(tempT)) {
        minV = v3;
        minDist = dist;
      }
    }
  }

  return minV;
}

boolean intrsctTri(Triangle t) {
  return false;
}

Vertex getClosestValidV(Vertex v1) {
  Vertex minV = null;

  float minDist = width + height;
  for (int i = 0; i < points.size(); i++) {
    Vertex v2 = points.get(i);
    if (v2 != v1) {
      float dist = distance(v1, v2);
      Connect tempC = new Connect(v1, v2);
      if (dist < minDist && !contains(tempC, cnctions) && !intrsctCnct(tempC)) {
        minV = v2;
        minDist = dist;
      }
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

boolean contains(Triangle v1, ArrayList<Triangle> vArr) {
  for (Triangle v2 : vArr) {
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
    //genConnections();
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
