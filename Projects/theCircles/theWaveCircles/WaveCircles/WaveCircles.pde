float AMP = 290;
float LENDIV = 90;

float start;
float xin;

void setup() {
  size(800, 800);
  xin = -10000;
  go();
}

void draw() {
  background(255);
  stroke(color(0,0, 255));
  
  background(255);
  xin += 1;
  FlatWave flat = new FlatWave(xin, width, AMP, LENDIV);
  flat.display();
}

void go() {
  background(255);
  stroke(0);
  FlatWave flat = new FlatWave(0, width, AMP, LENDIV);
  flat.display();
}

void keyPressed() {
  go();
}


/**float xin = random(-10000, 10000);
 for (float i = xin; i < width + xin; i++) {
 float x = i - xin;
 point(x, noise(i / LENDIV) * AMP + height / 2);
 }
 float start = noise(xin/ LENDIV) * AMP;
 float end = noise((width + xin - 1) / LENDIV) * AMP;
 line(0, start + height / 2, width, end + height / 2);
 float diffY = end - start;
 float slope = diffY / (width);
 stroke(color(255, 0, 0));
 for (float i = xin; i < width + xin; i++) {
 float x = i - xin;
 point(x, noise(i / LENDIV) * AMP + (height / 2) + (-slope * (x)));
 }
 start = noise(xin/ LENDIV) * AMP;
 end = noise((width + xin - 1) / LENDIV) * AMP  + (-slope * (width));
 line(0, start + height / 2, width, end + height / 2);
 diffY = end - start;
 slope = diffY / (width);
 System.out.println(slope);**/
