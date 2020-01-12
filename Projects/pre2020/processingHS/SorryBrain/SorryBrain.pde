float inc = .01;
float flying = 0;
boolean decreasing = false;

void setup(){
 size(400, 400); 
}

void draw(){
 float yoff = flying;
  
 loadPixels();
 for(int y = 0; y < height; y++){
   float xoff = 0;
   for(int x= 0; x < width; x++){
     int index = (x + y * width);
     pixels[index + 0] = color(noise(xoff, yoff) * 255);
     xoff += inc;
   }  
   yoff += inc;
 }
 flying += .06;
 updatePixels();
  
 if(inc > 1){
  decreasing = true; 
 }
 else if(inc < .003){
  decreasing = false; 
 }
 
 if(decreasing){
  inc -= .001; 
 }
 else{
  inc += .001; 
 }
 
}