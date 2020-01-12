public class Spring{
 
  MouseJoint mouseJoint;
  
  public Spring(){
    
  }
  
  void update(float x, float y){
   if(mouseJoint != null){
    Vec2 mouseWorld = box2d.coordPixelsToWorld(x, y);
    mouseJoint.setTarget(mouseWorld);
   }
  }
  
  void bind(float x, float y, Displayable thing){
   MouseJointDef mjd = new MouseJointDef();
   
   mjd.bodyA = box2d.getGroundBody();
   mjd.bodyB = thing.body;
   
   Vec2 mp = box2d.coordPixelsToWorld(x, y);
   mjd.target.set(mp);
   
   mjd.maxForce = 5000.0/* * thing.body.m_mass*/;
   mjd.frequencyHz = 5;
   mjd.dampingRatio = 0.9;
   
   //Make the joint!
   mouseJoint = (MouseJoint) box2d.world.createJoint(mjd);
  }
  
  //get rid of the joint when the mouse is released
  void destroy(){
    if(mouseJoint != null){
     box2d.world.destroyJoint(mouseJoint);
     mouseJoint = null;
    }
  }
}