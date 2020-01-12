/**
 * Edge Detection
 * 
 * Change the default shader to apply a simple, custom edge detection filter.
 * 
 * Press the mouse to switch between the custom and default shader.
 */

PShader edges;  
PImage img;
boolean enabled = true;
    
void setup() {
  size(1200, 675, P2D);
  img = loadImage("download.jpg");      
  edges = loadShader("edges.glsl");
}

void draw() {
  if (enabled == true) {
    shader(edges);
  }
  image(img, 0, 0, img.width, img.height);
}
    
void mousePressed() {
  enabled = !enabled;
  if (!enabled == true) {
    resetShader();
  }
}
