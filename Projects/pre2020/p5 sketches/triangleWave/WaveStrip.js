

var NUMTRIS = 10;

var da = 1 * Math.PI / 64.0;

function WaveStrip(y, w, amp, a) {
  this.y = y;
  this.w = w;
  this.amp = amp;
  this.a = a;
  
  this.display = function(){
    beginShape();
    
    vertex(0, this.y);
    
    var tempA = this.a
    
    for(var i = 0; i < NUMTRIS; i++){    
      
      var x = (((i + .5) / NUMTRIS) * width) + ((sin(tempA) / 3) * width / NUMTRIS);
      
      vertex(x, this.y - this.amp);
      
      vertex(((i + 1.0) / NUMTRIS) * width, this.y);
      
      tempA += PI / 1;
            
    }
    
    this.a += da
    
    endShape(CLOSE);
  };
}
