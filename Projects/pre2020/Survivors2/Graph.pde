public class Graph {

  float x, y, w, h;
  //data essentially contains y values, while the x values are implied as equidistant
  ArrayList<ArrayList<Float>> data = new ArrayList<ArrayList<Float>>();
  ArrayList<Integer> colors = new ArrayList<Integer>();
  int maxPointsDisplayed = 70;

  public Graph(float x_, float y_, float w_, float h_, ArrayList<ArrayList<Float>> data_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    data = data_;
    for (int i = 0; i < data_.size(); i++) {
      //colors.add(color(0));
    }
  }  

  public void addDataSet(ArrayList<Float> dataSet, color col) {
    data.add(dataSet);
    colors.add(color(0));
    setColor(data.size() - 1, col);
  }

  public void setColor(int index, color col) {
    if (index >= 0 && index < data.size()) {
      colors.add(index, col);
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
      float size = dataSet.size();

      //makes it so we only display pointsDisplayed max
      int simplify = (int) size / maxPointsDisplayed;
      if (simplify == 0) {
        simplify = 1;
      }
      
      //this whole sectino is confusing but seems to work, could be rewritten
      if (size > 1) {
        
        stroke(colors.get(j));
        float normalY1 = ((dataSet.get(0) - minY) / (diffY));
        float normalY2;
        //not sure if this should be size minus one
        float dX = ((size - 1) / simplify);
        for (int i = 0; i < dX - 1; i++) {
          int indexY2 = (i + 1) * simplify;
          //float drawX = x + (w * i / (size - 1));
          //float drawY = (-normalSet.get(i) * h) + y + h;
          //ellipse(drawX, drawY, w / (size * 2), w / (size * 2));
          normalY2 = ((dataSet.get(indexY2) - minY) / (diffY));
          float x1 = x + (w * i / dX);
          float y1 = (-normalY1 * h) + y + h;
          float x2 = x + (w * (i + 1) / dX);
          float y2 = (-normalY2 * h) + y + h;
          line(x1, y1, x2, y2);
          normalY1 = normalY2;
        }
      }
    }

    noFill();
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);

    fill(0);
    stroke(200);
    textAlign(LEFT, CENTER);
    text((int) maxY, x + w + 5, y);
    text((int) minY, x + w + 5, y + h);
  }
}
