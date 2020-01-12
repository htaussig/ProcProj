public class Sprite{
  
  float index = 0;
  float speed;
  float x, y;
  int l;
  PImage[] animation;
  
  public Sprite(float x_, float y_, float speed_, PImage[] animation_){
    x = x_;
    y = y_;
    speed = speed_;
    animation = animation_;
    l = animation.length;
  }
  
  public void animate(){
    index += speed;
    x += speed * 27;
    if(x > width){
     x = -animation[0].width; 
    }
  }
  
  public void display(){
    image(animation[(int) index % l], x, y);
  }
}
