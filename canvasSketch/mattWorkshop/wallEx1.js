const canvasSketch = require('canvas-sketch');

const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this


random.setSeed(random.getRandomSeed());
console.log(random.getSeed());

const settings = {
  dimensions: [ 2048, 2048 ],
  pixelsPerInch: 300
};

const sketch = () => {
  const count = 6; //how many rows and cols
  const margin = 250; 

  const colorCount = random.rangeFloor(5, 6); //max 5, min 4
  const palette = random.shuffle(random.pick(palettes)).slice(0, colorCount); //pick a random array element

  const createGrid = () => {
    const points = [];
    const count = 36; 
    //frequencyR for the radius, 
    for(let x = 0; x < count; x++){
      for(let y = 0; y < count; y++){
        //uv space
        //working with numbers between 0 and 1
        const u = count <= 1 ? 0.5 : x / (count - 1); 
        const v = count <= 1 ? 0.5 : y / (count - 1); 
        points.push({  //creating an object here!
          position: [u, v]
        });  //I think it's like an arrayList
      }
    }
    return points; 
  };

  const getBuilding = (points) => {
    const p1 = random.pick(points);
    const p2 = random.pick(points);

    var bottomY = 1;

    
    const p4 = {
      position: [p1.position[0], bottomY]
    }
    const p3 = {
      position: [p2.position[0], bottomY]
    }
    //console.log(p1, p2, p3, p4);
    const zVal = (p1.position[1] + p2.position[1]) / 2.0;
    return {
      points: [p1, p2, p3, p4],
      color: random.pick(palette),
      z: zVal
    };
  };

  return ({ context, width, height }) => {   
    context.fillStyle = 'white';
    context.fillRect(0, 0, width, height);

    const points = createGrid();
    //console.log(points);

    // points.forEach(data => {
    //   const {
    //     position,
    //     color,
    //   } = data;
    
    //   const [ u, v ] = position;

    //   const x = lerp(margin, width - margin, u);
    //   const y = lerp(margin, height - margin, v); 

    //   //context.save(); //pushMatrix
    //   //context.translate(x, y);
    //   context.beginPath();
    //   context.arc(x, y, 20, 0, Math.PI * 2, false); 
    //   context.fillStyle = 'black';
    //   context.fill();

    //   //context.fillRect(getBuilding(10), getBuilding(100), 10, 10);
    //   // context.fillRect(10, 10, 10, 10);
      
    //   //context.restore(); //popMatrix
    //   //context.fill();
    //   // context.strokeStyle = 'black';
    //   // context.lineWidth = 20; 
    //   // context.stroke();
    // });

    const quads = []

    for (i = 0; i < 60; i++){
      quads.push(getBuilding(points));
    }

    quads.sort((a, b) => a.zVal - b.zVal);

    quads.forEach(({points, color, zVal}) => {
      //const quad = getBuilding(points);
      //console.log(quad);
      context.beginPath();

      points.forEach(data => {
        const {
          position
        } = data;
        const [u, v] = position;
        const x = lerp(margin, width - margin, u);
        const y = lerp(margin, height - margin, v); 
        //console.log(x, y);
        context.lineTo(x, y);
      });

      context.closePath()
      // Draw the trapezoid with a specific colour
      context.lineWidth = 20;
      context.globalAlpha = 0.85;
      context.fillStyle = color;
      context.fill();

      // Outline at full opacity
      context.lineJoin = context.lineCap = 'round';
      context.strokeStyle = 'white';
      context.globalAlpha = 1;
      context.stroke();
    
    });
      
   

  };
};

canvasSketch(sketch, settings);
