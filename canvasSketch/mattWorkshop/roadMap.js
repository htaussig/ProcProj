const canvasSketch = require('canvas-sketch');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes');

const settings = {
  dimensions: [ 2048, 2048 ]
};

const sketch = () => {

    
  const squares = [];

  const count = 2;

  const palette = random.pick(palettes);

  const spacingMult = 1;
  for(var i = .5; i < count; i++){
    for(var j = .5; j < count; j++){
      squares.push({
        position: [(1 / count) * i, (1 / count) * j],
        color: random.pick(palette),
        size: [(1 / count) / spacingMult, (1 / count) / spacingMult]
      });
    }
  }

  const depth = 40;
  for(var i = 0; i < depth; i++){
    nextSquares = [];
    squares.forEach(data => {
      const {
        position,
        color,
        size
      } = data;

      var [u, v] = position;
      var [w, h] = size;

      if(!(w < 1 / 4 || h < 1 / 4)){
        var swapAxes = false;
        //switch the horizontal/vertical split
        if(random.value() < .5){
          swapAxes = true;
        }
        const numNewRects = random.rangeFloor(2, 4);//random.rangeFloor(3, 5); //random.rangeFloor(3, 5);
        if(random.value() < .07){
          const halfWay = -.5 + (1 / (numNewRects * 2));
          for(var n = halfWay; n <= -halfWay; n += 1 / numNewRects){
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
  
            squares.push({
              position: [tempU, tempV],
              color: random.pick(palette),
              size: [tempW, tempH]
            });
          }
        }
      }     
    });
    //squares
    //squares.push(nextSquares);
  }

  const margin = 0;
  const spacing = 0; //stays relatively constant

  return ({ context, width, height }) => {
    context.fillStyle = 'white';
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
      context.fillRect(x - w / 2, y - h / 2, w, h);
      
    });
  };
};


canvasSketch(sketch, settings);
