//https://beesandbombs.tumblr.com/post/85134754974/the-official-bees-bombs-gif-guide-because-a-few

ArrayList<Triangle> triangles = new ArrayList<Triangle>();
float z = 0;
float zA;
float xA = 0;
float rotV = -radians(2);

boolean RECORDING = true;

void setup() {
  size(800, 800, P3D);

  //default camera values
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  for (int i = 0; i < 1; i++) {
    triangles.add(new Triangle(0, 0, -100, 100));
  }
}

void draw() {
  
  ortho();
  
  frameRate(30);
  
  background(0);
  lights();
  translate(width / 2, height / 2, 0);
  rotateX(xA);
  rotateZ(zA);
  zA += radians(.2);
  //xA += radians(1.1);
  if(triangles.size() == 1){
   mousePressed(); 
  }
  for (int i = 0; i < triangles.size(); i++) {
    Triangle triangle = triangles.get(i);
    triangle.enlarge();
    triangle.display(); 
    if (triangle instanceof EdgeTri) {
      EdgeTri tri = (EdgeTri) triangle;
      if(i == triangles.size() - 1){
       tri.rotateIn(rotV); 
      }
      if (tri.done()) {
        triangles.get(0).col1 = tri.col2;
        triangles.remove(tri);
      }
    }
  }
  /*if(frameCount % 64 == 0){
   mousePressed();
   }*/
   
   
  if (RECORDING) {
    if (frameCount < (TWO_PI / radians(.1))) {
      println("yee");
      saveFrame("movie/f###-waveStrips.gif");
    }
    else{
     println("nay"); 
    }
  }
}

void mousePressed() {
  if (triangles.size() == 1) {
    ArrayList<Triangle> next = new ArrayList<Triangle>();
    for (Triangle triangle : triangles) {
      for (Triangle small : triangle.get4Tri()) {
        next.add(small);
      }
    }
    triangles = next;
  } else {
    Triangle tri = triangles.get(0);
    triangles.clear();
    triangles.add(tri);
  }
}
