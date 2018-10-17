// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

LSystem lsys;
Turtle turtle;

boolean recording = false;

void setup() {
  size(800, 800);
  /*
  // Create an empty ruleset
   Rule[] ruleset = new Rule[2];
   // Fill with two rules (These are rules for the Sierpinksi Gasket Triangle)
   ruleset[0] = new Rule('F',"F--F--F--G");
   ruleset[1] = new Rule('G',"GG");
   // Create LSystem with axiom and ruleset
   lsys = new LSystem("F--F--F",ruleset);
   turtle = new Turtle(lsys.getSentence(),width*2,TWO_PI/3);
   */

  /*Rule[] ruleset = new Rule[1];
   //ruleset[0] = new Rule('F',"F[F]-F+F[--F]+F-F");
   ruleset[0] = new Rule['F',"FF+[+F-F-F]-[-F+F+F]");
   lsys = new LSystem("F-F-F-F",ruleset);
   turtle = new Turtle(lsys.getSentence(),width-1,PI/2);
   */
   
  blendMode(DIFFERENCE);
  noStroke();
  
  ArrayList<Rule> ruleset = new ArrayList<Rule>();
  //ruleset.add(new Rule('F', "FF+[+F-F-F]-[-F+F+F]"));
  ruleset.add(new Rule('F', "FG[+F][-G]"));
  //ruleset.add(new Rule('F',"F+G[++F]--F"));
  
  lsys = new LSystem("F", ruleset);
  turtle = new Turtle(lsys.getSentence(), height/4, radians(60));
  frameRate(60);
  smooth(8);
  background(0);
  for(int i = 0; i < 10; i++){
   //mousePressed(); 
  }
}

void draw() { 
  background(0);
  //rect(0, 0, width, height);
  //fill(0);
  //text("Click mouse to generate", 10, height-10);

  translate(width/2, height / 2);
  rotate(-PI/2);
  turtle.render();
  
  if(recording){
    saveFrame("f###.gif");
      if (turtle.getTheta() >= radians(360))
        exit();
  }
  
}
//5 or 6
int counter = 0;

void mousePressed() {
  if (counter < 15) {
    pushMatrix();
    lsys.generate();
    //println(lsys.getSentence());
    turtle.setToDo(lsys.getSentence());
    turtle.changeLen(.8);
    popMatrix();
    redraw();
    counter++;
  }
}