// Ensure ThreeJS is in global scope for the 'examples/'
global.THREE = require('three');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes

// Include any additional ThreeJS examples below
require('three/examples/js/controls/OrbitControls');

const canvasSketch = require('canvas-sketch');

const settings = {
  // Make the loop animated
  animate: true,
  // Get a WebGL canvas rather than 2D
  context: 'webgl',
  // Turn on MSAA
  attributes: { antialias: true }
};

const sketch = ({ context }) => {
  // Create a renderer
  const renderer = new THREE.WebGLRenderer({
    context
  });

  // WebGL background color
  renderer.setClearColor('#000', 1);

  // Setup a camera
  const camera = new THREE.PerspectiveCamera(45, 1, 0.01, 100);
  camera.position.set(2, 2, -4);
  camera.lookAt(new THREE.Vector3());

  // Setup camera controller
  const controls = new THREE.OrbitControls(camera, context.canvas);

  // Setup your scene
  const scene = new THREE.Scene();

  const box = new THREE.BoxGeometry(1, 1, 1);
  // const mesh = new THREE.Mesh(
  //   box,
  //   new THREE.MeshPhysicalMaterial({
  //     color: 'white',
  //     roughness: 0.75,
  //     flatShading: true
  //   })
  // );
  // scene.add(mesh);

  // Specify an ambient/unlit colour
  scene.add(new THREE.AmbientLight('#FFFFFF'));

  // Add some light
  const light = new THREE.PointLight('#FFFFFF', 1, 15.5);
  light.position.set(2, 2, -4).multiplyScalar(1.5);
  scene.add(light);

  var squares = [{
    position: [0, 0],
    color: 'black',
    size: [1, 1]
  }];

  const count = 2;

  const palette = random.pick(palettes);

  //basically creating a road
  const splitBoxX = (blocks, xLine, roadWidth) => {
    const newBlocks = [];
    blocks.forEach(data => {
      const {
        position,
        color,
        size
      } = data;

      var [u, v] = position;
      var [w, h] = size;

      if(u < xLine && xLine < u + w){
        if(u < xLine - roadWidth / 2){
          //left square
          newBlocks.push({
            position: [u, v],
            color: random.pick(palette),
            size: [xLine - u - (roadWidth / 2), h]
          });
        }
        if((u + w) > xLine + roadWidth / 2){
          //right square
          newBlocks.push({
            position: [xLine + (roadWidth / 2), v],
            color: random.pick(palette),
            size: [(u + w) - (xLine + roadWidth / 2), h]
          });
        }             
      }
      else{
        newBlocks.push(data);
      }
    });
    return newBlocks;
  }

  const splitBoxY= (blocks, yLine, roadWidth) => {
    const newBlocks = [];
    blocks.forEach(data => {
      const {
        position,
        color,
        size
      } = data;

      var [u, v] = position;
      var [w, h] = size;

      if(v < yLine && yLine < v + h){
        //top square
        if(v < yLine - roadWidth / 2){
          newBlocks.push({
            position: [u, v],
            color: random.pick(palette),
            size: [w, yLine - v - roadWidth / 2]
          });
        }
        if((v + h) > yLine + roadWidth / 2){
          //bottom square
          newBlocks.push({
            position: [u, yLine + roadWidth / 2],
            color: random.pick(palette),
            size: [w, (v + h) - (yLine + roadWidth / 2)]
          });
        }
      }
      else{
        newBlocks.push(data);
      }
    });
    return newBlocks;
  }

  const getRoadValue = (roads) => {
    const spacing = .1;
    const distance = .2;
    var val = random.range(spacing, 1 - spacing);

    var tooClose = false;

    roads.forEach(num => {
      if(Math.abs(num - val) < distance){
        //risk of too many recursive loops here
        tooClose = true;
      }
    });
    if(!tooClose){
      roads.push(val);
      return val;
    }
    else{
      return getRoadValue(roads);
    }
  }

  //generating the starting roads and blocks
  var roadsX = [];
  var roadsY = [];
  const genCityBlocks = (blocks) => {
    const roadWidth = 1 / 24;
    //const margin = 1 / 32;

    //var blocks = []; //should push same data type as squares to these



    const xLine = getRoadValue(roadsX);
    const yLine = getRoadValue(roadsY);
    console.log(roadsX);

    blocks = splitBoxX(blocks, xLine, roadWidth);
    blocks = splitBoxY(blocks, yLine, roadWidth);
    
   
    return blocks;
  }

  for(var i = 0; i < 2; i++){
    squares = genCityBlocks(squares);
    //console.log(squares);
  }

  //const spacingMult = 1;
  // for(var i = .5; i < count; i++){
  //   for(var j = .5; j < count; j++){
  //     squares.push({
  //       position: [(1 / count) * i, (1 / count) * j],
  //       color: random.pick(palette),
  //       size: [(1 / count) / spacingMult, (1 / count) / spacingMult]
  //     });
  //   }
  // }

  const genBuildings = (squares) => {
    var nextSquares = [];
    squares.forEach(data => {
      const {
        position,
        color,
        size
      } = data;

      var [u, v] = position;
      var [w, h] = size;

      if(!(w < 1 / 8 || h < 1 / 8)){
        var swapAxes = false;
        //switch the horizontal/vertical split
        if(random.value() < .5){
          swapAxes = true;
        }
        const numNewRects = random.rangeFloor(2, 4);//random.rangeFloor(3, 5); //random.rangeFloor(3, 5);
        if(random.value() < .4){
          //const halfWay = -.5 + (1 / (numNewRects * 2));
          for(var i = 0; i < numNewRects; i++){
            var n = i / numNewRects;
            var tempU = u;
            var tempV = v;
            var tempW = w;
            var tempH = h;
            if(swapAxes){ 
              tempU += n * w;
              tempW /= numNewRects;
            }
            else{
              tempV += n * h;
              tempH /= numNewRects;
            }
  
            nextSquares.push({
              position: [tempU, tempV],
              color: random.pick(palette),
              size: [tempW, tempH]
            });
          }
        }
        else{
          nextSquares.push(data);
        }
      }
      else{
        nextSquares.push(data);
      } 
      
    });
    return nextSquares;
  }
  
  const depth = 5;
  for(var i = 0; i < depth; i++){
    squares = genBuildings(squares);
  }

  const margin = 0;
  const spacing = .01; //stays relatively constant

  const magnitude = 1;
  const width = 1 * magnitude;
  const height = 1 * magnitude;
  squares.forEach(data => {
    const {
      position, 
      color,     
      size
    } = data;
  
    const [ u, v ] = position;
    const [ w1, h1 ] = size;

    const x = lerp(margin, width - margin, u) + spacing / 2;
    const y = lerp(margin, height - margin, v) + spacing / 2; 

    const w = lerp(margin, width - margin, w1) - spacing;
    const h = lerp(margin, height - margin, h1) - spacing;


    const mesh1 = new THREE.Mesh(
      box,
      new THREE.MeshPhysicalMaterial({
        color: color,
        roughness: 0.75,
        flatShading: true
      })
    );

    mesh1.position.set(
      x + w / 2,
      0, 
      y + h / 2
    );

    mesh1.scale.set(w, random.value(), h);

    scene.add(mesh1);
  }
  );

  // draw each frame
  return {
    // Handle resize events here
    resize ({ pixelRatio, viewportWidth, viewportHeight }) {
      renderer.setPixelRatio(pixelRatio);
      renderer.setSize(viewportWidth, viewportHeight);
      camera.aspect = viewportWidth / viewportHeight;
      camera.updateProjectionMatrix();
    },
    // Update & render your scene here
    render ({ time }) {
      //mesh.rotation.y = time * (10 * Math.PI / 180);
      controls.update();
      renderer.render(scene, camera);
    },
    // Dispose of events & renderer for cleaner hot-reloading
    unload () {
      controls.dispose();
      renderer.dispose();
    }
  };
};

canvasSketch(sketch, settings);
