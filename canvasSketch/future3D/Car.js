const { lerp }  = require('canvas-sketch-util/math'); //npm install canvas-sketch-util in this projects directory to use this
const random = require('canvas-sketch-util/random');
const palettes = require('nice-color-palettes'); //npm install nice-color-palettes


const maxVel = .1;
const maxAcc = .1;
//const maxBrake = .1;

const CARSCALE = .33;
const CARHEIGHT = .07;
const CARWIDTH = .1;
const CARLENGTH = .15;
const CARSIZESPREAD = .02;

const CARVELOCITY = 1 / (14 * 30);

//creates a new Car Object
export function createCar(x_, y_, w_, h_, angle_, box, cameraY, startX, startY, width, height, margin, spacing, color){
    console.log(x_, y_, w_, h_, angle_, box, cameraY, startX, startY, width, height, margin, spacing);

    var newCar = {

        //console.log(x_, y_, w_, h_, angle_, box, cameraY, startX, startY, width, height, margin, spacing);


        //all floats,
        //it needs it's position and size
        x: x_,
        y: y_,

        w: w_,
        h: h_,

        angle: angle_,

        //should probably do this in the constructors but going to do it here because the data is here
        margin: margin,
        spacing: spacing,
        width: width,
        height: height,
        startX: startX,
        startY: startY,
        cameraY: cameraY,
        color: color,

        mesh: 0,

        //angle: 0,

        getX : function() {
            return this.x;
        },

        getY : function() {
            return this.y;
        },

        //create a class or something with all of the constants,
        //maybe an array, it's annoying to pass them around
        getCarMesh : function() {
    
            const [ u, v ] = [this.x, this.y];
            var [ w1, h1 ] = [this.w, this.h];      
        
            // const x = lerp(margin, width - margin, u + startX) + spacing;
            // const y = lerp(margin, height - margin, v + startY) + spacing; 
        
            var w = lerp(margin, width - margin, w1) - spacing;
            var h = lerp(margin, height - margin, h1) - spacing;
        
            var shape = box;
            var realW = w;
            var realH = h;
        
            const mesh1 = new THREE.Mesh(
            shape,
                new THREE.MeshPhysicalMaterial({
                    color: color,
                    roughness: 0.75,
                    flatShading: true
                })
            );

            this.mesh = mesh1;
        
            //const tallness = random.range(.1, .9);
            // const freq = .7;
            // const amp = .9;
            // const t = 1;
            // const rVal = random.range(-.08, .08);
            const tallness = (random.range(-CARSIZESPREAD, CARSIZESPREAD) + CARHEIGHT) * CARSCALE;
            this.tallness = tallness;
            mesh1.rotateY(this.angle);

            this.setPosition(u, v, w1, h1, mesh1);    
            mesh1.scale.set(realW, tallness, realH);       
            
        
            mesh1.basePosition = JSON.parse(JSON.stringify(mesh1.position)); //doing deep copies
            mesh1.baseScale = JSON.parse(JSON.stringify(mesh1.scale));


            
            return mesh1;
                   
        },

        //enter in normal coordinates 0 to 1 to set the position of the car
        //position of the car set from (the middle??????)
        setPosition : function(u, v, w1, h1){
            const x = lerp(this.margin, this.width - this.margin, u + this.startX) + this.spacing;
            const y = lerp(this.margin, this.height - this.margin, v + this.startY) + this.spacing; 
        
            var w = lerp(this.margin, this.width - this.margin, w1);
            var h = lerp(this.margin, this.height - this.margin, h1);

            this.mesh.position.set(
                x - w / 4,
                this.tallness / 2 + this.cameraY, 
                y - h / 4 //I have no idea why this is working, may want to change this 
            );
        },
        
        //create a random car on a road the points the right direction
        createRandomCar : function(roadsX, roadsY, otherCars){

            const wid = (random.range(-CARSIZESPREAD, CARSIZESPREAD) + CARWIDTH) * CARSCALE;
            const hei = (random.range(-CARSIZESPREAD, CARSIZESPREAD) + CARLENGTH) * CARSCALE;

            var theX = random.range(0, 1);
            var theY = random.range(0, 1);

            otherCars.forEach(car2 => {
                if(this.willIntersect(theX, theY, wid, hei, car2) == true){
                    console.log('intersected');
                    return this.createRandomCar(roadsX, roadsY, otherCars);
                }
            });

            var angle = 0;

            var xorY = 'x';
            if(random.value() < .5){
                xorY = 'y';
            }

            if(xorY == 'x'){
                //roadX is the x coordinate of one of the roads from road X (they point in the y direction)
                const roadX = random.pick(roadsX);
                //console.log(x);
                theX = roadX;
            }
            else{
                const roadY = random.pick(roadsY);
                //console.log(x);
                theY = roadY;
                angle = Math.PI / 2;
            }        
        
            
            var car1 = createCar(theX, theY, wid, hei, this.angle, this.box, this.cameraY, this.startX, this.startY, this.width, this.height, this.margin, this.spacing, this.color);
            if(car1 != false){
                return car1;
            }
            else{
                return this.createRandomCar(roadsX, roadsY, otherCars);
            }
        },

        moveCar : function(){
            const dx = Math.sin(this.angle) * CARVELOCITY;
            const dz = Math.cos(this.angle) * CARVELOCITY;

            this.x += dx;
            this.y += dz;

            this.setPosition(this.x, this.y, this.w, this.h);

            if(this.x > 1){
                this.x = 0;
            }
            if(this.y > 1){
                this.y = 0;
            }
            

              //check boundaries
            //mesh1.position.x += Math.cos(this.angle) * CARVELOCITY;
        },

        willIntersect : function(u, v, w1, h1, car2){

            const x = lerp(this.margin, this.width - this.margin, u + this.startX) + this.spacing;
            const z = lerp(this.margin, this.height - this.margin, v + this.startY) + this.spacing;
            
            var w = lerp(this.margin, this.width - this.margin, w1);
            var h = lerp(this.margin, this.height - this.margin, h1);
            
            let minX1 = x;
            //console.log(minX1);
            var minZ1 = z;
            var maxX1 = x + w;
            var maxZ1 = z + h;

            var minX2 = car2.mesh.position.x;
            var minZ2 = car2.mesh.position.z;
            var maxX2 = car2.mesh.position.x + car2.mesh.scale.x;
            var maxZ2 = car2.mesh.position.z + car2.mesh.scale.z;

            console.log(this.margin, this.width, u, this.startX, this.spacing);
            console.log(x, minX1, maxX2, maxX1, minX2,
            minZ1,maxZ2, maxZ1,minZ2);

            return (minX1 <= maxX2 && maxX1 >= minX2) &&
            (minZ1 <= maxZ2 && maxZ1 >= minZ2);
        }

    };

    return newCar;

}



export function dad(){

    return 7;
}

