public class FlatWave {
  float len;
  float amp;
  float lendiv;
  ArrayList<Float> points = new ArrayList<Float>();
  
  public FlatWave(float xin, float len_, float amp_, float lendiv_) {
    //float xin = random(-10000, 10000);
    float start = noise(xin/ LENDIV) * AMP;
    float end = noise((width + xin - 1) / LENDIV) * AMP;
    float diffY = end - start;
    float slope = diffY / (width);
    for (float i = xin; i < width + xin; i++) {
      float x = i - xin;
      points.add(noise(i / LENDIV) * AMP - start + (-slope * (x)));
    }
  }
  
  void display(){
    stroke(color(0,0, 255));
    strokeWeight(2);
    for(int x = 0; x < points.size(); x++){
      point(x, points.get(x) + height / 2);
    }
  }
}
