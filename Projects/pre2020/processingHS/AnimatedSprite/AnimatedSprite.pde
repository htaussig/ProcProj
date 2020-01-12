PImage spriteSheet;
int h = 144;
int w = 192;
int numFrames = 7;
int framesPerRow = 3;
PImage[] animation;
//Sprite horse;
ArrayList<Sprite> horses;
float numHorses = 10;

void preload() {
  //not sure preload is a thing in processing
}

void setup() {
  size(640, 480);
  frameRate(14);
  horses = new ArrayList<Sprite>();
  spriteSheet = loadImage("horse.png");
  animation = new PImage[numFrames];
  for (int i = 0; i < numFrames; i++) {
    int x = (i % framesPerRow) * w;
    int y = h * (i / framesPerRow);
    PImage img = spriteSheet.get(x, y, w, h);
    animation[i] = img;
  }

  float imgH = animation[0].height;

  for (int i = 0; i < numHorses; i++) {
    horses.add(new Sprite(0, (height - imgH) * i / (numHorses), random(.2, 1), animation));
  }
}

void draw() {
  background(0);
  for (Sprite horse : horses) {
    horse.display();
    horse.animate();
  }
  //image(animation[frameCount % numFrames], 0, 0);
}
