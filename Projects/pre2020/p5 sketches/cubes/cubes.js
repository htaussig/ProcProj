var NUM = 10.0;
var angle = 0.0;

function setup() {
  createCanvas(400, 400, WEBGL);
}

function draw() {


  background(0);

  //ambientLight(50);
  directionalLight(255, 0, 0, 1);

  pointLight(255, 1000, 1000, -1000);
  
  rotateX(angle);
  //rotateY(angle * 2);
  translate(-width / 2, - height / 2, 0);


  ambientMaterial(255);
  //normalMaterial();
  for (var x = 0; x < NUM; x++) {
    for (var y = 0; y < NUM; y++) {
      for (var z = 0; z < NUM; z++) {
        push();

        translate(x * width / NUM, y * height / NUM, z * height / NUM);

        box((height / NUM) / 2);

        pop();
      }
    }
  }

  angle += 0.01;
}
