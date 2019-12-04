

import {Symbol} from './Symbol.js';

export class Rain {
    //symbols are drawn from the bottom middle
    //of the character
    //the x and y define the position of the top character in the Rain

    //so a rain object really takes up the whole length of the screen, just sometimes isn't lighting up
    //the characters don't move, but the indecies that are lit up do
    constructor(x, y, v, length, spacing, theHeight) {
        this.x = x;
        this.y = y;
        this.v = v;

        this.front = 0;
        this.back = length;

        //how long to start the indecies apart
        this.length = length;

        this.symbols = [];

        this.spacing = spacing;
        this.theHeight = theHeight

        this.initSymbols();
    }

    //space and create the symbols appropritate
    initSymbols(){
        var theX = this.x;
        var theY = this.y;

        //console.log(this.theHeight, this.spacing);
        var numRows = 1 / this.spacing;
        //console.log(numRows);

        this.numRows = numRows;

        for(var i = 0; i < numRows; i += 1){
            this.symbols.push(new Symbol(theX, theY))
            theY += this.spacing;
        }
    }

    morphAndMoveSymbols() {
        this.moveIndecies();
        this.symbols.forEach(symbol => {
            symbol.maybeMorph();
            //symbol.move(0, this.v);

            //this.boundaries(symbol);
        });
    }

    moveIndecies(){
        this.front += 1;
        this.back += 1;

        //console.log(this.numRows);
    
        if(this.back > this.numRows){
            //console.log("adf");
            this.back = 0;
        }
        if(this.front > this.numRows){
            this.front = 0;
        }
    }

    //have the strings spawn back up top 
    // boundaries(symbol){
    //     //how to get height in here
    //     if(symbol.y > 1){
    //         symbol.y -= 1;
    //     }
    // }

    update() {
        this.morphAndMoveSymbols();
    }

    //dying alpha at the top of the rain
    //lighter/whiter/brighter at the very front of the rain
    display(context, width, height) {
        //console.log("hi");
        var theBack = this.back;
        var theFront = this.front
        
        for(var i = theFront; i < theBack; i++){
            var symbol = this.symbols[i % Math.floor(theBack)];
            symbol.display(context, width, height);
        }
    }
}