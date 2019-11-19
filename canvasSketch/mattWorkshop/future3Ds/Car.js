
const maxVel = .1;
const maxAcc = .1;
//const maxBrake = .1;

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

    };

    return newCar;

}

export function dad(){

    return 7;
}

