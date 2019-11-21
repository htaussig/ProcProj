// Ensure ThreeJS is in global scope for the 'examples/'
global.THREE = require('three');

// Include any additional ThreeJS examples below
require('three/examples/js/controls/OrbitControls');

const canvasSketch = require('canvas-sketch');

const settings = {
  // Make the loop animated
  animate: true,
  duration: 12,
  fps: 24, 
  dimensions: [512, 512],
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
  renderer.setClearColor('#FFF', 1);

  //context.fillRect(0, 0, context.width, context.height);

  // Setup a camera
  const camera = new THREE.PerspectiveCamera();
  camera.position.set(0, 2 * Math.sqrt(3), -4);
  camera.lookAt(new THREE.Vector3());

  // Setup camera controller
  const controls = new THREE.OrbitControls(camera, context.canvas);

  // Setup your scene
  const scene = new THREE.Scene();

  const box = new THREE.BoxGeometry(1, 1, 1);
  //box.faces[0].color.setRGB(0, 0, 1);
  //box.faces[1].color.setRGB(1, 1, 1);
  //box.faces[2].color.setRGB(1, 0, 1);
 // box.faces[3].color.setRGB(1, 1, 0);
  box.faces[4].color.setRGB(0, 0, 0);
  //box.faces[5].color.setRGB(0, 0, 0);
  //box.faces[6].color.setRGB(0, 0, 0);
  //box.faces[7].color.setRGB(0, 0, 0);
  //box.faces[8].color.setRGB(0, 0, 0);
  box.faces[5].color.setRGB(0, 0, 0);
  box.faces[9].color.setRGB(1, 0, 0);
  box.faces[10].color.setRGB(1, 0, 0);
  box.faces[11].color.setRGB(1, 0, 0);
  
  const mesh = new THREE.Mesh(
    box,
    new THREE.MeshBasicMaterial({
      color: '#ffffff',
      vertexColors: THREE.FaceColors
      // roughness: 0.75,
      // flatShading: true
    })
  );
  const mesh2 = new THREE.Mesh(
    box,
    new THREE.MeshBasicMaterial({
      color: '#ffffff',
      vertexColors: THREE.FaceColors
      // roughness: 0.75,
      // flatShading: true
    })
  );
  //mesh.rotateOnAxis(1,0,0, 0);
  //mesh.rotation.set(new THREE.Vector3( 0, 0, 0));
  //mesh.rotation.x = .2;
  
  mesh.rotation.y = Math.PI / 4.0;
  mesh2.rotation.y = Math.PI / 4.0;

  mesh2.position.set(
    0, -0.75, 1
  );
  mesh2.scale.set(
    2, 2, 2
  );

  scene.add(mesh);
  scene.add(mesh2);

  // Specify an ambient/unlit colour
  scene.add(new THREE.AmbientLight('#59314f'));

  // Add some light
  const light = new THREE.PointLight('#45caf7', 1, 15.5);
  light.position.set(2, 2, -4).multiplyScalar(1.5);
  scene.add(light);

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
    render ({ time, playhead }) {
      //mesh.rotation.y = playhead * Math.PI * 2.0;
      mesh.scale.set(playhead, playhead, playhead);
      mesh.position.set(0, playhead, -playhead);
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
