// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Turtle {

  String todo;
  float len;
  float theta;

  Turtle(String s, float l, float t) {
    todo = s;
    len = l; 
    theta = t;
  } 

  void render() {
    //theta += radians(1);
    //theta %= 2 * PI;
    /*if(theta > radians(315) || theta < radians(45)){
      //theta += radians(.1);
    }*/
    setTheta();
    //stroke(255);
    for (int i = 0; i < todo.length(); i++) {
      char c = todo.charAt(i);
      if (c == 'F') {
        //line(0, 0, len, 0);
        fill(255, 255);
        ellipse(len / 2, 0, 32, 32);
        translate(len, 0);
      } else if (c == 'G') {
        translate(len, 0);
      } else if (c == '+') {
        rotate(theta);
      } else if (c == '-') {
        rotate(-theta);
      } else if (c == '[') {
        pushMatrix();
      } else if (c == ']') {
        popMatrix();
      }
    }
  }

  void setLen(float l) {
    len = l;
  } 

  void changeLen(float percent) {
    len *= percent;
  }

  void setToDo(String s) {
    todo = s;
  }
  
  float getTheta(){
   //theta = (3 * PI / 2 ) * mouseX / width; 
   return theta;
  }
  
  void setTheta(){
   theta = (radians(60)) * (width - mouseX) / width; 
  }
}