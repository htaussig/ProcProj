public abstract class Displayable{
  
  //ArrayList<ArrayList<Fixture>> bodyLists = new ArrayList<ArrayList<Fixture>>();
  
  //ArrayList<Fixture> fixtureList = new ArrayList<Fixture>();
  float margin;
     
  Body body;
  
  public abstract void display();
  
  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);

    if (pos.x < -margin || pos.x > width + margin || pos.y < - margin || pos.y > height + margin) {
      killBody();
      return true;
    }
    return false;
  }
   
  void killBody() {
    box2d.destroyBody(body);
  }
  
  /*boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    //Fixture f = body.getFixtureList();
    for(ArrayList<Fixture> fixtureList: bodyLists){    //need to make a getContainedBody method for this to work
      for(Fixture f: fixtureList){
        if(f.testPoint(worldPoint)){
         return true; 
        }
      }
    }
      
    return false;
  }*/
  
}