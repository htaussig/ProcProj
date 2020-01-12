var angle = 0;

//basic material does not respond to light (same as doing fill)
//normalMaterial gives color based on x y and z value relative to shapes center
//

function setup() {
  createCanvas(400, 300, WEBGL);
  
}

function draw() {
  
 // var camX = map(mouseX, 0, width, -200, 200);
  camera(0, 0, (height / 2) / tan(PI /6), 0, 0, 0, 0, 1, 0);

  //var fov = map(mouseX, 0, width, 0, PI);
  var fov = PI / 6;
  cameraZ = (height / 2.0) / tan((PI / 3) / 2.0);
  perspective(fov, width / height, cameraZ / 10, cameraZ * 10);
  
  //ortho(-200, 200, 200, -200, 0, 1000);

  var dx = mouseX - width / 2;
  var dy = mouseY - height / 2;
  var v = createVector(dx, dy, 0);
  v.normalize();

  directionalLight(255, 0, 0, v);

  //points lights goes in all directions
  //pointLight(0, 0, 255, -200, 0, 0);
  //pointLight(255, 0, 0, 200, 0, 0);
  ambientLight(0, 0, 255);

  background(175);

  //fill(255, 0, 0);
  rectMode(CENTER);
  noStroke();
  //fill(0, 0, 255);  
  //normalMaterial();for(
  ambientMaterial(255);
  //specularMaterial(255);

  //translate(0, 0, mouseX - 100);


  for (var x = -200; x < 200; x += 50) {
    push();
    translate(x, 0, x - 200);
    rotateX(angle);
    rotateY(angle / 2);
    rotateZ(angle / 3);

    //box(25, 25, 50);
    
   // fill(255);
    
    
    beginShape();
    
    vertex(0, 0, 0);
    vertex(100, 0, 0);
    vertex(100, 100, 0);
    vertex(0, 100, 0);
    
    endShape(CLOSE);
    
    pop();
  }
  //rect(0, 0, 150, 150);

  //torus(100, 10);
  //sphere(100);

  //plane(200, 200);

  angle += 0.01;
}
