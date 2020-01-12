public class Circle {

  public float aHoriz, aVert, d, dh, dv;

  public Circle(float ax_, float ay_, float dh_, float dv_, float d_) {
    aHoriz = ax_;
    aVert = ay_;
    d = d_;
    dh = dh_;
    dv = dv_;
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
      float theR = (d / 2) * map(val, (PI / 2) * 1, 0, 0, 1);
      theR *= theR;
      theR *= 3.5;
      ellipse(0, 0, theR, theR);
      //sphere(d /2);

      popMatrix();



      //ax += DA;
    }
    aHoriz += DA * 3 * dh;
    aVert += DA * 3 * dv;
  }

  void setColor() {
    color col = color(255, 255, 255);
    //fill(col);
    stroke(col);
  }
}
