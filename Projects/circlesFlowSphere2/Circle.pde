public class Circle {

  public float aHoriz, aVert, d, dh, dv;
  color col;

  public Circle(float ax_, float ay_, float dh_, float dv_, float d_, color col_) {
    aHoriz = ax_;
    aVert = ay_;
    d = d_;
    dh = dh_;
    dv = dv_;
    col = col_;
  }

  void setColor(color col_){
   col = col_; 
  }

  void faceCenter() {
    rotateX(PI / 2);
    rotateY(PI / 2);
  }

  void placementRotates() {
    rotateY(aHoriz);
    rotateZ(aVert);
  }

  void display() {
    float val = ((aVert  + (TWO_PI)) % TWO_PI);
    if (val > PI / 2 && val < 3 * PI / 2) {



      setColor();

      pushMatrix();


      placementRotates();
      translate(RAD, 0, 0);

      faceCenter();
      
      //val is now the distance angle away from middle
      val = abs(PI - val);
      val = map(val, (PI / 2) * 1, 0, 0, 1);
      //val = sqrt(val);
      float theR = (d / 2) * val;
      theR *= 3.2;
      
      ellipse(0, 0, theR, theR);
      //sphere(d /2);

      popMatrix();



      //ax += DA;
    }
    aHoriz += DA * SPEED * dh;
    aVert += DA * SPEED * dv;
  }

  void setColor() {
    float val = abs(PI - (aHoriz % TWO_PI));
    
    float val2 = ((aVert  + (TWO_PI)) % TWO_PI);
    val2 = abs(PI - val2);
    val2 = map(val2, PI, 0, 0, 1);
    
    float o = map(val, 0, PI, 0, 1);
    o += val2;
    o *= o;
    
    o = map(o, 0, 4, 0, 359);
    
    
    //float o = map(val, 0, PI, 0, 1);
    color c = color(hue(col), 359, 359, o);
    //fill(col);
    stroke(c);
  }
}
