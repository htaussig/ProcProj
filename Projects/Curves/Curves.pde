ArrayList<PVector> points = new ArrayList<PVector>();

void setup(){
  size(400, 400);
}

void draw(){
  background(255);
  
  beginShape();
  for(PVector p : points){
    curveVertex(p.x, p.y);
  }
  endShape();
  
  
}

void mousePressed(){
 points.add(new PVector(mouseX, mouseY)); 
}

void mouseDragged(){
  points.add(new PVector(mouseX, mouseY)); 
}
