const canvasSketch = require('canvas-sketch');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes

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
  console.log(palette);

//can create functions here
const createGrid = () => {
  const points = [];
  const count = 49; 
  //frequencyR for the radius, 
  //frequencyRot for the rotation
  const frequencyRad = .65; //how zoomed in/out to the noise grid we are
  const frequencyRot = .35;
  for(let x = count - 1; x >= 0; x--){
    for(let y = 0; y < count; y++){
      //uv space
      //working with numbers between 0 and 1
      const u = count <= 1 ? 0.5 : x / (count - 1); 
      const v = count <= 1 ? 0.5 : y / (count - 1); 
      const radius = (Math.abs(random.noise2D(u * frequencyRad, v * frequencyRad)) * .1) + .015;
      //console.log(radius);
      const rotation = (random.noise2D((u * frequencyRot) + 10, (v * frequencyRot) + 10) + 0) * Math.PI;
      //console.log(rotation);
      points.push({  //creating an object here!
        color: random.pick(palette),
        radius: radius, //Math.abs(random.gaussian() * 0.004) + 0.0085, //in between -3.5 and positive 3.5
        position: [u, v],
        rotation: rotation,
        text: '🐟'
      });  //I think it's like an arrayList
    }
  }

  //add a random token
  const u = random.value(); 
  const v = random.value(); 
  const radius = (Math.abs(random.noise2D(u * frequencyRad, v * frequencyRad)) * .08) + .05;
  const rotation = (random.noise2D((u * frequencyRot) + 10, (v * frequencyRot) + 10) + 0) * Math.PI;
  //console.log(rotation);
  points.push({  //creating an object here!
    color: random.pick(palette),
    radius: radius, //Math.abs(random.gaussian() * 0.004) + 0.0085, //in between -3.5 and positive 3.5
    position: [u, v],
    rotation: rotation,
    text: '🐦'

  });
  
  return points; 
};

//random.setSeed(123);
var points = createGrid();
const tokenElement = points[points.length - 1];
points = points.filter(() => random.value() > 0.5); //take away half
points.push(tokenElement);
//points = random.shuffle(points);
const margin = 330; 

  //returns a render function (pure function)
  //return { extension: '.svg', data: -------};
  return ({ context, width, height }) => {

    //background is transparent, not white
    context.fillStyle = '#02032e';
    context.fillRect(0, 0, width, height);
    
    points.forEach(data => {
      const {
        position,
        radius,
        color,
        rotation,
        text
      } = data;
    
const [ u, v ] = position;

      const x = lerp(margin, width - margin, u);
      const y = lerp(margin, height - margin, v); 

      context.beginPath();
      context.arc(x, y, radius * width, 0, Math.PI * 2, false);

      context.save(); //pushMatrix
      context.fillStyle = color;
      context.font = `${(radius / 2) * width}px "Arial"`;
      context.translate(x - (width * 2), y - (height * 2)); //draw the original shape off the screen
      context.rotate(rotation);

      //context.globalAlpha = 0.55;

      context.shadowColor = color;
      context.shadowBlur = 0;
      context.shadowOffsetX =  width * 2;
      context.shadowOffsetY =  height * 2;

      context.scale(-1, 1)
      context.textAlign = 'center';
      context.fillText(text, 0, 0);

      context.restore(); //popMatrix
      //context.fill();
      // context.strokeStyle = 'black';
      // context.lineWidth = 20; 
      // context.stroke();
    }
    
    );
    console.log(points);

    // context.fillStyle = 'pink';
    // context.fillRect(100, 0, width, height);

    // context.beginPath();
    // context.arc(width / 2, height / 2, width / 5, 0, Math.PI * 2 / 3, true); //true = ccw, false = cw
    // context.fillStyle = 'blue';
    // context.fill();
    // //try to use relative values in variables
    // context.lineWidth = width * .03;
    // context.strokeStyle = 'red';
    // context.stroke();
  };
};

canvasSketch(sketch, settings);
