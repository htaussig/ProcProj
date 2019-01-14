//Harry Taussig
//GenerateSerendipity
//Jan 2019

String fileName = "12.png";
PImage img;

int numPoints = 4430;
PVector[] points;

color[][] thePix;

ArrayList<Integer> preference;

float MINBRIGHT = 190;
//how much to add to the brightness calculated
float OPACADD = 70;

//for some reason I can't save images with opacity
boolean SMOOTH = true;
//boolean SMOOTHEDGES = true;
float DEV = 21;

//can use my PalletteBook Sketch, click on the pallettes, and copy them in here
Palette pal = new Palette("37#2D405926#EA545517#F07B3F17#FFD460");

void setup() {
  size(300, 300);
  img = loadImage(fileName);

  frameRate(3000);

  points = new PVector[numPoints];
  initPoints();

  thePix = new color[width][height];
  initThePix();

  colorMode(RGB);

}

void initPoints() {
  for (int i = 0; i < points.length; i++) {
    int x = (int) random(width);
    int y = (int) random(height);

    points[i] = new PVector(x, y);
  }
}

void initThePix() {

  preference = new ArrayList<Integer>();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      if (isPoint(x, y)) {
        color col = pal.getColor();
        col = colorShift(col);
        thePix[x][y] = col;
        preference.add(col);
      } else {
        //-1 is the null value
        thePix[x][y] = -1;
      }
    }
  }
}

//slight color shift for variation and for different colors for the preference
//otherwise one color dominates the picture
color colorShift(color col) {
  colorMode(HSB);
  float h = (hue(col) + random(-DEV, DEV));

  return color(h, (saturation(col) + random(-DEV, DEV)), (brightness(col) + random(-DEV, DEV)));
}

boolean isPoint(float x, float y) {
  for (PVector p : points) {
    if (p.x == x && p.y == y) {
      return true;
    }
  }
  return false;
}

void draw() {
  image(img, 0, 0);
  //print("y");

  trySpread();

  background(0);

  display();
}

void trySpread() {

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      //basically does it have a color
      //not sure if we want the second conditional here
      if (thePix[x][y] != -1) {
        if (brightness(img.pixels[x + (y * width)]) > MINBRIGHT) {
          //print(x, y);
          //spreads color and that one will spread color again bc they don't update all at once
          spreadColor(x, y);
        } else {
          thePix[x][y] = -1;
        }
      }
    }
  }
}

void display() {
  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      //basically does it have a color
      if (thePix[x][y] != -1) {

        int ind = x + (y * width);

        if (x != width - 1 || y != height - 1) {
          //not sure why this needs to happen but it looks better
          ind += 1;
        }

        // can use brightness of the original pixel here
        //print("h");
        color col = thePix[x][y];

        if (SMOOTH) {
          pushStyle();

          col = smoothColor(col, ind);

          //for some reason I can't save images with opacity so this doesnt work          
          //float o = brightness(img.pixels[ind]) + OPACADD;
          //if (SMOOTHEDGES) {
          //  o = map(o, 0, 255, 255, 180);
          //}

          //o = map(o, 0, 255, 50, 255);
          colorMode(HSB);
          //pixels[ind] = color(hue(col), saturation(col), brightness(col));    
          pixels[ind] = col; 
          popStyle();
        } else {
          pixels[ind] = col;
        }
      }
    }
  }

  updatePixels();
}

color smoothColor(color c1, int index) {
  colorMode(RGB);
  color c2 = color(0);
  float b = brightness(img.pixels[index]);
  b = map(b, 0, 255, 0, 1);
  return lerpColor(c2, c1, b);
}

void spreadColor(int x, int y) {
  color col = thePix[x][y];

  //loadPixels();

  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y -1; j <= y + 1; j++) {
      if (inBounds(i, j) && thePix[i][j] != col && brightness(img.pixels[x + (y * width)]) > MINBRIGHT) {
        if (hasPreference(x, y, i, j)) {
          //print("a");
          thePix[i][j] = col;
        }
      }
    }
  }
}

//each colors preference is how early it comes in the the list of colors
//without preference, colors in the same section get stuck next to eachother
boolean hasPreference(int x, int y, int i, int j) {
  int i1 = getIndex(x, y);
  int i2 = getIndex(i, j);

  if (i2 == -1) {
    return true;
  } else {
    return i1 < i2;
  }
}

int getIndex(int x, int y) {
  for (int i = 0; i < preference.size(); i++) {
    color c = preference.get(i);
    if (c == thePix[x][y]) {
      return i;
    }
  }
  //should be out of index
  return -1;
}

boolean inBounds(float x, float y) {
  //print(x, y);
  return x >= 0 && x < width && y >= 0 && y < height;
}

void keyPressed() {
  if (key == 's') {
    saveFrame(fileName + "cS-######.png");
    System.out.println("Frame saved");
  }
}
