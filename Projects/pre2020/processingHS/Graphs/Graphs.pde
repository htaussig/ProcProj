
Graph graph;
ArrayList<Float> numbers = new ArrayList<Float>();
ArrayList<Float> numbers2 = new ArrayList<Float>();

void setup(){
  size(400, 400);
  float num = random(10);
  for(int i = 0; i < 10; i++){
    numbers.add(num);
    numbers2.add(num + 1);
    num += random(-1, 1);
    if(num < 0){
     num = 0; 
    }
  }
  graph = new Graph(50, 50, 300, 300, numbers);
  graph.addDataSet(numbers2, color(0, 255, 255));
}

void keyPressed(){
 numbers.add((float) key - 48); 
 numbers2.add((float) key -48 + random(-10, 10));
 graph.setColor((int) random(2), color(random(255), random(255), random(255)));
}

void draw(){
  background(255);
  graph.display();
}
