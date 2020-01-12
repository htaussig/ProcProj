Car[] cars;

void setup(){
  size(400, 400);
  
  System.out.println("hello world");
  
  cars = new Car[10];
  
  int[] arr = new int[]{1, 2, 3, 4};
  //arr = new int[]{1, 2, 3, 4};
  for(int i = 0; i < arr.length; i++){
    System.out.println(arr[i]);
  }
  
  for(int i = 0; i < 10; i++){
    float vx = random(-1, 1);
    float vy = random(-1, 1);
    if(random(1) < .5){
      vx = 0;
    }
    else{
      vy = 0;
    }
    
    float r = random(1);
    if(r < 0){
      //cars[i] = new Truck(random(width), random(height), vx, vy);
    }
    else if(r < .66){
      cars[i] = new Car(random(width), random(height), vx, vy);
    }
    else{
      cars[i] = new MonsterTruck(random(width), random(height), vx, vy);
    }
  }
  
}

void draw(){
  background(255);
  for(Car c : cars){
    c.move();
    c.display();
  }
}
