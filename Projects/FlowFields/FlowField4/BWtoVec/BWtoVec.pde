PVector[][] flowField;
color[][] pix;

int rows = 10;
int cols = 10;
float rectW;
float rectH;

void setup() {
  size(400, 400, P2D);
  
  rectW = width / rows;
  rectH = height / cols;
  
  setup1();
}

//resets the program
void setup1(){
  pix = new color[rows][cols];
  flowField = new PVector[rows][cols];
  
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      if (random(1) < .5) {
        pix[x][y] = color(0);
      } else {
        pix[x][y] = color(255);
      }
    }
  }
}

void draw() {
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      fill(pix[x][y]);
      rect(x * rectW, y * rectH, rectW, rectH);
    }
  }
}


void keyPressed(){
  setup1();
}
