// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
Kinect kinect = new Kinect(this);
public class KinectInput {
  KinectTracker tracker;

  //time in seconds allowed for an input to take
  float maxInputLength = .25;
  private static final int movementThresh = 90;

  ArrayList<PVector> positions;

  KinectInput() {
    tracker = new KinectTracker();
    positions = new ArrayList<PVector>();
  }  


  void track() {
    // Run the tracking analysis
    tracker.track();
    positions.add(tracker.getPos());
    if (frameRate * .25 < positions.size()) {
      positions.remove(0);
      checkForInput();
    }
  }


  void checkForInput() {
    PVector pos0 = positions.get(0);
    PVector pos1 = positions.get(positions.size() - 1);
    float dx = pos1.x - pos0.x;
    float dy = pos1.y - pos0.y;

    //System.out.println("dx: " + dx);
    //System.out.println("dy: " + dy);

    //to the right
    if (dx > movementThresh) {
      toTheRight();
    }
    if (dx < -movementThresh) {
      toTheLeft();
    }
    if (dy > movementThresh) {
      toTheDown();
    }
    if (dy < -movementThresh) {
      toTheUp();
    }
  }
}

void toTheRight() {
  snake.setDirection(R);
}

void toTheLeft() {
  snake.setDirection(L);
}

void toTheDown() {
  snake.setDirection(D);
}

void toTheUp() {
  snake.setDirection(U);
}
