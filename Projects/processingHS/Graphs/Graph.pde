public class Graph {

  float x, y, w, h;
  //data essentially contains y values, while the x values are implied as equidistant
  ArrayList<ArrayList<Float>> data = new ArrayList<ArrayList<Float>>();
  ArrayList<Integer> colors = new ArrayList<Integer>();

  public Graph(float x_, float y_, float w_, float h_, ArrayList<Float> dataSet_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    data.add(dataSet_);
    colors.add(color(255, 0, 0));
  }  

  public void addDataSet(ArrayList<Float> dataSet, color col){
    data.add(dataSet);
    colors.add(color(0));
    setColor(data.size() - 1, col);
  }

  public void setColor(int index, color col) {
    if (index >= 0 && index < data.size()) {
      colors.set(index, col);
    } else {
      System.out.println("invalid color index");
    }
  }

  public void display() {
    
    fill(255);
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h);
    
    float maxY = data.get(0).get(0);
    float minY = data.get(0).get(0);
    for (int j = 0; j < data.size(); j++) {
      ArrayList<Float> dataSet = data.get(j);
      int size = dataSet.size();    
      for (int i = 0; i < size; i++) {
        float tempY = dataSet.get(i);
        if  (tempY > maxY) {
          maxY = tempY;
        }
        if (tempY < minY) {
          minY = tempY;
        }
      }
    }

    float diffY = maxY - minY;

    for (int j = 0; j < data.size(); j++) {
      ArrayList<Float> dataSet = data.get(j);
      ArrayList<Float> normalSet = new ArrayList<Float>();
      float size = dataSet.size();
      for (int i = 0; i < size; i++) {
        normalSet.add((dataSet.get(i) - minY) / (diffY));
      }

      if (size > 1) {
        stroke(colors.get(j));
        for (int i = 0; i < size - 1; i++) {
          //float drawX = x + (w * i / (size - 1));
          //float drawY = (-normalSet.get(i) * h) + y + h;
          //ellipse(drawX, drawY, w / (size * 2), w / (size * 2));
          float x1 = x + (w * i / (size - 1));
          float y1 = (-normalSet.get(i) * h) + y + h;
          float x2 = x + (w * (i + 1) / (size - 1));
          float y2 = (-normalSet.get(i + 1) * h) + y + h;
          line(x1, y1, x2, y2);
        }
      }
    }
    
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h);
    
    fill(0);
    stroke(0);
    textAlign(LEFT, CENTER);
    text(maxY, x + w + 5, y);
    text(minY, x + w + 5, y + h);
  }
}
