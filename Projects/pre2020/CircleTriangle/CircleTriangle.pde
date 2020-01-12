//inspired by manoloidee

Circle bigCirc;


void setup(){
  size(400, 400);
  stroke(0);
  generate();
}

void draw(){
  background(255);
  display();
}

void generate(){
  float d = width * (5.0 / 6);
  color col = #AC15FF;
  bigCirc = new Circle(width / 2, height / 2, d, col);
}

void display(){
  bigCirc.display();
}
