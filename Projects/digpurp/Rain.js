

class Rain {
    //symbols are drawn from the bottom middle
    //of the character
    //the x and y define the position of the top character in the Rain

    //so a rain object really takes up the whole length of the screen, just sometimes isn't lighting up
    //the characters don't move, but the indecies that are lit up do
    constructor(x, y, v, length, spacing, theHeight) {
        this.x = x;
        this.y = y;
        this.v = v;

        this.spacing = spacing;
        var numRows = 1 / this.spacing;
        //console.log(numRows);

        this.numRows = Math.floor(numRows);

        this.back = Math.floor(random(0, this.numRows));
        this.front = this.back + length;

        //how long to start the indecies apart
        this.length = length;

        this.symbols = [];

        
        this.theHeight = theHeight;

        this.displaying = true;

        this.initSymbols();

        this.sizeChange = Math.floor(random(0, 2));
        
        this.ticksBeforeUpdate = 0;
    }

    //space and create the symbols appropritate
    initSymbols(){
        var theX = this.x;
        var theY = this.y;

        //console.log(this.theHeight, this.spacing);  

        for(var i = 0; i < this.numRows; i += 1){
            this.symbols.push(new Symbol(theX, theY));
            theY += this.spacing;
        }
    }

    morphAndMoveSymbols(time) {
        this.moveIndecies(time);
        this.symbols.forEach(symbol => {
            symbol.maybeMorph();
            //symbol.move(0, this.v);

            //this.boundaries(symbol);
        });
    }

    //does not happen every frame for sure
    //app
    updateState(){  
        if(Math.random(1) < 0.5){
          this.sizeChange = 0;
        }
        else{
          this.sizeChange = 1;
        }
        //console.log(this.sizeChange);
        this.ticksBeforeUpdate = Math.floor(random(NUMTICKSMIN, NUMTICKSMAX));
    }

    moveIndecies(){

        var SPEEDMUL = .5;

        var dBack;
        var dFront;
        if(this.sizeChange == 1){
            dBack = 1;
            dFront = 1;
        } 
        else if(this.sizeChange == 0){
            dBack = 0;
            dFront = 1;
        } 
        else if(this.sizeChange == -1){
            dBack = 1;
            dFront = 0;
        } 
        this.back += dBack * SPEEDMUL;
        this.front += dFront * SPEEDMUL;

        this.displaying = true;
        if(this.back > this.front){
            this.back = this.front;
            this.displaying = false;
        }
        else if(this.back + this.numRows < this.front){
            this.front = this.back + this.numRows;
        }

        //console.log(this.numRows);
        
        if(this.displaying){
            if(this.front > this.numRows && this.back > this.numRows){
                //console.log("adf");
                this.front -= this.numRows;
                this.back -= this.numRows;
            }
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
        if(this.ticksBeforeUpdate == 0){
          this.updateState();
        }
        else{
          this.ticksBeforeUpdate--;
        }
        this.morphAndMoveSymbols();
    }

    //dying alpha at the top of the rain
    //lighter/whiter/brighter at the very front of the rain
    display() {
        //console.log("hi");
        var theBack = Math.floor(this.front);
        var theFront = Math.floor(this.back);
       
        
        if(theBack < theFront){
            theBack += this.numRows;
        }

        //for(var i = theFront; i < theBack; i++){
        //    var index = i % Math.floor(this.numRows);
        //    //console.log(index);
        //    var symbol = this.symbols[index];

        //     //float from 0 to 1, 0 is the back,  1 is the  front
        //    var theLength = theBack - theFront;
        //    var position = (i - theFront) / (theLength - 1);
            
        //    symbol.display();
        //}
        
        var index = theFront % Math.floor(this.numRows);
        var symbol = this.symbols[index];
        symbol.setOn();
        
        colorMode(HSB, 359, 99, 99);
        for(var i = 0; i < Math.floor(this.numRows); i++){
          var symbol = this.symbols[i];
          symbol.display();
        }
        
        this.lastFront = theFront;
    }
}
