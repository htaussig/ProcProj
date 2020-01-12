public abstract class Displayable{
  
  //ArrayList<ArrayList<Fixture>> bodyLists = new ArrayList<ArrayList<Fixture>>();
  
  ArrayList<Fixture> fixtureList = new ArrayList<Fixture>();
     
  
  Body body;
  
  
  public abstract void display();
  
  public abstract boolean done();
  
  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    //Fixture f = body.getFixtureList();
    //for(ArrayList<Fixture> fixtureList: bodyLists){
      for(Fixture f: fixtureList){
        if(f.testPoint(worldPoint)){
         return true; 
        }
      }
   // }
      
    return false;
  }
  
}