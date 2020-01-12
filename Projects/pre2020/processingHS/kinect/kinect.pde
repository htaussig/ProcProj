import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect kinect;

//depth is in mm between 0 and 2048

void setup(){
  size(640, 480, P3D);
  kinect = new Kinect(this);
  
  kinect.initDepth();
  kinect.activateDevice(1);
}

void draw(){
  background(0);
  
  PImage img = kinect.getDepthImage();
  //image(img, 0, 0);
  
  //only looking at every 20 pixels
  int skip = 20;
  for(int x = 0; x < img.width; x += skip){
    for(int y = 0; y < img.height; y += skip){
      int index = x + y * img.width;
      int col = img.pixels[index];
      float b = brightness(col);
      float z = map(b, 0, 255, 150, -150);
      fill(col);
      strokeWeight(0);
      pushMatrix();
      translate(x, y, z);
      rect(0, 0, skip / 2, skip / 2); 
      popMatrix();
    }
  }
}
