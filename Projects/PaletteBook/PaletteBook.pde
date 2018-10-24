float XDISP = 50;
float YDISP = 50;

float PW = 300;
float PH = 100;

int NUMCOLS = 2;

float XIN = 50;
float YIN = 50;

color backGCol;
ArrayList<Palette> palettes;

private String fileName = "paletteBook.txt";
private String helperFile = "helper.txt";

void setup() {
  size(800, 800);
  backGCol = color(255);
  palettes = new ArrayList<Palette>();

  readPalettes();
  //palette.addColor(new ColorBlock(color(2, 0, 255), 40));
}

void draw() {
  background(backGCol);
  pushMatrix();
  translate(XIN, YIN);
  for (int i = 0; i < palettes.size(); i++) { 
    Palette pal = palettes.get(i);
    pal.display(PW, PH);
    pTranslate(i);
  }
  popMatrix();
  instructionText();
}

void nPal(String code) {
  palettes.add(new Palette(code));
}

//do the proper translation to display the next palette
//based on NUMROW and NUMCOL and PW, PH
void pTranslate(int i) {
  if (i % NUMCOLS == NUMCOLS - 1) {
    ////System.out.println(i + ": vert");
    translate(-(XDISP + PW) * (NUMCOLS - 1), YDISP + PH);
  } else {
    ////System.out.println(i + ": horiz");
    translate(XDISP + PW, 0);
  }
}

void instructionText() {
  fill(#006EFA);
  text("space = toggle dark background", 10, 15);
} 

void precondition(boolean b, String text) {
  if (!b) {
    //System.out.println(text + "precondition failed ");
    stop();
  }
}

Palette getPalette(float x, float y) {
  x -= XIN;
  y -= YIN;

  x /= (XDISP + PW);
  y /= (YDISP + PH);

  int index = (int) y * NUMCOLS + (int) x;
  Palette pal = null;
  if (index < palettes.size()) {
    pal = palettes.get(index);
  } 
  return pal;
}

void mousePressed() {
  Palette pal = getPalette(mouseX, mouseY);
  if (pal != null) {
    println(pal);
  }
}

void keyPressed() {
  if (key == ' ') {
    if (backGCol == color(255)) {
      backGCol = (color(0));
    } else {
      backGCol = color(255);
    }
  }
}

void readPalettes() {
  BufferedReader rd = openFile(fileName);

  try {
    while (true) {
      String line = rd.readLine();
      if (line == null) break;
      nPal(line);
    }
  }
  catch (IOException ex) {
    println("error");
  }
}

private void record(String palette) {
  BufferedReader rd = openFile(fileName);
  int i = 0;

  //necessary try catch thing?
  try {

    PrintWriter wr = createWriter(helperFile);

    while (true) {
      String line = rd.readLine();
      if (line == null) break;
      wr.println(line);
    }

    //wr.println("it worked");

    rd.close();
    wr.close();
  } 
  catch (IOException ex) {
    //throw ex;
    println("error");   //should throw something here
  } 


  rd = openFile(helperFile);

  try {

    PrintWriter wr = createWriter(fileName);


    while (true) {
      String line = rd.readLine();
      if (line == null) break;
      //highScores.add(line);
      i++;
    }

    rd.close();
    wr.close();
  } 
  catch (IOException ex) {
    println("error");
    //throw ex;
  }
}

private BufferedReader openFile(String file) {

  BufferedReader rd = null;

  while (rd == null) {
    try {
      rd = createReader(file);
    } 
    catch (Exception ex) {
      println("Cannot find data storing file");
    }
  }
  return rd;
}
