void setup() {
  size(512, 512);
  background(0xffffffff);
  noStroke();
  colorMode(HSB, 359, 99, 99);
  ellipseMode(RADIUS);
  textAlign(CENTER, CENTER);

  int count = 16;

  float centerX = width * 0.5;
  float centerY = height * 0.5;
  float radius = 42.0;
  float dist = min(height, width) * 0.5 - radius;
  float radToDeg = 180.0 / PI;
  float countToRad = TWO_PI / float(count);
  float angle, hue, x, y;

  String label = "";

  for (int i = 0; i < count; ++i) {
    angle = i * countToRad;
    hue = angle * radToDeg;
    x = centerX + cos(angle) * dist;
    y = centerY + sin(angle) * dist;
    label = ceil(hue) + "\u00b0";

    fill(color(correctToRGB(hue), 99, 99));
    ellipse(x, y, radius, radius);

    fill(0xff000000);
    text(label, x, y);
    fill(0xffffffff);
    text(label, x + 1, y - 1);
  }
}
