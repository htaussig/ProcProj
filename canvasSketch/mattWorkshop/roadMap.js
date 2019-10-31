const canvasSketch = require('canvas-sketch');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes');

const settings = {
  dimensions: [ 2048, 2048 ]
};

const sketch = () => {
    
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

  //generating the starting roads and blocks
  const genCityBlocks = (blocks) => {
    const roadWidth = 1 / 16;
    const margin = 1 / 32;

    //var blocks = []; //should push same data type as squares to these

    


    blocks = splitBoxX(blocks, random.value(), .01);
    blocks = splitBoxY(blocks, random.value(), .01);
    
   
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

      if(!(w < 1 / 32 || h < 1 / 32)){
        var swapAxes = false;
        //switch the horizontal/vertical split
        if(random.value() < .5){
          swapAxes = true;
        }
        const numNewRects = random.rangeFloor(2, 4);//random.rangeFloor(3, 5); //random.rangeFloor(3, 5);
        if(random.value() < .07){
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
  
  const depth = 15;
  for(var i = 0; i < depth; i++){
    squares = genBuildings(squares);
  }

  const margin = 0;
  const spacing = 10; //stays relatively constant

  return ({ context, width, height }) => {
    context.fillStyle = random.pick(palette);
    context.fillRect(0, 0, width, height);

    squares.forEach(data => {
      const {
        position, 
        color,     
        size
      } = data;
    
      const [ u, v ] = position;
      const [ w1, h1 ] = size;

      const x = lerp(margin, width - margin, u);
      const y = lerp(margin, height - margin, v); 

      const w = lerp(margin, width - margin, w1) - spacing;
      const h = lerp(margin, height - margin, h1) - spacing;

      context.fillStyle = color;
      context.fillRect(x, y, w, h);
      
    });
  };
};


canvasSketch(sketch, settings);
