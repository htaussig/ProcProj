const canvasSketch = require('canvas-sketch');
const random = require('canvas-sketch-util/random');


const TEXTSIZE = 30;
const SPACING = TEXTSIZE * 0.1;
const GRIDSIZE = TEXTSIZE + SPACING;
//const NUMCOLS = 10;

const RAINVEL = .01;

const FPS = 24;
const tickLength = 1 / FPS;
const numTicks = 5; //before update

let d = new Date();
let lastTime = 0;
let lastTimeTick = 0;

import {Rain} from './Rain.js';

const theWidth = 2048;
const theHeight = 2048;

const settings = {
  dimensions: [ theWidth, theHeight ],
  fps: 24,
  // duration: 1,
  animate: true  
};


var rains = [];

//have rains be created and dissappear? or always exist?
for(var i = 0; i < 1; i += GRIDSIZE / theWidth){
  rains.push(new Rain(i, 0, RAINVEL, 15, GRIDSIZE / theWidth, theHeight));
}

// rains.push(new Rain(200, 200, 10, 10, GRIDSIZE));
// rains.push(new Rain(270, 200, 10, 10, GRIDSIZE));

const displayAll = (context, width, height, time) => {
  
  var dt = time - lastTime;
  //dt /= 1000;
  
  //console.log(time);
  //console.log(dt, numTicks * tickLength);
  //console.log(numTicks * tickLength > dt);

  rains.forEach(rain => {

    if(numTicks * tickLength < dt){
      lastTime = time;
      rain.updateState();
    }
    rain.update(time);
    rain.display(context, width, height);
    //console.log(rain);
  });
}


const sketch = () => {
  return ({ context, width, height, time }) => {
    context.fillStyle = 'black';
    context.fillRect(0, 0, width, height);
    context.font = `${TEXTSIZE}px "Arial"`;

    displayAll(context, width, height, time);
  };
};

canvasSketch(sketch, settings);
