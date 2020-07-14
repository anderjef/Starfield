//started 09/03/2019
//inspiration: https://www.youtube.com/watch?v=17WoOqgXsRM

Star[] stars = new Star[256];
int tailLength = 16;
boolean tailLengthErr = true;
boolean areTails = true;

void setup() {
  size(1600, 1600);
  for (int i = 0; i < stars.length; ++i) {
    if (tailLengthErr) {
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
  for (int i = 0; i < stars.length; ++i) {
      stars[i].update();
      stars[i].show();
  }
}
