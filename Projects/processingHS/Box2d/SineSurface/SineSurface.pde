import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;


int SQUARE = 0;
int PARTICLE = 1;
int TSHAPE = 2;
int PAIR = 3;
int PENDULUM = 4;

int currentShape = SQUARE;

Box2DProcessing box2d;

Surface surface;

ArrayList<Displayable> displayThings;

void setup(){
  size(700, 700);
  smooth();
  
  displayThings = new ArrayList<Displayable>();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  surface = new Surface();
  
  displayThings.add(surface);
}

void draw(){
 
  background(255);
  
  box2d.step();
  
  for(int i = displayThings.size() - 1; i >= 0; i--){
    
    Displayable thing = displayThings.get(i);
    
   thing.display(); 
   
   if(thing.done()){
    displayThings.remove(i); 
   }
  }
  
}

float getSquareWidth(){
  return 27;
}

float getSquareHeight(){
 return 27; 
}

float getParticleR(){
 return 10; 
}

float getPairR(){
 return 5; 
}

float getTShapeWidth(){
  return 20;
}



void mouseAction(){
  if(mouseButton == RIGHT){
    displayThings.add(new Boundary(mouseX, mouseY)); 
  }
  else if(currentShape == SQUARE){
    displayThings.add(new Box(mouseX, mouseY, getSquareWidth(), getSquareHeight())); 
  }
  else if(currentShape == PARTICLE){
    displayThings.add(new Particle(mouseX, mouseY, getParticleR()));
  }
  else if(currentShape == TSHAPE){
    displayThings.add(new TShape(mouseX, mouseY, getTShapeWidth(), getTShapeWidth()));
  }
  else if(currentShape == PAIR){
    displayThings.add(new Pair(mouseX, mouseY, getPairR()));
  }
  else if(currentShape == PENDULUM){
    displayThings.add(new Pendulum(mouseX, mouseY, getPairR()));
  }
  
}

void mousePressed(){
  mouseAction();
}

void mouseDragged(){
  mouseAction();
}

void keyPressed(){
  if(key == 'c'){
    currentShape = PARTICLE;
  }
  else if(key == 's'){
   currentShape = SQUARE; 
  } 
  else if(key == 't'){
   currentShape = TSHAPE; 
  }
  else if(key == 'p'){
    currentShape = PAIR;
  }
  else if(key == '2'){
    currentShape = PENDULUM;
  }
}