void setup(){
  
}

void draw(){
  
}

//return true if the point intersects the triangle
boolean triPointIntersect(Vertex v1, Vertex v2, Vertex v3, PVector point){
  Triangle t = new Triangle(v1, v2, v3);
  
  return triPointIntersect(t, point);
}

boolean triLinePointIntersect(Triangle t, PVector point){
  //the high middle and low line of the triangle
  //the highest is at space 0
  Connect[] heightOrder = t.getConnections();
  
  insertionSort(heightOrder);
  
  return false;
}

float getHeight(PVector v){
  return v
}

void insertionSort(Connect[] cArr){
  Connect[] temp = new Connect[cArr.length];
  ArrayList<Connect> arrLC = new ArrayList<Connect>();
  
  for(int i = 0; i < cArr.length; i++){
    insert(cArr[i], cArr);
  }
  
  
  for(int i = 0; i < cArr.length; i++){
    temp[i] = arrLC.get(i);
  }
  
  cArr = temp;
}

void insert(Connect temp, ArrayList<Connect> cArr){
  int i = 0;
  while(true){
    Connect c = cArr[i];
    if(c == null){
      cArr[i] = temp;
      return;
    }
    if(c.getHeight
  }
}
