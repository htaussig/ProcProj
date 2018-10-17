public class Road {

  float y;
  float r;
  float numCars;
  ArrayList<Car> cars;


  public Road(float y_, float r_,float numCars_, float startSpeed) {
    y = y_;
    r = r_;
    cars = new ArrayList<Car>();
    numCars = numCars_;
    for (int i = 0; i < numCars_; i++) {
      color col;
      if(i == 0){
        col = #FF0000;
      }
      else{
       col = color(0); 
      }
      cars.add(new Car((width / numCars_) * i, y, startSpeed, col));
    }
  }

  public void update() {
    for(int i = 0; i < cars.size(); i++){
        float diff = getDiff(i);
        cars.get(i).update(diff); 
     }
  }

  /** this should really be calculating the difference between where the two cars will be in a certain amount of time 
  **/
  public float getDiff(int i) {
    Car theCar = cars.get(i);
    Car otherCar = cars.get((i + 1) % cars.size());
    float t = 24;
    float otherX = otherCar.x + otherCar.vX * t;
    float x = theCar.x + theCar.vX * t;
    float diff = otherX - x;
    if(otherCar.x < theCar.x){
      diff += width;
    }
    return diff;
  }

  public void traffic(){
   cars.get(0).brake(); 
  }

  public void display() {
    float sum = 0;
    pushMatrix();
    translate(width / 2, height / 2);
    //line(0, y - 10, width, y - 10);
    //line(0, y + 10, width, y + 10);
    noFill();
    strokeWeight(2);
    ellipse(0, 0, r * 2 - 10, r * 2 - 10);
    ellipse(0, 0, r * 2 + 10, r * 2 + 10);
    for (Car car : cars) {
      car.display(r);
      sum += car.vX;
    }
    popMatrix();
    System.out.println("avg road speed: " + (sum / numCars));
  }
}