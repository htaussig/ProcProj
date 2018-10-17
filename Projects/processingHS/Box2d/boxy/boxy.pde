import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;


int SQUARE = 0;
int PARTICLE = 1;

ArrayList<Object> displayThings;

int currentShape = SQUARE;

Box2DProcessing box2d;

Surface surface;

void setup(){
  size(700, 700);
  smooth();
  
  surface = new Surface();
  
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  displayThings = new ArrayList<Object>();
  displayThings.add(surface);
}

void draw(){
  background(255);
  
  box2d.step();
  
  for(Object thing: displayThings){
   ((Displayable) thing).display(); 
  }
}

void mousePressed(){
   if(mouseButton == RIGHT){
    displayThings.add(new Boundary(mouseX, mouseY));   
  }
  else if(currentShape == SQUARE){
    displayThings.add(new Square(mouseX, mouseY)); 
  }
  else if(currentShape == PARTICLE){
    displayThings.add(new Particle(mouseX, mouseY, random(4, 8)));
  }
}

void mouseDragged(){
  if(mouseButton == RIGHT){
    displayThings.add(new Boundary(mouseX, mouseY));   
  }
  else if(currentShape == SQUARE){
    displayThings.add(new Square(mouseX, mouseY)); 
  }
  else if(currentShape == PARTICLE){
    displayThings.add(new Particle(mouseX, mouseY, random(4, 8)));
  }
}

void keyPressed(){
  if(key == 'c'){
    currentShape = PARTICLE;
  }
  else if(key == 's'){
   currentShape = SQUARE; 
  }
}