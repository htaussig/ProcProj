// Ensure ThreeJS is in global scope for the 'examples/'
global.THREE = require('three');

const palettes = require('nice-color-palettes');
const eases = require('eases');
const BezierEasing = require('bezier-easing');

// Include any additional ThreeJS examples below
require('three/examples/js/controls/OrbitControls');

const canvasSketch = require('canvas-sketch');
const random = require('canvas-sketch-util/random');

const settings = {
  //--output=tmp/
  dimensions: [512, 512],
  fps: 24, 
  //duration: 4, 
  // Make the loop animated
  animate: true,
  // Get a WebGL canvas rather than 2D
  context: 'webgl',
  // Turn on MSAA
  attributes: { antialias: true },
};

const sketch = ({ context }) => {
  // Create a renderer
  const renderer = new THREE.WebGLRenderer({
    context
  });

  // WebGL background color
  renderer.setClearColor('hsl(0, 0%, 95%)', 1);

  // Setup a camera
  //const camera = new THREE.PerspectiveCamera(45, 1, 0.01, 100);  //FOV, rescale?, close plane, far plane
  const camera = new THREE.OrthographicCamera();
  // camera.position.set(2, 2, -4);
  // camera.lookAt(new THREE.Vector3());

  // // Setup camera controller, let's you drag
  // const controls = new THREE.OrbitControls(camera, context.canvas);

  // Setup your scene
  const scene = new THREE.Scene();

  const palette = random.pick(palettes);

  const box = new THREE.BoxGeometry(1, 1, 1);
  for (let i = 0; i < 40; i++){
    const mesh = new THREE.Mesh(
      box,

      //mesh physical = standard material
      new THREE.MeshStandardMaterial({
        color: random.pick(palette)
      })
    );

    mesh.position.set(
      random.range(-1, 1), 
      random.range(-1, 1), 
      random.range(-1, 1)
    );
    mesh.scale.set(
      random.range(-1, 1), 
      random.range(-1, 1), 
      random.range(-1, 1)
    );

    mesh.scale.multiplyScalar(.5);
    scene.add(mesh);
  }
    
  scene.add(new THREE.AmbientLight('hsl(0, 0%, 100%)'));

  const light = new THREE.DirectionalLight('white', 1);
  light.position.set(
    1,4,2
  );
  scene.add(light);

  const easeFn = BezierEasing(.74,.04,.6,1);

  // // Specify an ambient/unlit colour
  // scene.add(new THREE.AmbientLight('#59314f'));

  // // Add some light
  // const light = new THREE.PointLight('#45caf7', 1, 15.5);
  // light.position.set(2, 2, -4).multiplyScalar(1.5);
  // scene.add(light);

  // draw each frame
  return {
    // Handle resize events here
    resize ({ pixelRatio, viewportWidth, viewportHeight }) {
      renderer.setPixelRatio(pixelRatio);
      renderer.setSize(viewportWidth, viewportHeight);
      
      const aspect = viewportWidth / viewportHeight;

      // Ortho zoom
      const zoom = 1.5; //larger to zoom out

      // Bounds
      camera.left = -zoom * aspect;
      camera.right = zoom * aspect;
      camera.top = zoom;
      camera.bottom = -zoom;

      // Near/Far
      camera.near = -100;
      camera.far = 100;

      // Set position & look at world center
      camera.position.set(zoom, zoom, zoom);
      camera.lookAt(new THREE.Vector3());

      // Update the camera
      camera.updateProjectionMatrix();
    },
    // Update & render your scene here
    render ({ playhead }) {
      //mesh.rotation.y = time * (10 * Math.PI / 180);
      // controls.update();
      const t = playhead;
      //console.log(playhead);
      //const angle = eases.bounceIn(t) * 2 * Math.PI;
      const angle = easeFn(t) * 2 * Math.PI;
      //console.log(angle);
      scene.rotation.y = angle;
      renderer.render(scene, camera);
    },
    // Dispose of events & renderer for cleaner hot-reloading
    unload () {
      // controls.dispose();
      renderer.dispose();
    }
  };
};

canvasSketch(sketch, settings);
