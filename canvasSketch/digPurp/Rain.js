

import {Symbol} from './Symbol.js';

export class Rain {
    //symbols are drawn from the bottom middle
    //of the character
    //the x and y define the position of the top character in the Rain
    constructor(x, y, v, length, spacing) {
        this.x = x;
        this.y = y;
        this.v = v;

        //number of characters in the rain string
        this.length = length;

        this.symbols = [];

        this.spacing = spacing;

        this.initSymbols();
    }

    //space and create the symbols appropritate
    initSymbols(){
        var theX = this.x;
        var theY = this.y;
        for(var i = 0; i < this.length; i++){
            this.symbols.push(new Symbol(theX, theY))
            theY += this.spacing;
        }
    }

    morphAndMoveSymbols() {
        this.symbols.forEach(symbol => {
            symbol.maybeMorph();
            symbol.move(0, this.v);

            this.boundaries(symbol);
        });
    }

    //have the strings spawn back up top 
    boundaries(symbol){
        //how to get height in here
        if(symbol.y > 1){
            symbol.y -= 1;
        }
    }

    update() {
        this.morphAndMoveSymbols();
    }

    //dying alpha at the top of the rain
    //lighter/whiter/brighter at the very front of the rain
    display(context, width, height) {
        this.symbols.forEach(symbol => {
            symbol.display(context, width, height);
        });
    }
}