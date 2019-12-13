const MORPHCHANCE = .01;
const ONLIFE = 140;
const BRIGHTDIFFMAG = 20;

class Symbol {
  constructor(x, y) {
    this.x = x;
    this.y = y;

    this.setRandomSymbol();


    this.isOn = false;
    this.brightness = 0;

    this.brightDiff = 0;
  }

  maybeMorph() {
    if (Math.random() < MORPHCHANCE) {
      this.setRandomSymbol();
    }
  }

  setRandomSymbol() {
    var v = random();

    if (v < 1) {
      this.curChar = String.fromCharCode(
        0x30A0 + Math.round(Math.random() * 96));
    } else if (v < .99) {
      this.curChar = Math.floor(random(1, 10));
    }
  }

  move(dx, dy) {
    this.x += dx;
    this.y += dy;
  }

  setOn() {
    if (!(this.brightness > ONLIFE / 2)) {
      //1 out of 1000 times, just don't turn it on
      if (random() < 0.9) {
        this.isOn = true;
        this.brightness = ONLIFE;
        this.brightDiff = random(-1, 1) * BRIGHTDIFFMAG;
      }
    }
  }

  //update the brightness and is this on
  update() {
    this.brightness--;
    if (this.brightness <= 0) {
      this.isOn = false;
    }
  }

  display() {
    this.update();
    //push();
    var margin = 100;

    //almost between 0 and 1

    //console.log(position);


    var b = map(this.brightness, 0, ONLIFE, 0, 99);
    b += this.brightDiff;
    if (this.brightness == ONLIFE - 1) {
      fill(115, 10, 99);
    } else {
      fill(115, 99, b);
    }

    textAlign(CENTER, CENTER);

    const [u, v] = [this.x, this.y];
    const theX = lerp(margin, width - margin, u);
    const theY = lerp(margin, height - margin, v); 

    //how many times to go through this loop in case we want to give it
    //the lighting up affect at the front
    var numTimes = 1;



    for (var i = 0; i < numTimes; i++) {
      //lightest
      //add
      //overlay
      //subtract?
      //might need webgl for some of these?
      //blendMode(ADD);
      //fill(255);

      if (i != 0) {
        fill(255, 1);
      }

      text(this.curChar, theX, theY);
    }
    //pop();
  }
}
