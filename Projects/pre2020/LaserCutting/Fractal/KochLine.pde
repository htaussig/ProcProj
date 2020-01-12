public class KochLine{
  
  PVector start;
  PVector end;
  
  PVector realStart;
  PVector realEnd;
  
  public KochLine(PVector start_, PVector end_){
    start = start_;
    end = end_;
    realStart = start.copy();
    realEnd = end.copy();
  }

  private ArrayList<PVector> getFractalPoints(){
    ArrayList<PVector> fPoints = new ArrayList<PVector>();
    
    //WRITE CODE HERE
    //float len = sqrt((3.5 * 3.5) + 1);
    //float mag = 1 / len;
    
    PVector p = start.copy();
    
    PVector v = PVector.sub(start, end);
    v.div(2);

    PVector add = v.copy();
    add.rotate(radians(90));
    p.add(add);
    addC(fPoints, p);
    
    p.add(PVector.mult(v, -1));
    addC(fPoints, p);
    
    p.add(PVector.mult(v, -1));
    addC(fPoints, p);
    
    add.rotate(radians(180));
    p.add(add);
    addC(fPoints, p);
       
    //
    return fPoints;
  }

  private void addC(ArrayList<PVector> fp, PVector p){
    fp.add(p.copy());
  }

  public ArrayList<PVector> getChildPoints(){
    ArrayList<PVector> childPoints = new ArrayList<PVector>();
    
    childPoints.add(start.copy());
    
    for(PVector point : getFractalPoints()){
      childPoints.add(point);
    }
    
    childPoints.add(end.copy());
    return childPoints;
  }

  public PVector getA(){
    return start.copy();
  }
  
  public PVector getB(){
    return PVector.sub(end, start).div(3).add(start);
  }
  
  public PVector getC(){
    PVector v = PVector.sub(end, start);
    v.div(3);
    
    PVector p = start.copy();
    p.add(v);
    
    v.rotate(-radians(60));
    p.add(v);
    
    return p;
  }
  
  public PVector getD(){
    PVector v = PVector.sub(start, end);
    v.div(3);
    v.add(end);
    return v;
  }
  
  public PVector getE(){
    return end.copy();
  }
  
  void display(){
    //stroke(255);
    line(start.x, start.y, end.x, end.y);
  }
  
  
  
  
  
  
  
  
  
  
  
  
    
  public void goHome(){
    PVector dStart = PVector.sub(realStart, start);
    PVector dEnd = PVector.sub(realEnd, end);
    
    if(dStart.x < .1 && dStart.y < .1){
      start = realStart.copy();      
    }
    
    if(dEnd.x < .1 && dEnd.y < .1){
       end = realEnd.copy();
    }
    
    //the further away we are, the smaller mult should be
    float mulStart = 300;
    float mulEnd = 300;
    
    mulStart /= dStart.mag();
    mulEnd /= dEnd.mag();
    
    dStart.div(mulStart);
    dEnd.div(mulEnd);
    
    start.add(dStart);
    end.add(dEnd);
  }
  
  public void wiggle(){
    start.add(PVector.random2D());
    end.add(PVector.random2D());
  }
  
}
