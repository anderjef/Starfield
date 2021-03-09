//Jeffrey Andersen

Star[] stars = new Star[256];
int tailLength = 16;
boolean isTailLengthVariance = true;
boolean areTails = true;

void setup() {
  size(1600, 1600);
  for (int i = 0; i < stars.length; ++i) {
    if (isTailLengthVariance) {
      stars[i] = new Star(areTails, tailLength + int(random(-tailLength, tailLength)));
    }
    else {
      stars[i] = new Star(areTails, tailLength);
    }
  }
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  for (Star s : stars) {
    s.update();
    s.show();
  }
}
