public class RecurCircle {
  PVector displace;
  float d;
  float hue, sat, bright;
  ArrayList<RecurCircle> circles = new ArrayList<RecurCircle>();
  PVector pos;

  public RecurCircle(PVector displace_, float d_, float hue_) {
    displace = displace_;
    d = d_;
    hue = hue_;
    sat = random(100);
    bright = random(100);
  }

  void generateCircles() {
    generateCircles(displace, d, hue);
  }

  void generateCircles(PVector displace, float d, float hue) {
    float hueDiff = random(4, 8);
    if (random(1) < .03) {
      if (random(1) < .5) {
        hueDiff = 50;
      } else {
        hueDiff = 33;
      }
    }
    if (random(1) < .5) {
      hueDiff *= -1;
    }

    hue += hueDiff;

    RecurCircle nextCirc = new RecurCircle(displace, d, hue);
    circles.add(nextCirc);
    float d1 = random(d / 10, d * 9 / 10);
    float d2 = d - d1;
    float newAngle = displace.heading() + random(TWO_PI);
    PVector displace1 = PVector.fromAngle(newAngle).setMag(d2 / 2);
    PVector displace2 = PVector.fromAngle(newAngle + PI).setMag(d1 / 2);
    if (d > 50) {
      if (random(1) < .9) {
        nextCirc.generateCircles(displace1, d1, hue);
      }
      if (random(1) < .9) {
        nextCirc.generateCircles(displace2, d2, hue);
      }
    }
  }
  
  void spin(float num){
    displace.rotate(num);
    for (int i = 0; i < circles.size(); i++) {
      RecurCircle circ = circles.get(i);
      circ.spin(num);
      //nextNum *= -1;
    }
  }

  void spinChildren(float num) {
    /*displace.rotate(num);
    float nextNum = (abs(num) * 1);
    if(num > 0){
      //nextNum *= -1;
    }*/
    for (int i = 0; i < circles.size(); i++) {
      RecurCircle circ = circles.get(i);
      circ.spin(num);
      //nextNum *= -1;
    }
  }

  void roll(float num){
    spin(num);
    for(int i = 0; i < circles.size(); i++){
     circles.get(i).spin(num); 
    }
  }

  boolean contains(PVector point){
    return abs(PVector.dist(point, pos)) < d / 2;
  }

  RecurCircle getCirc(PVector mouse){
    if(contains(mouse)){
      for(int i = 0; i < circles.size(); i++){
        RecurCircle nextCirc = circles.get(i);
        PVector nextPos = mouse.copy();
        //PVector displacem = PVector.fromAngle(nextCirc.angle).setMag(nextCirc.displace);
        //nextPos.sub(displacem);
        RecurCircle circ = nextCirc.getCirc(nextPos);
        if(circ != null){
          return circ;
        }
      }
      return this;
    }
    else{
     return null; 
    }
  }

  void display(float x, float y) {
    x += displace.x;
    y += displace.y;
    pos = new PVector(x, y);
    //pushMatrix();
    noStroke();
    fill(hue, sat, bright);
    //translate(x, y); 
    //rotate(angle);
    //translate(displace, 0);
    ellipse(x, y, d, d);  
    for (int i = 0; i < circles.size(); i++) {
      RecurCircle circ = circles.get(i);
      pushMatrix();
      circ.display(x, y);  
      popMatrix();
    }    

    //popMatrix();
  }
}
