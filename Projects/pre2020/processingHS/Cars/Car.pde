public class Car {

  float x, y, vX, aX, w, h;
  ArrayList<Float> theXs;
  boolean braking = false;
  float brakeFrames = 0;
  color col;
  float maxBrakeDiff;

  public Car(float x_, float y_, float vX_, color col_) {
    x = x_;
    y = y_;
    vX = vX_;
    aX = 0;
    w = 20;
    h = 10;
    col = col_;
    maxBrakeDiff = w;
    theXs = new ArrayList<Float>();
  }

  public void update(float diff) {
    calcVx(diff);
    x += vX;
   // vX += aX;
    x %= width;
    theXs.add(0, x);
    if(theXs.size() > 12){
      theXs.remove(12);
    }
  }

  public void brake(){
   braking = true;
  }
  
  public void acc(){
    vX += .002;
    if(vX > 3){
     vX = 3; 
    }
  }
  
  public void calcVx(float diff){
    float acc;
    /*if(diff < maxBrakeDiff || braking){
     acc = -1 * (maxBrakeDiff - diff); 
    }
    else{
     acc = .5 * (diff - maxBrakeDiff); 
    }*/
    
    acc = 5 * pow(map(diff, w, width / 2, -1, 2), 1/3);
    if(map(diff, w, width / 2, -1, 2) < 0){
     acc *= -1; 
    }
    
    if(braking){
     vX -= .1; 
     braking();
    }
    
    vX += .0012 * acc;
    if(vX > 2){
     vX = 2; 
    }
    else if(vX < 0){
     vX = 0; 
    }
    
    emergencyBrake(diff);
  }
  
  public void braking(){
    if(brakeFrames > 60){
      braking = false;
      brakeFrames = 0;
    }
    else{
     brakeFrames++; 
    } 
  }
  
  public void emergencyBrake(float diff){
   if(diff < maxBrakeDiff / 3){
    vX /= 1.4;
   }
  }
  
  public float getPPos(){
    return theXs.get(theXs.size() - 1);
  }
  
  public void display(){
    stroke(0);
    fill(col);
    rect(x + w / 2, y - h / 2, w, h);
  }
  
  public void display(float r){
    stroke(col);
    strokeWeight(5);
    float theta = x / width;
    float x2 = r * cos(theta * 2 * PI);
    float y2 = r * sin(theta * 2 * PI);
    point(x2, y2);
  }
}