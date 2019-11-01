// Ensure ThreeJS is in global scope for the 'examples/'
global.THREE = require('three');
const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes

// Include any additional ThreeJS examples below
require('three/examples/js/controls/OrbitControls');

const canvasSketch = require('canvas-sketch');

const settings = {
  // Make the loop animated
  animate: true,
  // Get a WebGL canvas rather than 2D
  context: 'webgl',
  // Turn on MSAA
  attributes: { antialias: true }
};

const sketch = ({ context }) => {
  // Create a renderer
  const renderer = new THREE.WebGLRenderer({
    context
  });

  // WebGL background color
  renderer.setClearColor('#000', 1);

  // Setup a camera
  const camera = new THREE.PerspectiveCamera(45, 1, 0.01, 100);
  camera.position.set(2, 2, -4);
  camera.lookAt(new THREE.Vector3());

  // Setup camera controller
  const controls = new THREE.OrbitControls(camera, context.canvas);

  // Setup your scene
  const scene = new THREE.Scene();

  const box = new THREE.BoxGeometry(1, 1, 1);
  // const mesh = new THREE.Mesh(
  //   box,
  //   new THREE.MeshPhysicalMaterial({
  //     color: 'white',
  //     roughness: 0.75,
  //     flatShading: true
  //   })
  // );
  // scene.add(mesh);

  // Specify an ambient/unlit colour
  scene.add(new THREE.AmbientLight('#FFFFFF'));

  // Add some light
  const light = new THREE.PointLight('#FFFFFF', 1, 15.5);
  light.position.set(2, 2, -4).multiplyScalar(1.5);
  scene.add(light);

  const createGrid = () => {
    const points = [];
    const count = 5; 
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
        //const rotation = (random.noise2D((u * frequencyRot) + 10, (v * frequencyRot) + 10) + 0) * Math.PI;
        //console.log(rotation);
        points.push({  //creating an object here!
          color: 'white',//random.pick(palette),
          radius: radius, //Math.abs(random.gaussian() * 0.004) + 0.0085, //in between -3.5 and positive 3.5
          position: [u, v],
          //rotation: rotation,
          
        });  //I think it's like an arrayList
      }
    }
    return points;
  };

  const points = createGrid();

  points.forEach(data => {
    const {
      position,
      radius,
      color,
      //otation      
    } = data

    const mesh1 = new THREE.Mesh(
      box,
      new THREE.MeshPhysicalMaterial({
        color: 'white',
        roughness: 0.75,
        flatShading: true
      })
    );

    mesh1.position.set(
      position[0],
      0, 
      position[1]  
    );

    mesh1.scale.set(.1, .1, .1);

    scene.add(mesh1);
  }
  );

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
    render ({ time }) {
      //mesh.rotation.y = time * (10 * Math.PI / 180);
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
