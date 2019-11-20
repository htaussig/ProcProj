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

import {createCar} from './Car.js';




const settings = {
  // Make the loop animated
  animate: true,
  duration: 14,
  //fps: 24,
  
  // Get a WebGL canvas rather than 2D
  context: 'webgl',
  // Turn on MSAA
  attributes: { antialias: true },
  dimensions: [2048, 2048]
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
  camera.position.set(1 * zoom, .45 * zoom, -.33 * zoom);
  const eye = new THREE.Vector3(1, -1, 2);
  const target = new THREE.Vector3(1, 1, 1);
  const up = new THREE.Vector3(0, 1, 0);
  //camera.lookAt(target, up);

  // Setup camera controller
  const controls = new THREE.OrbitControls(camera, context.canvas);

  // Setup your scene
  const scene = new THREE.Scene();


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
  const roadWidth = 1 / 16;
  const genCityBlocks = (blocks, roadMeshes1) => {
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

  var meshes = []; //all of our meshes
  

  var buildingShapes = []
  for(var numSides = 5; numSides <= 6; numSides++){
    //if(numSides != 4){
      buildingShapes.push(new THREE.CylinderGeometry(1,1,1, numSides));
    //}
  }
  //buildingShapes.push(new THREE.CylinderGeometry(1,1,1,70)); //our cylinder
  const box = new THREE.BoxGeometry(1, 1, 1);

  
  var roadMeshes = [];
  

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
    var [ w1, h1 ] = size;

    

    const x = lerp(margin, width - margin, u + startX) + spacing;
    const y = lerp(margin, height - margin, v + startY) + spacing; 

    var w = lerp(margin, width - margin, w1) - spacing;
    var h = lerp(margin, height - margin, h1) - spacing;

    var shape = box;
    var realW = w;
    var realH = h;
    if(Math.abs(w1 - h1) < .01){
      shape = random.pick(buildingShapes);
      realW = w / 2.0;
      realH = h / 2.0;
    }

    const mesh1 = new THREE.Mesh(
      shape,
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

    mesh1.scale.set(realW, tallness, realH);

    mesh1.basePosition = JSON.parse(JSON.stringify(mesh1.position)); //doing deep copies
    mesh1.baseScale = JSON.parse(JSON.stringify(mesh1.scale));
    meshes.push(mesh1);

    scene.add(mesh1);
  }
  );

  // const roadsXY = [];
  // roadsXY.push(roadsX);
  // roadsXY.push(roadsY);
  // roadsX.push(0);
  // roadsX.push(1);


  //roadheight is negative so that groudnlevel for the cars is still 0
  const ROADHEIGHT = -.01;
  roadsX.forEach(data => {
    const u = data;
    const v = .5;
    const w1 = roadWidth;
    //const w1 = .1;
    const h1 = 1;

    const tallness = ROADHEIGHT;

    //why would we divide the spacing here by 2 but not for the regular stuff?
    const x = lerp(margin, width - margin, u + startX) + spacing / 2;
    const y = lerp(margin, height - margin, v + startY) + spacing / 2; 

    var w = lerp(margin, width - margin, w1) - spacing;
    var h = lerp(margin, height - margin, h1) - spacing;

    const mesh1 = new THREE.Mesh(
      box,
      new THREE.MeshPhysicalMaterial({
        color: 'gray',
        roughness: 0.75,
        flatShading: true
      })
    );
    
    mesh1.scale.set(w, tallness, h);
    
    mesh1.position.set(
      x + 0,
      tallness/2 + cameraY, 
      y
    );

    scene.add(mesh1);
  })

  roadsY.forEach(data => {
    const u = .5;
    const v = data;
    const w1 = 1;
    //const w1 = .1;
    const h1 = roadWidth;

    const tallness = ROADHEIGHT;

    //why would we divide the spacing here by 2 but not for the regular stuff?
    const x = lerp(margin, width - margin, u + startX) + spacing / 2;
    const y = lerp(margin, height - margin, v + startY) + spacing / 2; 

    var w = lerp(margin, width - margin, w1) - spacing;
    var h = lerp(margin, height - margin, h1) - spacing;

    const mesh1 = new THREE.Mesh(
      box,
      new THREE.MeshPhysicalMaterial({
        color: 'gray',
        roughness: 0.75,
        flatShading: true
      })
    );
    
    mesh1.scale.set(w, tallness, h);
    
    mesh1.position.set(
      x + 0,
      tallness/2 + cameraY, 
      y
    );

    scene.add(mesh1);
  })

  var cars = []; //hold all the cars

  const NUMCARS = 10;

  var car1 = createCar(-.1, -.1, .2, .2);

  for(var i = 0; i < NUMCARS; i++){
    car1.createRandomCar(roadsX, roadsY);
  }
  
  var carMeshes = []; //so that we can update them later
  // console.log(car1);
  // console.log(car1.x);
  // console.log(car1.getX());
  // console.log(car1.getX);
  cars.push(car1);

  //don't think car1 has to be named data instead?
  cars.forEach(car1 => {

    //add the cars to the scene as the type of box you want them to be
    var carMesh1 = car1.getCarMesh(box, cameraY, startX, startY, width, height, margin, spacing);

    carMeshes.push(carMesh1);

    scene.add(carMesh1);

  })



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
      scene.updateMatrixWorld(true);

      const playangle = playhead * 2 * Math.PI;
      //console.log(playangle);
      const tx = Math.cos(playangle);
      const ty = Math.sin(playangle);
      //meshes is not related to scene itself, must be added
      meshes.forEach(mesh => {
        //var position = new THREE.Vector3();
        //position.setFromMatri( mesh.matrixWorld );
            
        //console.log(mesh.randVal);
        const minHeight = .1;
        const yDiff = random.noise4D(mesh.basePosition.x, mesh.basePosition.z, tx / 2, ty / 2, 1, .12);
        const y = Math.max(mesh.basePosition.y + yDiff, -1)
        mesh.position.set(
          mesh.basePosition.x,
          y, 
          mesh.basePosition.z
        );
    
        mesh.scale.set(mesh.baseScale.x , mesh.baseScale.y + 2 * yDiff, mesh.baseScale.z);
      });

      scene.rotation.y = playangle;

      // var playheadReal = (playhead * 2);
      // //playheadReal = playheadReal - 1;
      // playheadReal += 1.75;
      // if(playheadReal > 2){
      //   playheadReal -= 2;
      // }
      // if(playheadReal < 1.5){
      //   playheadReal /= 1.5
      //   scene.rotation.y = Ease(playheadReal) * (endingCityAngle);
      //   //scene.rotation.x = Math.min(Math.sin(playheadReal * (2 * Math.PI)) * (Math.PI  / 2) , 0);
      //   scene.rotation.x = -Math.abs(Math.sin(playheadReal * (2 * Math.PI)) * (Math.PI  / 2));
      // }
      // else{
      //   playheadReal -= 1.5;
      //   playheadReal *= 2;
      //   playheadReal = 1 - playheadReal;
      //   scene.rotation.y = Ease(playheadReal) * (endingCityAngle);
      //   scene.rotation.x = Math.min(Math.sin(playheadReal * (.9 * Math.PI)) * (Math.PI  / 2), 0);
      // }
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
