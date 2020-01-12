
int NUMCOLS = 4; //x
int NUMROWS = 4; //y

Rose[][] roses;

void setup() {
  size(800, 800);

  initRoses();

  //this code taken from the wikipedia page:  https://en.wikipedia.org/wiki/Maurer_rose
  noFill();
  background(255);
  
  translate(-width / 2, -height / 2);
  displayRoses();
}

void initRoses(){
  roses = new Rose[NUMCOLS][NUMROWS];
  
  for(int i = 0; i < roses.length; i++){
    for(int n = 0; n < roses[0].length; n++){
      float x = ((i + .5) / (float) NUMCOLS) * width;
      float y = ((n + .5) / (float) NUMROWS) * height;
      roses[i][n] = new Rose(i + 2, (random(19, 65)), x, y);
    }
  }
}

void displayRoses(){
  for(int i = 0; i < roses.length; i++){
    for(int n = 0; n < roses[0].length; n++){
      roses[i][n].display();
    }
  }
}
