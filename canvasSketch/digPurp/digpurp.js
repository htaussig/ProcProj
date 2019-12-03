const canvasSketch = require('canvas-sketch');
const random = require('canvas-sketch-util/random');


const TEXTSIZE = 40;
const SPACING = TEXTSIZE * 0.1;
const GRIDSIZE = TEXTSIZE + SPACING;
const NUMCOLS = 10;

const RAINVEL = .01;

import {Rain} from './Rain.js';

const theWidth = 2048;
const theHeight = 2048;

const settings = {
  dimensions: [ theWidth, theHeight ],
  animate: true
};


var rains = [];

//have rains be created and dissappear? or always exist?
for(var i = 0; i < 1; i += GRIDSIZE / theWidth){
  rains.push(new Rain(i, random.value(), RAINVEL, 10, GRIDSIZE / theWidth));
}

// rains.push(new Rain(200, 200, 10, 10, GRIDSIZE));
// rains.push(new Rain(270, 200, 10, 10, GRIDSIZE));

const displayAll = (context, width, height) => {
  rains.forEach(rain => {
    rain.update();
    rain.display(context, width, height);
    //console.log(rain);
  });
}


const sketch = () => {
  return ({ context, width, height }) => {
    context.fillStyle = 'black';
    context.fillRect(0, 0, width, height);
    context.font = `${TEXTSIZE}px "Arial"`;

    displayAll(context, width, height);
  };
};

canvasSketch(sketch, settings);
