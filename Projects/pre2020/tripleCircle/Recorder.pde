boolean RECORDING = true;

void  doIfRecording(){
  if (RECORDING) {
       println("recording!!");
       saveFrame("movie/f#####-tripleCircle.png");
  }
}
