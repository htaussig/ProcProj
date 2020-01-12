ArrayList<Integer> colors = new ArrayList<Integer>();
float col = 0;
float numRects = 4;

void setup(){
  colorMode(HSB, 255);
  size(1000, 800);
  noStroke();
  for(int i = 0; i < 4; i++){
    colors.add(color(random(255), 255, 255));
  }
}

void draw(){
  col = 0;
  for(float i = 0; i < height; i += (float) height / numRects){
    fill(getColor(col));
    rect(0, i, width,  (float) height / numRects);
    col += (float) colors.size() / numRects;
  }
}

int getColor(float v) {

  v = abs(v);

  v = v%(colors.size());

  int c1 = colors.get(int(v%colors.size()));

  int c2 = colors.get(int((v+1)%colors.size()));

  return lerpColor(c1, c2, v%1);

}

void keyPressed(){
  if(key == 'w'){
   numRects++; 
  }
  else if(key == 's'){
    if(numRects != 1){
      numRects--;
    }
  }
}