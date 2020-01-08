

class Symbol {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    
    this.init();
  }

  init(){
    this.setRandomSymbol();

    this.isOn = false;
    this.brightness = 0;

    this.brightDiff = 0;

    this.lockedChar = "NONE";

    this.lockedOn = false; //for when we hit the word "The matrix"
    this.lockedOff = false;
  }

  reset(){
    this.lockedOff = false;
    this.lockedOn = false;
  }

  maybeMorph() {
    if (Math.random() < MORPHCHANCE) {
      this.setRandomSymbol();
    }
  }

  setRandomSymbol() {
    //var v = random();

    //if (v < 1) {
    //  this.curChar = String.fromCharCode(
    //    0x30A0 + Math.round(Math.random() * 96));
    //} else if (v < .99) {
    //  this.curChar = Math.floor(random(1, 10));
    //}

    var v = random();

    if (v < .9) {
      //this.curChar = String.fromCharCode(
      //  0x30A0 + Math.round(Math.random() * 96));
      this.curChar = String.fromCharCode(
        33 + Math.round(random() * (66 + 27)));
    } else if (v < 1) {
      this.curChar = Math.floor(random(1, 10));
    }
  }

  move(dx, dy) {
    this.x += dx;
    this.y += dy;
  }

  setOn() {
    if (this.lockedChar != "NONE" && time > .4) {
      this.lockedOn = true;
    }
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
    if (!this.lockedOn) {
      this.brightness--;
    }
    if (this.brightness <= 0) {
      this.isOn = false;
    }

    //get the word back in its place but let it morph a little
    if (this.lockedChar != "NONE" && this.curChar != this.lockedChar) {
      if (random() < 0.1) {
        this.curChar = this.lockedChar;
        //65 = 'A', 97 = 'a'
      }
    }
  }

  display() {
    this.update();
    //push();
    var margin = MARGIN;

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



    // for (var i = 0; i < numTimes; i++) {
    //lightest
    //add
    //overlay
    //subtract?
    //might need webgl for some of these?
    //blendMode(ADD);
    //fill(255);

    //if (i != 0) {
    //  fill(255, 1);
    //}

    if (this.lockedChar != "NONE") {
      //fill(255);
    }

    if (this.lockedOn) {  
      //blendMode(ADD);
      textSize(TEXTSIZE * 1.05);
      fill(115, 50, 99, 255); 
      //strokeWeight(13);
      //stroke(115, 80, 99);
      text(this.curChar, theX, theY);
      
      textSize(TEXTSIZE);
      fill(115, 80, 99, 10);
      text(this.curChar, theX, theY);
    } else {
      if (!this.lockedOff) {     
        if (this.brightness > .01) {
          if (time > .25) {
            var chanceToBeOn = time * time;
            if (random() < chanceToBeOn / 30) {
              this.lockedOff = true;
            } else {
              text(this.curChar, theX, theY);
            }
          } else {
            text(this.curChar, theX, theY);
          }
        }
      }
    }



    // }
    //pop();
  }
}
