float pointD = 20;
float col = 0;

ArrayList<Vertex> points;
ArrayList<Connect> cnctions;

int numConnections = 3;
//float num = 0;

void setup() {
  size(800, 800);

  initi();
  
  
}

void initi() {
  points = new ArrayList<Vertex>();
  cnctions = new ArrayList<Connect>();

  for (int i = 0; i < 100; i++) {
    points.add(new Vertex(new PVector(random(width), random(height))));
  }

  genConnections();
}

void draw() {
  col += .35;
  
  background(0);
  display();
}

void display() {
  fill(255);
  //cnctions.clear();
  //genConnections();
  for (Vertex v : points) {
    v.update();
  }
  //displayConnections();
  float tempCol = col;
  for (Connect c : cnctions) {
    tempCol += .123;
    c.display(tempCol);
  }
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

/**void displayConnections() {
 for (int i = 0; i < points.size(); i++) {
 //System.out.println(i);
 Vertex v1 = points.get(i);
 Vertex[] vArr = getClosestV(points, v1, numConnections);
 displayConArr(v1, vArr);
 }
 }
 
 void displayCon(Vertex v1, Vertex v2) {
 stroke(255);
 if (v2 != null) {
 line(v1.pos.x, v1.pos.y, v2.pos.x, v2.pos.y);
 }
 }
 
 void displayConArr(Vertex v1, Vertex[] vArr) {
 stroke(255);
 noFill();
 beginShape();
 vert(v1);
 for (Vertex v : vArr) {
 vert(v);
 }
 endShape();
 }
 
 void vert(Vertex v1) {
 vertex(v1.pos.x, v1.pos.y);
 }**/

Vertex[] getClosestV(ArrayList<Vertex> list, Vertex v1, int num) {
  Vertex[] minV = new Vertex[num];

  for (int closeI = 0; closeI < num; closeI++) {
    float minDist = width + height;
    for (int i = 0; i < list.size(); i++) {
      Vertex v2 = list.get(i);
      if (!contains(v2, minV)) {
        float dist = distance(v1, v2);
        if (dist < minDist) {
          minV[closeI] = v2;
          minDist = dist;
        }
      }
    }
  }

  postcondition("getClosestV", !contains(null, minV));

  return minV;
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
  if(key == 'g'){
    cnctions.clear();
    genConnections();
  }
  else{
    initi();
  }
}

void postcondition(String msg, boolean b) {
  if (!b) {
    System.out.println("ERROR!" + msg);
  }
}
