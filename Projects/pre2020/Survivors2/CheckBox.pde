class CheckBox {
  int x, y;
  boolean checked;
  CheckBox(int _x, int _y){
    x = _x;
    y = _y;
    checked = false;
  }
  void display(){
    strokeWeight(1);
    stroke(255);
    fill(isOver()?128:64);
    rect(x, y, 20, 20);
    if(checked){
      line(x, y, x+20, y+20);
      line(x, y+20, x+20, y);
    }
  }
  void click(){
    if(isOver()){
      checked=!checked;
    }
  }
  boolean isOver(){
    return(mouseX>x&&mouseX<x+20&&mouseY>y&&mouseY<y+20);
  }
}
