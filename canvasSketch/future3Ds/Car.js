const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes


const maxVel = .1;
const maxAcc = .1;
//const maxBrake = .1;

const CARHEIGHT = .2;

//creates a new Car Object
export function createCar(x_, y_, w_, h_){

    var newCar = {
        //all floats,
        //it needs it's position and size
        x: x_,
        y: y_,

        w: w_,
        h: h_,

        getX : function() {
            return this.x;
        },

        getY : function() {
            return this.y;
        },

        //create a class or something with all of the constants,
        //maybe an array, it's annoying to pass them around
        getCarMesh : function(box, cameraY, startX, startY, width, height, margin, spacing) {
    
            const [ u, v ] = [this.x, this.y];
            var [ w1, h1 ] = [this.w, this.h];      
        
            const x = lerp(margin, width - margin, u + startX) + spacing;
            const y = lerp(margin, height - margin, v + startY) + spacing; 
        
            var w = lerp(margin, width - margin, w1) - spacing;
            var h = lerp(margin, height - margin, h1) - spacing;
        
            var shape = box;
            var realW = w;
            var realH = h;
        
            const mesh1 = new THREE.Mesh(
            shape,
                new THREE.MeshPhysicalMaterial({
                    color: 'white',
                    roughness: 0.75,
                    flatShading: true
                })
            );
        
            //const tallness = random.range(.1, .9);
            const freq = .7;
            const amp = .9;
            const t = 1;
            const rVal = random.range(-.08, .08);
            const tallness = CARHEIGHT;
            mesh1.position.set(
            x + w / 2,
            tallness / 2 + cameraY, 
            y + h / 2
            );
        
            mesh1.scale.set(realW, tallness, realH);
        
            mesh1.basePosition = JSON.parse(JSON.stringify(mesh1.position)); //doing deep copies
            mesh1.baseScale = JSON.parse(JSON.stringify(mesh1.scale));

            return mesh1;
                   
        },

        createRandomCar : function(roadsX, roadsY){
            return createCar(.1, .1, .1, .1);
        }

    };

    return newCar;

}



export function dad(){

    return 7;
}

