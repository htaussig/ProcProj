import processing.svg.*;

int NUMCOLS = 2; //x
int NUMROWS = 2; //y

int NUMLINES = 180;

Rose[][] roses;

void setup() {
  size(800, 800);

  initRoses();

  //this code taken from the wikipedia page:  https://en.wikipedia.org/wiki/Maurer_rose
  noFill();
  background(255);

  //translate(-width / 2, -height / 2);
  //displayRoses();
}

void draw(){
  background(255);
  translate(-width / 2, -height / 2);
  displayRoses();
}

void initRoses() {
  roses = new Rose[NUMCOLS][NUMROWS];

  for (int i = 0; i < roses.length; i++) {
    for (int n = 0; n < roses[0].length; n++) {
      float x = ((i + .5) / (float) NUMCOLS) * width;
      float y = ((n + .5) / (float) NUMROWS) * height;
      roses[i][n] = new Rose(i + 2, (random(19, 65)), x, y);
    }
  }
}

void displayRoses() {
  for (int i = 0; i < roses.length; i++) {
    for (int n = 0; n < roses[0].length; n++) {
      roses[i][n].display();
    }
  }
}

void keyPressed() {
  if (key == 'w') {
    for (int i = 0; i < roses.length; i++) {
      for (int n = 0; n < roses[0].length; n++) {
        roses[i][n].n++;
      }
    }
  }
  else if (key == 'e') {
    for (int i = 0; i < roses.length; i++) {
      for (int n = 0; n < roses[0].length; n++) {
        roses[i][n].d++;
      }
    }
  }
  else if (key == 's') {
    for (int i = 0; i < roses.length; i++) {
      for (int n = 0; n < roses[0].length; n++) {
        roses[i][n].n--;
      }
    }
  }
  else if (key == 'd') {
    for (int i = 0; i < roses.length; i++) {
      for (int n = 0; n < roses[0].length; n++) {
        roses[i][n].d--;
      }
    }
  }
  else if(key == ' '){
    if(NUMLINES == 360){
      NUMLINES = 180;
    }
    else{
      NUMLINES = 360;
    }
    
  }
  else if(key == 'S'){
    beginRecord(SVG, "maurerRose" + frameCount + ".svg");
    translate(-width / 2, -height / 2);
    displayRoses();
    endRecord();
  }
}
