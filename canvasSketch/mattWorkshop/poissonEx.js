const canvasSketch = require('canvas-sketch');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes
const poisson = require('poisson-disk-sampling');

random.setSeed(random.getRandomSeed());
console.log(random.getSeed());

//command k does git commit and goes back to that git commit, gives git hash

const settings = {
  //size and animation and export
  suffix: random.getSeed(),
  dimensions: [ 2048, 2048 ]
  //dimensions: 'letter', // 'A4'
  //orientation: 'landscape', 
  //units: 'cm',    //change all values to cm
  //pixelsPerInch: 300
  //command s to save from the browser
};

const sketch = () => {
  const colorCount = random.rangeFloor(3, 6); //max 5, min 2
  const palette = random.shuffle(random.pick(palettes)).slice(0, colorCount); //pick a random array element
  //console.log(palette);

//can create functions here

//random.setSeed(123);
//var points = createGrid();
var p = new poisson([100, 100, 100], 11, 23, 30); //seems to work poorly with decimals
var points = p.fill();
console.log(points);
// const tokenElement = points[points.length - 1];
// points = points.filter(() => random.value() > 0.5); //take away half
// points.push(tokenElement);
//points = random.shuffle(points);
const margin = 250; 

const textArray = ['🌺','🌻','🌼','🏵','💠','🌿️'];
const colArray = ['#cda1fd', '#fff0f0', '#fbcefd', '#efaef4'];
  //returns a render function (pure function)
  //return { extension: '.svg', data: -------};
  return ({ context, width, height }) => {

    //background is transparent, not white
    context.fillStyle = 'black';
    context.fillRect(0, 0, width, height);

    points.sort((a, b) => a[2] - b[2]);
    
    points.forEach(data => {
      // const {
      //   u, v
      //   // radius,
      //   // color,
      //   // rotation,
      //   // text
      // } = data;
      const u = data[0] / 100;
      const v = data[1] / 100;
      var w = data[2] / 100;

      //console.log(u, v);
    
      //const [ u, v ] = position;

      const x = lerp(margin, width - margin, u);
      const y = lerp(margin, height - margin, v); 

      //console.log(w);

      const l = (w * 60) + 20;

      const sizeMult = .1 / ((w / 2) + 0.5);

      const text = random.pick(textArray);

      //context.fillStyle = `hsl(210, ${l}%, ${l}%)`;  //`rgb(${w * 255}, 1, 1)`;
      //context.fillRect(x, y, 100 * sizeMult, 100 * sizeMult);
      context.save();
      context.translate(x - (width * 2), y - (height * 2) + 80); //draw the original shape off the screen
      const rotation = random.range(-Math.PI / 4, Math.PI / 4);
      context.rotate(rotation);
    
      const color = random.pick(colArray);
      //`hsl(210, ${l}%, ${l}%)`
      context.shadowColor = color;
      
      context.shadowBlur = 0;
      context.shadowOffsetX =  width * 2;
      context.shadowOffsetY =  height * 2;

      context.font = `${(sizeMult / 2) * width}px "Arial"`;
      //context.scale(sizeMult, sizeMult)
      context.textAlign = 'center';
      context.fillText(text, 0, 0);

      context.restore();
    
    });
    //console.log(points);

  };
};

canvasSketch(sketch, settings);
