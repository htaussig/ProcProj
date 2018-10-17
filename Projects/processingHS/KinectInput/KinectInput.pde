// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;

//time in seconds allowed for an input to take
float maxInputLength = .25;
private static final int movementThresh = 90;

ArrayList<PVector> positions;

void setup() {
  size(640, 520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  positions = new ArrayList<PVector>();
}

void draw() {
  background(255);

  // Run the tracking analysis
  tracker.track();
  positions.add(tracker.getPos());
  if(frameRate * .25 < positions.size()){
    positions.remove(0);
    checkForInput();
  }
  // Show the image
  tracker.display();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}

void checkForInput(){
  PVector pos0 = positions.get(0);
  PVector pos1 = positions.get(positions.size() - 1);
  float dx = pos1.x - pos0.x;
  float dy = pos1.y - pos0.y;
  
  //System.out.println("dx: " + dx);
  //System.out.println("dy: " + dy);
  
  //to the right
  if(dx > movementThresh){
    toTheRight();
  }
  if(dx < -movementThresh){
    toTheLeft();
  }
  if(dy > movementThresh){
    toTheDown();
  }
  if(dy < -movementThresh){
    toTheUp();
  }
}

void toTheRight(){
 System.out.println("R");
}

void toTheLeft(){
  System.out.println("L");
}

void toTheDown(){
  System.out.println("D");
}

void toTheUp(){
  System.out.println("U");
}
