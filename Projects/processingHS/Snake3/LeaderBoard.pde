String typing = "";
int score;
boolean isScoreMenu = false;
//PFont f;
int trying = -20;

ArrayList<String> highScores= new ArrayList<String>();

private String fileName = "LeaderBoard.txt";
  private String helperFile = "helper.txt";

void drawNameScreen(){

    int indent = (int) (-boxSize / 2) + 25;

    // Set the font and fill for text
    //textFont(f);
    fill(13, 232, 17);

    // Display everything
    translate(0, -boxSize / 2, boxSize / 2);
    text("You got a score of " + score + "!", indent, 40);
    text("Enter your name to save your high score! \nHit enter to save. ", indent, 80);
    text("Name: " + typing,indent, 170);
}

void drawClickAgain(){

    //textFont(createFont("", 32));
    noStroke();
    fill(16, 222, 229);
    translate(0, -boxSize / 2, boxSize / 2);
    text("You got a score of " + snake.limbs.size(), trying, 60);
    text("Click to play again!", trying, 40);
    trying++;
}

/*void updateLeaderBoard(PrintWriter wr, String name){
  String newEntry = name + ": " + score;
  for(int i = 0; i < highScores.size(); i++){
    String scoreName = highScores.get(i);
    
    int scoreIndex = scoreName.indexOf(':') + 2;
    String oldScoreString = scoreName.substring(scoreIndex);
    int oldScore = getNumericValue(oldScoreString);
    
    if(score > oldScore){
     highScores.add(i, newEntry);
     break;
    }
    else if(highScores.get(highScores.size() - 1) == scoreName){
     highScores.add(newEntry); 
     break;
    }
  }
  printArray(highScores);
}

int getNumericValue(String numString){
  int num = 0;
  int length = numString.length();
  for(int i = 0; i < length; i++){
    num += Character.getNumericValue(numString.charAt(i)) * Math.pow(10, length - 1);
  }
  return num;
}

private void recordScore(String name) {
    BufferedReader rd = openFile(fileName);
    int i = 0;
    
    try {
      
      PrintWriter wr = createWriter(helperFile);
      
      while (true) {
        String line = rd.readLine();
        if(line == null) break;
        wr.println(line);
      }
      
      //wr.println("it worked");
      
      rd.close();
      wr.close();
  
    } catch (IOException ex) {
      //throw ex;
      println("error");   //should throw something here
    } 
    
    
    rd = openFile(helperFile);
    
    try {
      
      PrintWriter wr = createWriter(fileName);
      
     
      while (true) {
        String line = rd.readLine();
        if(line == null) break;
        highScores.add(line);
        i++;
      }
      
      updateLeaderBoard(wr, name);
      
      for(String scoreName : highScores){
       wr.println(scoreName); 
      }
      
      highScores.clear();  //in case you play again
      
      rd.close();
      wr.close();
  
    } catch (IOException ex) {
      println("error");
      //throw ex;
    }
  }
  
  private BufferedReader openFile(String file){
    
    BufferedReader rd = null;
    
    while(rd == null){
      try{
        rd = createReader(file);
      } catch (Exception ex) {
        println("Cannot find data storing file");
      }
    }
    return rd;
    
  }*/
  
 