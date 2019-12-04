const { lerp }  = require('canvas-sketch-util/math');

const MORPHCHANCE = .01;

export class Symbol {
    constructor(x, y) {
        this.x = x;
        this.y = y;

        this.setRandomSymbol();
    }

    maybeMorph() {
        if (Math.random() < MORPHCHANCE) {
            this.setRandomSymbol();
        }
    }

    setRandomSymbol(){
        this.curChar = String.fromCharCode(
            0x30A0 + Math.round(Math.random() * 96));
    }

    move(dx, dy){
        this.x += dx;
        this.y += dy;
    }

    display(context, width, height) {
        var margin = 100;

        context.fillStyle = '#56df0c';
        context.textAlign = 'center';

        const [u, v] = [this.x, this.y];
        const theX = lerp(margin, width - margin, u);
        const theY = lerp(margin, height - margin, v); 

        //console.log(theX, theY);
        context.fillText(this.curChar, theX, theY);
    }
}