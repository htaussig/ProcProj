// Ensure ThreeJS is in global scope for the 'examples/'
global.THREE = require('three');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes

// Include any additional ThreeJS examples below
require('three/examples/js/controls/OrbitControls');
//const BezierEasing = require('bezier-easing');

const Ease = require('eases').quintInOut;
const canvasSketch = require('canvas-sketch');

const settings = {
  // Make the loop animated
  animate: true,
  duration: 14,
  frameRate: 24, 
  
  // Get a WebGL canvas rather than 2D
  context: 'webgl',
  // Turn on MSAA
  attributes: { antialias: true },
  dimensions: [512, 512]
};

const sketch = ({ context }) => {
  // Create a renderer
  const renderer = new THREE.WebGLRenderer({
    context
  });

  // WebGL background color
  renderer.setClearColor('#000', 1);

  // Setup a camera
  const camera = new THREE.OrthographicCamera();
  

  const zoom = 5;
  //-.5, -1
  camera.position.set(0 * zoom, .4 * zoom, 0 * zoom);
  const eye = new THREE.Vector3(1, -1, 2);
  const target = new THREE.Vector3(1, 1, 1);
  const up = new THREE.Vector3(0, 1, 0);
  //camera.lookAt(target, up);

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
  const light = new THREE.PointLight('#FFFFFF', .7, 15.5);
  light.position.set(2, 2, -4).multiplyScalar(1.5);
  scene.add(light);

  const light2 = new THREE.PointLight('#FFFFFF', .9, 15.5);
  light2.position.set(-2, 5, -6).multiplyScalar(1.5);
  scene.add(light2);

  const light3 = new THREE.PointLight('#4EC5F1', .5, 15.5);
  light3.position.set(-2, 1, 6).multiplyScalar(1.5);
  scene.add(light3);

  
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
    const roadWidth = 1 / 16;
    //const margin = 1 / 32;

    //var blocks = []; //should push same data type as squares to these



    const xLine = getRoadValue(roadsX);
    const yLine = getRoadValue(roadsY);
    //console.log(roadsX);

    blocks = splitBoxX(blocks, xLine, roadWidth);
    blocks = splitBoxY(blocks, yLine, roadWidth);
    
   
    return blocks;
  }

  for(var i = 0; i < 3; i++){
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

  const minBuildingSize = 1 / 9;
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

      if(!(w < minBuildingSize && h < minBuildingSize)){
        var swapAxes = false;
        //switch the horizontal/vertical split
        if((w < minBuildingSize || h < minBuildingSize)){
          if(h < minBuildingSize){          
            swapAxes = true;              
          }
        }
        else{
          if(random.value() < .5){
            swapAxes = true;
          }
        }
        
        const numNewRects = random.rangeFloor(2, 4);//random.rangeFloor(3, 5); //random.rangeFloor(3, 5);
        if(random.value() < .3){
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
          nextSquares.push(data)
        }
      }
      else{
        nextSquares.push(data);
      } 
      
    });
    return nextSquares;
  }
  
  const depth = 12;
  for(var i = 0; i < depth; i++){
    squares = genBuildings(squares);
  }

  const margin = 0;
  const spacing = .023; //stays relatively constant

  const magnitude = 1.5;
  const cameraY = -.6;
  const startX = -.5;
  const startY = -.5;
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

    const x = lerp(margin, width - margin, u + startX) + spacing / 2;
    const y = lerp(margin, height - margin, v + startY) + spacing / 2; 

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

    //const tallness = random.range(.1, .9);
    const freq = .7;
    const amp = .9;
    const t = 1;
    const rVal = random.range(-.08, .08);
    const tallness = Math.abs(random.noise3D(x, y, t, freq, amp)) + .15 + rVal;
    mesh1.position.set(
      x + w / 2,
      tallness/2 + cameraY, 
      y + h / 2
    );

    mesh1.scale.set(w, tallness, h);

    scene.add(mesh1);
  }
  );

  const endingCityAngle = 1.4 * Math.PI;
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
    render ({ time, playhead }) {
      var playheadReal = (playhead * 2);
      //playheadReal = playheadReal - 1;
      playheadReal += 1.75;
      if(playheadReal > 2){
        playheadReal -= 2;
      }
      if(playheadReal < 1.5){
        playheadReal /= 1.5
        scene.rotation.y = Ease(playheadReal) * (endingCityAngle);
        //scene.rotation.x = Math.min(Math.sin(playheadReal * (2 * Math.PI)) * (Math.PI  / 2) , 0);
        scene.rotation.x = -Math.abs(Math.sin(playheadReal * (2 * Math.PI)) * (Math.PI  / 2));
      }
      else{
        playheadReal -= 1.5;
        playheadReal *= 2;
        playheadReal = 1 - playheadReal;
        scene.rotation.y = Ease(playheadReal) * (endingCityAngle);
        scene.rotation.x = Math.min(Math.sin(playheadReal * (.9 * Math.PI)) * (Math.PI  / 2), 0);
      }
      //console.log(playheadReal);
      
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
