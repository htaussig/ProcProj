const canvasSketch = require('canvas-sketch');

const settings = {
  dimensions: [ 2048, 2048 ]
};

const sketch = () => {
  return ({ context, width, height }) => {
    context.fillStyle = 'white';
    context.fillRect(0, 0, width, height);
  };
};

const squares = [];

for(var i = 0; i < 2; i++){
  for(var j = 0; j < 2; j++){
    squares.push({
      position: [.25 + .5 * i, .25 + .5 * j],
      color:'blue',
      size: [.25, .25]
    });
  }
}

canvasSketch(sketch, settings);
