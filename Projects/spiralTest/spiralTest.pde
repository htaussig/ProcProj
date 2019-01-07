
float a = 0;
//why is this width * 2
float r;

float x = 0;
float y = 0;

float da = radians(1);

void setup(){
  size(600, 600);
  r = width / 2;
  background(255);
}

void draw(){
  translate(width / 2, height / 2);
  
  float nextA = a + da;
  
  translate(x, y);
  line(r * cos(a), r * sin(a), r * cos(nextA), r * sin(nextA));
  
  //point(r * cos(a), r * sin(a));
  //a += da;
  
  //println(degrees(a) + " " + degrees(a % PI / 4));
  if(a % radians(90) <= da && !(a <= da)){
     decreaseR();
  }
  
  a = nextA;
  
}

void decreaseR(){
  
  //exact angle you want to go in
  float exactA = ((int) (a / (PI / 2))) * PI / 2;
  
  float num = 1 - (1 / 1.612);
  
  x += cos(exactA) * r * num;
  y += sin(exactA) * r * num;
  
   //golden ratio
  r /= 1.612;
}
