public class FlatWave {
  float len;
  float lendiv;
  float noiseY;
  float xin;
  float start;
  ArrayList<Float> points = new ArrayList<Float>();
  
  public FlatWave(float len_, float lendiv_) {
    this(len_, lendiv_, random(-10000, 10000), random(-10000, 10000)); 
  }
  
  public FlatWave(float len_, float lendiv_, float xin_, float yin_) {
    xin = xin_;
    noiseY = yin_;
    len = len_;
    lendiv = lendiv_;
    calculate();
  }
  
  void calculate(){
    points.clear();
    System.out.println(points.size());
    start = noise(xin/ lendiv, noiseY / lendiv);
    float end = noise((len + xin - 1) / lendiv, noiseY / lendiv);
    float diffY = end - start;
    float slope = diffY / (len);
    for (float i = xin; i < len + xin; i++) {
      float x = i - xin;
      points.add(noise(i / lendiv, noiseY / lendiv) - start + (-slope * (x)));
      //System.out.println(len);
    }
  }
  
  //returns the point with that also has any matching start and end point
  /**float getPoint(int index){
    //some weird behavior, can go all over the place with big amp
    return points.get(index) - 1 / 2;
  }**/
  
  /**float getPointCirc(int index, float r, float mult){
    float y = map(points.get(index), 0, 1, -r * mult, r * mult);
    //y *= smoothCircEnds(index, r);
    return y;
  }**/
  
  //returns the points where both end at 0
  float getPointStand(int index, float r, float mult){
    float y = map(points.get(index), -1, 1, -r * mult, r * mult);
    y *= smoothCircEnds(index, r);
    return y + (start -.5) * mult * r;
  }
  
  float smoothCircEnds(float index, float r){
    float dist = r / 5;
   //System.out.println("i: " + index + " r: " + r + " len - r - 1: " + (len - 1 - r));
   if(index < dist){
      //System.out.println("lesser");
      return pow((index / dist), 1);
    }
    else if(index > len - dist){
      //System.out.println("greater");
      return pow(((len - index) / dist), 1);
    } 
    else{
     return 1; 
    }
  }
  
  void addNoiseX(float num){
    xin += num;
    calculate();
  }
  
  void addNoiseY(float num){
    noiseY += num;
    calculate();
  }
  
  /**void display(){
    stroke(color(0,0, 255));
    strokeWeight(2);
    for(int x = 0; x < points.size() - 1; x++){
      //point(x, points.get(x) + height / 2);
      line(x, flat.getPointStand(x, len, 1) + height / 2, x + 1, flat.getPointStand(x + 1, len, 1) + height / 2);
    }
  }**/
}
