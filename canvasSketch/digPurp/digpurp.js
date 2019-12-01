const canvasSketch = require('canvas-sketch');
const TEXTSIZE = 48;
const SPACING = TEXTSIZE * 1.1;

import {Rain} from './Rain.js';

const settings = {
  dimensions: [ 2048, 2048 ],
  animate: true
};


var rains = [];

for(int i = 0; i < )

rains.push(new Rain(200, 200, 10, 10, SPACING));
rains.push(new Rain(270, 200, 10, 10, SPACING));

const displayAll = (context) => {
  rains.forEach(rain => {
    rain.update();
    rain.display(context);
  });
}


const sketch = () => {
  return ({ context, width, height }) => {
    context.fillStyle = 'black';
    context.fillRect(0, 0, width, height);
    context.font = `${TEXTSIZE}px "Arial"`;

    displayAll(context);
  };
};

canvasSketch(sketch, settings);
