ArrayList<KochLine> lines = new ArrayList<KochLine>();
boolean returning = false;

void setup(){
 size(800, 400);
 background(255);
 colorMode(HSB, 255);
 lines.add(new KochLine(new PVector(0, height - 100), new PVector(width, height - 100)));
}

void draw(){
  background(255);
  for(KochLine l : lines){
    l.display();
  }
  
  if(returning){
    for(KochLine l : lines){
      l.goHome();
    }  
  }

}

void mousePressed(){    
  generate();
}

void generate(){  
  ArrayList<KochLine> next = new ArrayList<KochLine>();
  for(KochLine l : lines){
    PVector a = l.getA();
    PVector b = l.getB();
    PVector c = l.getC();
    PVector d = l.getD();
    PVector e = l.getE();
    PVector f = l.getF();
    
    next.add(new KochLine(a, b));
    next.add(new KochLine(b, c));
    next.add(new KochLine(c, d));
    next.add(new KochLine(d, e));
    next.add(new KochLine(e, f));
  }
  lines = next;
}

void keyPressed(){

}
