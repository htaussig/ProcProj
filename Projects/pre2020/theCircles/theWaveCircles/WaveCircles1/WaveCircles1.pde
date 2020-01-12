float AMP = 1490;
float LENDIV = 1220;
int NUMCIRCS = 4;

float start;
float xin;

FlatWave flat;
ArrayList<WaveCircle> circles;

void setup() {
  colorMode(HSB, 99);
  frameRate(60);
  size(800, 800);
  circles = new ArrayList<WaveCircle>();
  flat = new FlatWave(width, AMP, LENDIV);
  for(int i = 0; i <= NUMCIRCS; i++){
    WaveCircle circ = new WaveCircle(width / 2, height / 2, i * 30 + 25);
    circ.setColor(color(i * 10 + 30, 100, 100));
    circles.add(0, circ);
  }
}

void draw() {
  background(0);
  strokeWeight(2);
  
  flat.addNoiseY(1);
  flat.addNoiseX(1);
  flat.display();
  
  for(WaveCircle circ : circles){
    //circ.display();
  }
}



void keyPressed() {

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
