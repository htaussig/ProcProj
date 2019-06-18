ArrayList<Float> nums = new ArrayList<Float>();

float max = 0;
float min = 1;

float index = 0;
void setup(){
 size(400, 400); 
 
}

void draw(){
 background(0);
 
 float num = noise(index, index, index);
 index += 0.1;
 
 if(num > max){
  max = num; 
 }
 if(num < min){
   min = num;
 }
 
 text(num, width / 2, -20 + height / 2);
 
 text(max, width / 2, height / 2);
 text(min, width / 2, height / 2 + 20);
}
