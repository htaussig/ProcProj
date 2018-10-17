Population population;
//These are global variables
int count = 0;
int lifeSpan = 250;
PVector target;
float maxForce = .2;
float mutationPercent = .0016;
int gen = 0;
float quickestComplete = lifeSpan;

float rx = 100;
float ry = 150;
float rw = 200;
float rh = 10;

void setup() {
  size(400, 400); 
  frameRate(2000);
  population = new Population();
  target = new PVector(width/2, 50);
}

void draw() {
  background(0); 
  population.run();
  count++;

  if (count == lifeSpan){
    population.evaluate();
    population.selection();
    count = 0;
    gen++;
  }
  
  text("gen: " + gen, width - 60, height -5);
  
  rectMode(CORNER);
  fill(255);
  rect(rx, ry, rw, rh);

   //System.out.println(count);

  fill(#F70707);
  ellipse(target.x, target.y, 16, 16);
  
}