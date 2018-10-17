import java.util.Random;

private ArrayList<Recty> rects = new ArrayList<Recty>();
private Random rgen;
int rectWidth = 1;
int numRects;

void setup(){
  size(800, 400);
  for(int i = 0; i < width; i += rectWidth){
    rects.add(new Recty(i , height, rectWidth, 2));
  }
  rgen = new Random();
  numRects = width / rectWidth;
}

void draw(){
  background(255);
  for(Recty rect: rects){
    rect.display();
  }
   
  for(int i = 0; i < 100; i++){
    nextGaussian();
  }
  
}

void nextGaussian(){
  int temp = (int) (numRects / 2 + (rgen.nextGaussian() * numRects / 4));
  if(temp >= 0 && temp < numRects){
    rects.get(temp).increaseHeight(1);
  }
 
  //System.out.println(temp);
}