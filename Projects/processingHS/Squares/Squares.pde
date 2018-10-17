//int colors[] = {#3791CE, #EF695E, #F4465C, #597591, #F9F49F};
private static final float MINRECTS = 4.0;
private ArrayList<Integer> colors = new ArrayList<Integer>();

void setup(){
  size(600, 600);
  background(255);
  //noStroke();
  smooth(8);
  /*colors.add(#EEEEEE);
  colors.add(#00ADB5);
  colors.add(#393E46);
  colors.add(#222831);*/
  colors.add(#364F6B);
  colors.add(#3FC1C9);
  colors.add(#F5F5F5);
  colors.add(#FC5185);
  drawOnce();
}

void drawOnce(){
 //randomColors();
 for(float x = 0; x < width; x += width / MINRECTS){
  for(float y = 0; y < height; y += height / MINRECTS){
    recursiveRect(x, y, width / MINRECTS, height / MINRECTS);
  }
 }
 //recursiveTri(width / 2, height / 2, width / 4, height / 4, 0);
}

void draw(){
  
}

//from manoloide
void randomColors() { 

  colors.clear();
  
  int c = int(random(2, 5));

  colorMode(HSB, 360, 100, 100, 1);

  float dc = 360./c;

  float dd = int(random(360));

 //colors.add(color(255));

  for (int i = 0; i < c; i++) {

    colors.add(color((dd+dc*i)%360, random(10, 80), random(90, 100)));

  }
}

void recursiveRect(float x, float y, float w, float h){
  float r = random(100);
  
  if(w < 5 || h < 5){
   r = 0; 
  }
  
  float maxWidth = width / MINRECTS;
  //inversely proportional to make drawing more likely with a smaller width
  if(r <= 33 + ((1 - (w / maxWidth)) * 37)){
    setRCol();
    rect(x, y, w, h);
  }
  else if(r < 76.5) {
    for(float i = x; i < x + w; i += w / 2){ 
      for(float j = y; j < y + h; j += h / 2){
        recursiveRect(i, j, w / 2, h / 2);    
      }
    }
  }
  else{
    float r2 = random(100);
    
    if(r2 < 50){
      recursiveTri(x, y, w, h, 0);
      recursiveTri(x + w, y + h, w, h, (float) Math.PI);
    }
    else{
      recursiveTri(x, y + h, w, h,  -(float) Math.PI / 2);
      recursiveTri(x + w, y, w, h, (float) Math.PI / 2);
    }
    
  }
}

void recursiveTri(float x, float y, float w, float h, float angle){  
  float r = random(100);
  
  if(w < 15 || h < 15){
    r = 0;
  }
  
  if(r < 75){
    drawTri(x, y, w, h, angle);
  }
  else{
    float newW = w / sqrt(2);
    float newH = h / sqrt(2);
    
    
    //using this to convert cos and sin to a unit vector
    float con = 2 / sqrt(2);
    float tempA = angle + (3 * (float) Math.PI / 4);
    
   x += sin(tempA) * con * w / 2;
   y -= cos(tempA) * con * h / 2;
    
    recursiveTri(x, y, newW, newH, angle + (3 * (float) Math.PI / 4));
    recursiveTri(x, y, newW, newH, angle - (3 * (float) Math.PI / 4));
  }
  
}

void drawTri(float x, float y, float w, float h, float angle){
  setRCol();
  pushMatrix();
  translate(x, y);
  rotate(angle);
  beginShape();
  vertex(0, 0);
  vertex(w, 0);
  vertex(0, h);
  //vertex(0, 0);
  endShape(CLOSE);
  popMatrix();
}

int rcol(){
  return colors.get(int(random(colors.size())));
}

void setRCol(){
  color rcol = rcol();
  fill(rcol);
  stroke(rcol);
}

void keyPressed(){
  if(key == '`'){
      saveFrame("line-######.png");
      System.out.println("Frame saved");
  }
  else{
     background(255);
    drawOnce();
  }
}