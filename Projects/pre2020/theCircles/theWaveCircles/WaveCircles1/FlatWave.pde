public class FlatWave {
  float len;
  float amp;
  float lendiv;
  float noiseY;
  float xin;
  float start;
  ArrayList<Float> points = new ArrayList<Float>();
  
  public FlatWave(float len_, float amp_, float lendiv_) {
    this(len_, amp_, lendiv_, random(-10000, 10000), random(-10000, 10000)); 
  }
  
  public FlatWave(float len_, float amp_, float lendiv_, float xin_, float yin_) {
    xin = xin_;
    noiseY = yin_;
    len = len_;
    amp = amp_;
    lendiv = lendiv_;
    calculate();
  }
  
  void calculate(){
    points.clear();
    start = noise(xin/ lendiv, noiseY / lendiv) * amp;
    float end = noise((len + xin - 1) / lendiv, noiseY / lendiv) * amp;
    float diffY = end - start;
    float slope = diffY / (len);
    for (float i = xin; i < len + xin; i++) {
      float x = i - xin;
      points.add(noise(i / lendiv, noiseY / lendiv) * amp + (-slope * (x)));
    }
  }
  
  //returns the point with that also has any matching start and end point
  float getPoint(int index){
    //some weird behavior, can go all over the place with big amp
    return points.get(index) - amp / 2;
  }
  
  float getPointCirc(int index, float r, float mult){
    return map(points.get(index), 0, amp, -r * mult, r * mult);
  }
  
  //returns the points where both end at 0
  float getPointStand(int index){
    return points.get(index) - start;
  }
  
  void addNoiseX(float num){
    xin += num;
    calculate();
  }
  
  void addNoiseY(float num){
    noiseY += num;
    calculate();
  }
  
  void display(){
    stroke(color(0,0, 255));
    strokeWeight(2);
    for(int x = 0; x < points.size() - 1; x++){
      //point(x, points.get(x) + height / 2);
      line(x, flat.getPointStand(x) + height / 2, x + 1, flat.getPointStand(x + 1) + height / 2);
    }
  }
}
