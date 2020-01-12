// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Example demonstrating distance joints 
// A bridge is formed by connected a series of particles with joints

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
Box2DProcessing box2d;

// An object to describe a Bridge (a list of particles with joint connections)
Bridge bridge;

// A list for all of our rectangles
ArrayList<Displayable> displayThings;

void setup() {
  size(800, 800);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  displayThings = new ArrayList<Displayable>();
  
  bridge = new Bridge(height * 2 / 5, 10);
  displayThings.add(bridge);
}

void draw(){
 background(255);
 
 box2d.step();
 
 for(Displayable thing: displayThings){
   thing.display();
 }

}