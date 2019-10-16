public class Circle extends Point{
  float d;
  String type = "";
  float dNow = d;

  Circle(float x, float y, float d) {
    super(x, y);
    this.d = d;
  }

  float getRadius(){
   return dNow / 2.0; 
  }

  void drawReverseCircle(float dNow) {
    fill(0);
    noStroke();
    pushMatrix();
    // translate(pos.x, pos.y);
    // Make a shape
    beginShape();

    // Exterior part of shape
    vertex(0, 0);
    vertex(width, 0);
    vertex(width, height);
    vertex(0, height);
    //vertex(0, 0);

    // Interior part of shape
    beginContour();
    
    for (int i = 200; i >= 1; i--) {
      float angle = ((float) i / 200) * TWO_PI;
      float x = cos(angle) * (dNow) / 2;
      float y = sin(angle) * (dNow) / 2;
      vertex(x + pos.x, y + pos.y);
    }
    endContour();
    endShape(CLOSE);
    popMatrix();
    
    noFill();
    //stroke(0);
    noStroke();
  }

  void display() {
    noFill();
    strokeWeight(2);
    stroke(255);
    //ellipse(pos.x, pos.y, d, d);
    fill(160);
    
    dNow = d * map(vel.mag(), 0, 1, .7, 1.4);

    if(type == "triangle"){
       drawReverseCircle(dNow);
    }
    else if(type == "particle"){
      
    }
   
   noFill();
   stroke(255);
   //strokeWeight(1);
   //ellipse(pos.x, pos.y, dNow, dNow);
   

    //drawMaskedCircle();

    // Finishing off shape
  }
}
