const canvasSketch = require('canvas-sketch');
const createShader = require('canvas-sketch-util/shader');
const glsl = require('glslify');

// Setup our sketch
const settings = {
  context: 'webgl',
  animate: true,
  duration: 6,
  fps: 24,
  dimensions: [512, 512]
};

// Your glsl code
const frag = glsl(/* glsl */`
  precision highp float;

  uniform float time;
  uniform float playhead;
  uniform float aspect;
  varying vec2 vUv;

  #pragma glslify: noise = require('glsl-noise/simplex/4d');
  #pragma glslify: hsl2rgb = require('glsl-hsl2rgb');

  void main () {
    // vec3 colorA = sin(time * 2.0) + vec3(1.0, 0.0, 0.0);
    // vec3 colorB = vec3(0.0, 0.0, 1.0);

    vec2 center = vUv - vec2(0.5, 0.5);
    center.x *= aspect;
    float dist = length(center);

    float alpha = smoothstep(0.252, 0.25, dist);

    // vec3 color = mix(colorA, colorB, vUv.x + sin(time) * vUv.y);
    // gl_FragColor = vec4(color, alpha);

    float n = noise(vec4(center * 1.85, sin(playhead * 2.0 * 3.141592) * 0.2, cos(playhead * 2.0 * 3.141592) * 0.2) + 6.0);  

    vec3 color = hsl2rgb(
      0.65 + n * 0.2,
      0.5,
      0.5
    );

    gl_FragColor = vec4(color, alpha);
  }
`);
//all values up there between 0 and 1 and need decimal point
//dist = distance from pixel to that thing


// Your sketch, which simply returns the shader
const sketch = ({ gl }) => {
  // Create the shader and return it
  return createShader({
    clearColor: 'white', //the background color
    // Pass along WebGL context
    gl,
    // Specify fragment and/or vertex shader strings
    frag,
    // Specify additional uniforms to pass down to the shaders
    uniforms: {
      // Expose props from canvas-sketch
      time: ({ time }) => time,
      playhead: ({ playhead }) => playhead,
      aspect: ({ width, height }) => width / height
    }
  });
};

canvasSketch(sketch, settings);
