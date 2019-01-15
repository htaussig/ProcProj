var arr = [];

var NUMPOINTS = 10;

function setup() {
  createCanvas(400, 400);
  
  for(var i = 0; i < NUMPOINTS; i++){
    var p = createVector(random(width), random(height));
    arr.push(p);
  }
}

function draw() {
  background(0);
  
  stroke(255);
  fill(255);
  
  loadPixels();
  for(p in pixels){
    
  }
  
  /**for(var i = 0; i < NUMPOINTS; i++){
    var p = arr[i];
    point(p.x, p.y);
  }**/
}
