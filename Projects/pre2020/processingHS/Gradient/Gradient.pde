float i = 0;

int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};

void setup(){
 size(300, 300); 
 noStroke();
}

void draw(){
  i += .01;
  fill(getColor(i));
  ellipse(width / 2, height / 2, 100, 100);
}

int getColor(float v) {

  v = abs(v);

  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];

  int c2 = colors[int((v+1)%colors.length)];

  return lerpColor(c1, c2, v%1);

}

void keyPressed(){
  i = key;
}