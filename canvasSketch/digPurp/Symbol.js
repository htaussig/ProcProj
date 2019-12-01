const MORPHCHANCE = .1;

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

    display(context) {
        context.fillStyle = '#56df0c';
        context.textAlign = 'center';
        context.fillText(this.curChar, this.x, this.y);
    }
}