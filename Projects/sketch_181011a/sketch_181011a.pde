void setup(){
  size(400, 400);
  
}

void draw(){
  for(int i = 0; i < width; i++){
    point(i, noise(i));
  }
}
